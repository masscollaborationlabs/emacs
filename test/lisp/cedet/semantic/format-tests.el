;;; semantic/format-tests.el --- Parsing / Formatting tests -*- lexical-binding:t -*-

;; Copyright (C) 2003-2025 Free Software Foundation, Inc.

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

;; Unit tests for the formatting feature.
;;
;; Using test code from the tests source directory, parse the source
;; file.  After parsing, read the comments for each signature, and
;; make sure that the semantic-tag-format-* functions in question
;; created the desired output.

;;; Code:

(require 'ert)
(require 'ert-x)
(require 'semantic/format)

(defvar semantic-fmt-utest-file-list
  (list (ert-resource-file "test-fmt.cpp")
    ;; "tests/test-fmt.el" - add this when elisp is support by dflt in Emacs
    )
  "List of files to run unit tests in.")

(ert-deftest semantic-fmt-utest ()
  "Visit all file entries, and run formatting test. "
  (save-current-buffer
    (semantic-mode 1)
    (dolist (fname semantic-fmt-utest-file-list)
      (let ((fb (find-buffer-visiting fname))
            (b (semantic-find-file-noselect fname))
            (tags nil))
        (save-current-buffer
          (set-buffer b)
          (should (semantic-active-p))
          ;;(error "Cannot open %s for format tests" fname))

          ;; This will force a reparse, removing any chance of semanticdb cache
          ;; using stale data.
          (semantic-clear-toplevel-cache)
          ;; Force the reparse
          (setq tags (semantic-fetch-tags))

          (save-excursion
            (while tags
              (let* ((T (car tags))
                     (start (semantic-tag-end T))
                     (end (if (cdr tags)
                              (semantic-tag-start (car (cdr tags)))
                            (point-max)))
                     (TESTS nil))
                (goto-char start)
                ;; Scan the space between tags for all test condition matches.
                (while (re-search-forward "## \\([a-z-]+\\) \"\\([^\n\"]+\\)\"$" end t)
                  (push (cons (match-string 1) (match-string 2)) TESTS))
                (setq TESTS (nreverse TESTS))

                (dolist (TST TESTS)
                  (let* ( ;; For each test, convert CAR into a semantic-format-tag* fcn
                         (sym (intern (concat "semantic-format-tag-" (car TST))))
                         ;; Convert the desired result from a string syntax to a string.
                         (desired (cdr TST))
                         ;; What does the fmt function do?
                         (actual (funcall sym T)))
                    (when (not (string= desired actual))
                      (should-not (list "Desired" desired
                                        "Actual" actual
                                        "Formatter" (car TST)))))))
              (setq tags (cdr tags)))))

        ;; If it wasn't already in memory, whack it.
        (when (and b (not fb))
          (kill-buffer b))))))

(provide 'format-tests)

;;; format-tests.el ends here
