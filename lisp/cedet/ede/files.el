;;; ede/files.el --- Associate projects with files and directories.  -*- lexical-binding: t; -*-

;; Copyright (C) 2008-2025 Free Software Foundation, Inc.

;; Author: Eric M. Ludlam <zappo@gnu.org>

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Directory and File scanning and matching functions.
;;
;; Basic Model:
;;
;; A directory belongs to a project if an ede-project-autoload structure
;; matches your directory.
;;
;; A toplevel project is one where there is no active project above
;; it.  Finding the toplevel project involves going up a directory
;; till no ede-project-autoload structure matches.
;;

(require 'eieio)
(require 'ede)

(declare-function ede-locate-file-in-hash "ede/locate")
(declare-function ede-locate-add-file-to-hash "ede/locate")
(declare-function ede-locate-file-in-project "ede/locate")
(declare-function ede-locate-flush-hash "ede/locate")

(defvar ede--disable-inode nil
  "Set to t to simulate systems w/out inode support.")

;;; Code:
;;;###autoload
(defun ede-find-file (file)
  "Find FILE in project.  FILE can be specified without a directory.
There is no completion at the prompt.  FILE is searched for within
the current EDE project."
  (interactive "sFile: ")
  (let* ((proj (ede-current-project))
	 (fname (ede-expand-filename proj file))
	)
    (unless fname
      (error "Could not find %s in %s"
	     file
	     (ede-project-root-directory proj)))
    (find-file fname)))

(defun ede-flush-project-hash ()
  "Flush the file locate hash for the current project."
  (interactive)
  (require 'ede/locate)
  (let* ((loc (ede-get-locator-object (ede-current-project))))
    (when loc
      (ede-locate-flush-hash loc))))

;;; Placeholders for ROOT directory scanning on base objects
;;
(cl-defmethod ede-project-root ((this ede-project-placeholder))
  "If a project knows its root, return it here.
Allows for one-project-object-for-a-tree type systems."
  (oref this rootproject))

(cl-defmethod ede-project-root-directory ((this ede-project-placeholder)
				          &optional _file)
  "If a project knows its root, return it here.
Allows for one-project-object-for-a-tree type systems.
Optional FILE is the file to test.  It is ignored in preference
of the anchor file for the project."
  ;; (let ((root (or (ede-project-root this) this)))
  (file-name-directory (expand-file-name (oref this file)))) ;; )


;; Why INODEs?
;; An inode represents a unique ID that transcends symlinks, hardlinks, etc.
;; so when we cache an inode in a project, and hash directories to inodes, we
;; can avoid costly filesystem queries and regex matches.

(defvar ede-inode-directory-hash (make-hash-table
				  ;; Note on test.  Can we compare inodes or something?
				  :test 'equal)
  "A hash of directory names and inodes.")

(defun ede--put-inode-dir-hash (dir inode)
  "Add to the EDE project hash DIR associated with INODE."
  (puthash dir inode ede-inode-directory-hash)
  inode)

(defun ede--get-inode-dir-hash (dir)
  "Get the EDE project hash DIR associated with INODE."
  (gethash dir ede-inode-directory-hash))

(defun ede--inode-for-dir (dir)
  "Return the inode for the directory DIR."
  (let ((hashnode (ede--get-inode-dir-hash (expand-file-name dir))))
    (or hashnode
	(if ede--disable-inode
	    (ede--put-inode-dir-hash dir 0)
	  (let ((fattr (file-attributes dir)))
	    (ede--put-inode-dir-hash dir (file-attribute-inode-number fattr))
	    )))))

(cl-defmethod ede--project-inode ((proj ede-project-placeholder))
  "Get the inode of the directory project PROJ is in."
  (if (slot-boundp proj 'dirinode)
      (oref proj dirinode)
    (oset proj dirinode (ede--inode-for-dir (oref proj directory)))))

(defun ede--inode-get-toplevel-open-project (inode)
  "Return an already open toplevel project that is managing INODE.
Does not check subprojects."
  (when (or (and (numberp inode) (/= inode 0))
	    (consp inode))
    (let ((all ede-projects)
	  (found nil)
	  )
      (while (and all (not found))
	(when (equal inode (ede--project-inode (car all)))
	  (setq found (car all)))
	(setq all (cdr all)))
      found)))

;;; DIRECTORY IN OPEN PROJECT
;;
;; These routines match some directory name to one of the many pre-existing
;; open projects.  This should avoid hitting the disk, or asking lots of questions
;; if used throughout the other routines.

(defun ede-directory-get-open-project (dir &optional rootreturn)
  "Return an already open project that is managing DIR.
Optional ROOTRETURN specifies a `gv-ref' to set to the root project.
If DIR is the root project, then it is the same."
  (let* ((inode (ede--inode-for-dir dir))
	 (ft (file-name-as-directory (expand-file-name dir)))
	 (proj (ede--inode-get-toplevel-open-project inode))
	 (ans nil))
    ;; Try file based search.
    (when (or ede--disable-inode (not proj))
      (setq proj (ede-directory-get-toplevel-open-project ft)))
    ;; Default answer is this project
    (setq ans proj)
    ;; Save.
    (when rootreturn (if (symbolp rootreturn) (set rootreturn proj)
                       (setf (gv-deref rootreturn) proj)))
    ;; Find subprojects.
    (when (and proj (if ede--disable-inode
			(not (string= ft (expand-file-name
                                          (oref proj directory))))
		      (not (equal inode (ede--project-inode proj)))))
      (setq ans (ede-find-subproject-for-directory proj ft)))
    ans))

;; Force all users to switch to `ede-directory-get-open-project'
;; for performance reasons.
(defun ede-directory-get-toplevel-open-project (dir &optional exact)
  "Return an already open toplevel project that is managing DIR.
If optional EXACT is non-nil, only return exact matches for DIR."
  (let ((ft (file-name-as-directory (expand-file-name dir)))
	(all ede-projects)
	(ans nil)
	(shortans nil))
    (while (and all (not ans))
      ;; Do the check.
      (let ((pd (expand-file-name (oref (car all) directory))))
	(cond
	 ;; Exact text match.
	 ((string= pd ft)
	  (setq ans (car all)))
	 ;; Some sub-directory
	 ((and (not exact) (string-match (concat "^" (regexp-quote pd)) ft))
	  (if (not shortans)
	      (setq shortans (car all))
	    ;; We already have a short answer, so see if pd (the match we found)
	    ;; is longer.  If it is longer, then it is more precise.
	    (when (< (length (oref shortans directory))
		     (length pd))
	      (setq shortans (car all))))
	  )
	 ;; Exact inode match.  Useful with symlinks or complex automounters.
	 ((and (not ede--disable-inode)
	       (let ((pin (ede--project-inode (car all)))
		     (inode (ede--inode-for-dir dir)))
		 (and (not (eql pin 0)) (equal pin inode))))
	  (setq ans (car all)))
	 ;; Subdir via truename - slower by far, but faster than a traditional lookup.
	 ;; Note that we must resort to truename in order to resolve issues such as
	 ;; cross-symlink projects.
	 ((and (not exact)
	       (let ((ftn (file-truename ft))
		     (ptd (file-truename pd)))
		 (string-match (concat "^" (regexp-quote ptd)) ftn)))
	  (if (not shortans)
	      (setq shortans (car all))
	    ;; We already have a short answer, so see if pd (the match we found)
	    ;; is longer.  If it is longer, then it is more precise.
	    (when (< (length (expand-file-name (oref shortans directory)))
		     (length pd))
	      (setq shortans (car all))))
	  )))
      (setq all (cdr all)))
    ;; If we have an exact answer, use that, otherwise use
    ;; the short answer we found -> ie - we are in a subproject.
    (or ans shortans)))

(cl-defmethod ede-find-subproject-for-directory ((proj ede-project-placeholder)
					      dir)
  "Find a subproject of PROJ that corresponds to DIR."
  (if ede--disable-inode
      (let ((ans nil)
	    (fulldir (file-truename dir)))
	;; Try to find the right project w/out inodes.
	(ede-map-subprojects
	 proj
	 (lambda (SP)
	   (when (not ans)
	     (if (string= fulldir (file-truename (oref SP directory)))
		 (setq ans SP)
	       (ede-find-subproject-for-directory SP dir)))))
	ans)
    ;; We can use inodes, so let's try it.
    (let ((ans nil)
	  (inode (ede--inode-for-dir dir)))
      (ede-map-subprojects
       proj
       (lambda (SP)
	 (when (not ans)
	   (if (equal (ede--project-inode SP) inode)
	       (setq ans SP)
	     (setq ans (ede-find-subproject-for-directory SP dir))))))
      ans)))

;;; DIRECTORY HASH
;;
;; The directory hash matches expanded directory names to already detected
;; projects.  By hashing projects to directories, we can detect projects in
;; places we have been before much more quickly.

(defvar ede-project-directory-hash (make-hash-table
				    ;; Note on test.  Can we compare inodes or something?
				    :test 'equal)
  "A hash of directory names and associated EDE objects.")

(defun ede-flush-directory-hash ()
  "Flush the project directory hash.
Do this only when developing new projects that are incorrectly putting
`nomatch' tokens into the hash."
  (interactive)
  (setq ede-project-directory-hash (make-hash-table :test 'equal))
  ;; Also slush the current project's locator hash.
  (let ((loc (ede-get-locator-object ede-object)))
    (when loc
      (ede-locate-flush-hash loc)))
  )

(defun ede-project-directory-remove-hash (dir)
  "Reset the directory hash for DIR.
Do this whenever a new project is created, as opposed to loaded."
  ;; TODO - Use maphash, and delete by regexp, not by dir searching!
  (setq dir (expand-file-name dir))
  (remhash (file-name-as-directory dir) ede-project-directory-hash)
  ;; Look for all subdirs of D, and remove them.
  (let ((match (concat "^" (regexp-quote dir))))
    (maphash (lambda (K _O)
               (when (string-match match K)
                 (remhash K ede-project-directory-hash)))
             ede-project-directory-hash)))

(defun ede--directory-project-from-hash (dir)
  "If there is an already loaded project for DIR, return it from the hash."
  (setq dir (expand-file-name dir))
  (gethash dir ede-project-directory-hash))

(defun ede--directory-project-add-description-to-hash (dir desc)
  "Add to the EDE project hash DIR associated with DESC."
  (setq dir (expand-file-name dir))
  (puthash dir desc ede-project-directory-hash)
  desc)

;;; DIRECTORY-PROJECT-P, -CONS
;;
;; These routines are useful for detecting if a project exists
;; in a provided directory.
;;
;; Note that -P provides less information than -CONS, so use -CONS
;; instead so that -P can be obsoleted.
(defun ede-directory-project-p (dir &optional force)
  "Return a project description object if DIR is in a project.
Optional argument FORCE means to ignore a hash-hit of `nomatch'.
This depends on an up to date `ede-project-class-files' variable.
Any directory that contains the file .ede-ignore will always
return nil.

Consider using `ede-directory-project-cons' instead if the next
question you want to ask is where the root of found project is."
  ;; @TODO - We used to have a full impl here, but moved it all
  ;;         to ede-directory-project-cons, and now hash contains only
  ;;         the results of detection which includes the root dir.
  ;;         Perhaps we can eventually remove this fcn?
  (let ((detect (ede-directory-project-cons dir force)))
    (cdr detect)))

(defun ede-directory-project-cons (dir &optional force)
  "Return a project CONS (ROOTDIR . AUTOLOAD) for DIR.
If there is no project in DIR, return nil.
Optional FORCE means to ignore the hash of known directories."
  (when (not (file-exists-p (expand-file-name ".ede-ignore" dir)))
    (let* ((dirtest (expand-file-name dir))
	   (match (ede--directory-project-from-hash dirtest)))
      (cond
       ((and (eq match 'nomatch) (not force))
	nil)
       ((and match (not (eq match 'nomatch)))
	match)
       (t
	;; First time here?  Use the detection code to identify if we have
	;; a project here.
	(let* ((detect (ede-detect-directory-for-project dirtest))
	       (autoloader (cdr detect))) ;; autoloader
	  (when autoloader (require (oref autoloader file)))
	  (ede--directory-project-add-description-to-hash dirtest (or detect 'nomatch))
	  detect)
	)))))


;;; TOPLEVEL
;;
;; These utilities will identify the "toplevel" of a project.
;;
;; NOTE: This -toplevel- function returns a directory even though
;;       the function name implies a project.

(defun ede-toplevel-project (dir)
  "Starting with DIR, find the toplevel project directory.
If DIR is not part of a project, return nil."
  (let ((ans nil))

    (cond
     ;; Check if it is cached in the current buffer.
     ((and (string= dir default-directory)
	   ede-object-root-project)
      ;; Try the local buffer cache first.
      (oref ede-object-root-project directory))

     ;; See if there is an existing project in DIR.
     ((setq ans (ede-directory-get-toplevel-open-project dir))
      (oref ans directory))

     ;; Detect using our file system detector.
     ((setq ans (ede-detect-directory-for-project dir))
      (car ans))

     (t nil))))

;;; DIRECTORY CONVERSION STUFF
;;
(cl-defmethod ede-convert-path ((this ede-project) path)
  "Convert path in a standard way for a given project.
Default to making it project relative.
Argument THIS is the project to convert PATH to."
  (let ((pp (ede-project-root-directory this))
	(fp (expand-file-name path)))
    (if (string-match (regexp-quote pp) fp)
	(substring fp (match-end 0))
      (let ((pptf (file-truename pp))
	    (fptf (file-truename fp)))
	(if (string-match (regexp-quote pptf) fptf)
	    (substring fptf (match-end 0))
	  (error "Cannot convert relativize path %s" fp))))))

(cl-defmethod ede-convert-path ((this ede-target) path &optional project)
  "Convert path in a standard way for a given project.
Default to making it project relative.
Argument THIS is the project to convert PATH to.
Optional PROJECT is the project that THIS belongs to.  Associating
a target to a project is expensive, so using this can speed things up."
  (let ((proj (or project (ede-target-parent this))))
    (if proj
	(let ((p (ede-convert-path proj path))
	      (lp (or (oref this path) "")))
	  ;; Our target THIS may have path information.
	  ;; strip this out of the conversion.
	  (if (string-match (concat "^" (regexp-quote lp)) p)
	      (substring p (length lp))
	    p))
      (error "Parentless target %s" this))))

;;; FILENAME EXPANSION
;;
(defun ede-get-locator-object (proj)
  "Get the locator object for project PROJ.
Get it from the toplevel project.  If it doesn't have one, make one."
  ;; Make sure we have a location object available for
  ;; caching values, and for locating things more robustly.
  (let ((top (ede-toplevel proj)))
    (when top
      (when (not (slot-boundp top 'locate-obj))
	(ede-enable-locate-on-project top))
      (oref top locate-obj)
      )))

(cl-defmethod ede-expand-filename ((this ede-project) filename &optional force)
  "Return a fully qualified file name based on project THIS.
FILENAME should be just a filename which occurs in a directory controlled
by this project.
Optional argument FORCE forces the default filename to be provided even if it
doesn't exist.
If FORCE equals `newfile', then the cache is ignored and a new file in THIS
is returned."
  (require 'ede/locate)
  (let* ((loc (ede-get-locator-object this))
	 (ha (ede-locate-file-in-hash loc filename))
	 (ans nil)
	 )
    ;; NOTE: This function uses a locator object, which keeps a hash
    ;; table of files it has found in the past.  The hash table is
    ;; used to make commonly found file very fast to location.  Some
    ;; complex routines, such as smart completion asks this question
    ;; many times, so doing this speeds things up, especially on NFS
    ;; or other remote file systems.

    ;; As such, special care is needed to use the hash, and also obey
    ;; the FORCE option, which is needed when trying to identify some
    ;; new file that needs to be created, such as a Makefile.
    (cond
     ;; We have a hash-table match, AND that match wasn't the 'nomatch
     ;; flag, we can return it.
     ((and ha (not (eq ha 'nomatch)))
      (setq ans ha))
     ;; If we had a match, and it WAS no match, then we need to look
     ;; at the force-option to see what to do.  Since ans is already
     ;; nil, then we do nothing.
     ((and (eq ha 'nomatch) (not (eq force 'newfile)))
      nil)
     ;; We had no hash table match, so we have to look up this file
     ;; using the usual EDE file expansion rules.
     (t
      (let ((calc (ede-expand-filename-impl this filename)))
	(if calc
	    (progn
	      (ede-locate-add-file-to-hash loc filename calc)
	      (setq ans calc))
	  ;; If we failed to calculate something, we
	  ;; should add it to the hash, but ONLY if we are not
	  ;; going to FORCE the file into existence.
	  (when (not force)
	    (ede-locate-add-file-to-hash loc filename 'nomatch))))
      ))
    ;; Now that all options have been queried, if the FORCE option is
    ;; true, but ANS is still nil, then we can make up a file name.

    ;; Is it forced?
    (when (and force (not ans))
      (let ((dir (ede-project-root-directory this)))
	(setq ans (expand-file-name filename dir))))

    ans))

(cl-defmethod ede-expand-filename-impl ((this ede-project) filename &optional _force)
  "Return a fully qualified file name based on project THIS.
FILENAME should be just a filename which occurs in a directory controlled
by this project.
Optional argument FORCE forces the default filename to be provided even if it
doesn't exist."
  (let ((loc (ede-get-locator-object this))
	;; (path (ede-project-root-directory this))
	;; (proj (oref this subproj))
	(found nil))
    ;; find it Locally.
    (setq found (or (ede-expand-filename-local this filename)
		    (ede-expand-filename-impl-via-subproj this filename)))
    ;; Use an external locate tool.
    (when (not found)
      (require 'ede/locate)
      (setq found (car (ede-locate-file-in-project loc filename))))
    ;; Return it
    found))

(cl-defmethod ede-expand-filename-local ((this ede-project) filename)
  "Expand filename locally to project THIS with filesystem tests."
  (let ((path (ede-project-root-directory this)))
    (cond ((file-exists-p (expand-file-name filename path))
	   (expand-file-name filename path))
	  ((file-exists-p (expand-file-name  (concat "include/" filename) path))
	   (expand-file-name (concat "include/" filename) path)))))

(cl-defmethod ede-expand-filename-impl-via-subproj ((this ede-project) filename)
  "Return a fully qualified file name based on project THIS.
FILENAME should be just a filename which occurs in a directory controlled
by this project."
  (let ((proj (list (ede-toplevel this)))
	(found nil))
    ;; find it Locally.
    (while (and (not found) proj)
      (let ((thisproj (car proj)))
	(setq proj (append (cdr proj) (oref thisproj subproj)))
	(setq found (when thisproj
		      (ede-expand-filename-local thisproj filename)))
	))
    ;; Return it
    found))

(cl-defmethod ede-expand-filename ((this ede-target) filename &optional force)
  "Return a fully qualified file name based on target THIS.
FILENAME should be a filename which occurs in a directory in which THIS works.
Optional argument FORCE forces the default filename to be provided even if it
doesn't exist."
  (ede-expand-filename (ede-target-parent this) filename force))

;;; UTILITIES
;;

(defun ede-up-directory (dir)
  "Return a dir that is up one directory.
Argument DIR is the directory to trim upwards."
  (let* ((fad (directory-file-name dir))
	 (fnd (file-name-directory fad)))
    (if (string= dir fnd) ; This will catch the old string-match against
			  ; c:/ for DOS like systems.
	nil
      fnd)))

(define-obsolete-function-alias 'ede-toplevel-project-or-nil #'ede-toplevel-project "29.1")

(provide 'ede/files)

;; Local variables:
;; generated-autoload-file: "loaddefs.el"
;; generated-autoload-load-name: "ede/files"
;; End:

;;; ede/files.el ends here
