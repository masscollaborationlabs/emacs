;;; latin-pre.el --- Quail packages for inputting various European characters  -*-coding: utf-8; lexical-binding: t -*-

;; Copyright (C) 1997-2025 Free Software Foundation, Inc.
;; Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
;;   2006, 2007, 2008, 2009, 2010, 2011
;;   National Institute of Advanced Industrial Science and Technology (AIST)
;;   Registration Number H14PRO021

;; Keywords: mule, multilingual, latin, input method

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

;; Key translation maps were originally copied from iso-acc.el.
;; latin-1-prefix: extra special characters added, adapted from the vim
;;                 digraphs (from J.H.M.Dassen <jdassen@wi.leidenuniv.nl>)
;;                 by R.F. Smith <rsmith@xs4all.nl>
;;
;; polish-slash:
;; Author: Włodek Bzyl <matwb@univ.gda.pl>
;;
;; latin-[89]-prefix: Dave Love <fx@gnu.org>
;;
;; polish-prefix:
;; Author: Wojciech Gac <wojciech.s.gac@gmail.com>

;; You might make extra input sequences on the basis of the X
;; locale/*/Compose files (which have both prefix and postfix
;; sequences), but bear in mind that sequences which are logical in
;; that context may not be sensible when they're not signaled with
;; the Compose key.  An example is a double space for NBSP.

;;; Code:

(require 'quail)

(quail-define-package
 "latin-1-prefix" "Latin-1" "1>" t
 "Latin-1 characters input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á, \\='\\=' -> ´
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"a -> ä  \"\" -> ¨
    tilde    |   ~    | ~a -> ã
   cedilla   |   ~    | ~c -> ç
    misc     | \" ~ /  | \"s -> ß  ~d -> ð  ~t -> þ  /a -> å  /e -> æ  /o -> ø
   symbol    |   ~    | ~> -> »  ~< -> «  ~! -> ¡  ~? -> ¿  ~~ -> ¸
             |   ~    | ~s -> §  ~x -> ¤  ~. -> ·  ~$ -> £  ~u -> µ
             |   ~    | ~p -> ¶  ~- -> ­  ~= -> ¯  ~| -> ¦
   symbol    |  _ /   | _o -> º  _a -> ª  // -> °  /\\ -> ×  _y -> ¥
             |  _ /   | _: -> ÷  /c -> ¢  /2 -> ½  /4 -> ¼  /3 -> ¾
             |  _ /   | /= -> ¬
   symbol    |   ^    | ^r -> ®  ^c -> ©  ^1 -> ¹  ^2 -> ²  ^3 -> ³
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'Y" ?Ý)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("'y" ?ý)
 ("''" ?´)
 ("' " ?')
 ("`A" ?À)
 ("`E" ?È)
 ("`I" ?Ì)
 ("`O" ?Ò)
 ("`U" ?Ù)
 ("`a" ?à)
 ("`e" ?è)
 ("`i" ?ì)
 ("`o" ?ò)
 ("`u" ?ù)
 ("``" ?`)
 ("` " ?`)
 ("^A" ?Â)
 ("^E" ?Ê)
 ("^I" ?Î)
 ("^O" ?Ô)
 ("^U" ?Û)
 ("^a" ?â)
 ("^e" ?ê)
 ("^i" ?î)
 ("^o" ?ô)
 ("^u" ?û)
 ("^^" ?^)
 ("^ " ?^)
 ("\"A" ?Ä)
 ("\"E" ?Ë)
 ("\"I" ?Ï)
 ("\"O" ?Ö)
 ("\"U" ?Ü)
 ("\"a" ?ä)
 ("\"e" ?ë)
 ("\"i" ?ï)
 ("\"o" ?ö)
 ("\"s" ?ß)
 ("\"u" ?ü)
 ("\"y" ?ÿ)
 ("\"\"" ?¨)
 ("\" " ?\")
 ("~A" ?Ã)
 ("~C" ?Ç)
 ("~D" ?Ð)
 ("~N" ?Ñ)
 ("~O" ?Õ)
 ("~T" ?Þ)
 ("~a" ?ã)
 ("~c" ?ç)
 ("~d" ?ð)
 ("~n" ?ñ)
 ("~o" ?õ)
 ("~t" ?þ)
 ("~>" ?\»)
 ("~<" ?\«)
 ("~!" ?¡)
 ("~?" ?¿)
 ("~~" ?¸)
 ("~ " ?~)
 ("/A" ?Å)
 ("/E" ?Æ)
 ("/O" ?Ø)
 ("/a" ?å)
 ("/e" ?æ)
 ("/o" ?ø)
 ("//" ?°)
 ("/ " ?/)
 ("_o" ?º)
 ("_a" ?ª)
 ("_ " ? )
;; Symbols added by Roland Smith <rsmith@xs4all.nl>
 ("_+" ?±)
 ("_y" ?¥)
 ("_:" ?÷)
 ("__" ?_)
 ("/c" ?¢)
 ("/\\" ?×)
 ("/2" ?½)
 ("/4" ?¼)
 ("/3" ?¾)
 ("~s" ?§)
 ("~p" ?¶)
 ("~x" ?¤)
 ("~." ?·)
 ("~$" ?£)
 ("~u" ?µ)
 ("^r" ?®)
 ("^c" ?©)
 ("^1" ?¹)
 ("^2" ?²)
 ("^3" ?³)
 ("~-" ?­)
 ("~|" ?¦)
 ("/=" ?¬)
 ("~=" ?¯)
)

(quail-define-package
 "catalan-prefix" "Latin-1" "CA>" t
 "Catalan and Spanish input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á   \\='\\=' -> ´
    grave    |   \\=`    | \\=`a -> à
  diaeresis  |   \"    | \"i -> ï   \"\" -> ¨
    tilde    |   ~    | ~n -> ñ
   cedilla   |   ~    | ~c -> ç
  middle dot |   ~    | ~. -> ·
   symbol    |   ~    | ~> -> »   ~< -> «   ~! -> ¡   ~? -> ¿
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("' " ?')
 ("`A" ?À)
 ("`E" ?È)
 ("`O" ?Ò)
 ("`a" ?à)
 ("`e" ?è)
 ("`o" ?ò)
 ("` " ?`)
 ("\"I" ?Ï)
 ("\"U" ?Ü)
 ("\"i" ?ï)
 ("\"u" ?ü)
 ("\" " ?\")
 ("~C" ?Ç)
 ("~N" ?Ñ)
 ("~c" ?ç)
 ("~n" ?ñ)
 ("~>" ?\»)
 ("~<" ?\«)
 ("~!" ?¡)
 ("~?" ?¿)
 ("~." ?·)
 ("~ " ?~)
)

(quail-define-package
 "esperanto-prefix" "Latin-3" "EO>" t
 "Esperanto input method with prefix modifiers
Key translation rules are:
 ^H -> ?Ĥ   ^J -> ?Ĵ   ^h -> ?ĥ   ^j -> ?ĵ   ^C -> ?Ĉ   ^G -> ?Ĝ,
 ^S -> ?Ŝ   ^c -> ?ĉ   ^g -> ?ĝ   ^s -> ?ŝ   ~U -> ?Ŭ   ~u -> ?ŭ
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("^H" ?Ĥ)
 ("^J" ?Ĵ)
 ("^h" ?ĥ)
 ("^j" ?ĵ)
 ("^C" ?Ĉ)
 ("^G" ?Ĝ)
 ("^S" ?Ŝ)
 ("^c" ?ĉ)
 ("^g" ?ĝ)
 ("^s" ?ŝ)
 ("^^" ?^)
 ("^ " ?^)
 ("~U" ?Ŭ)
 ("~u" ?ŭ)
 ("~ " ?~)
)

(quail-define-package
 "french-prefix" "French" "FR>" t
 "French (Français) input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='e -> é
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"i -> ï
   cedilla   | ~ or , | ~c -> ç   ,c -> ç
   symbol    |   ~    | ~> -> »   ~< -> «
    misc     |   /    | /o -> œ
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'E" ?É)
 ("'C" ?Ç)
 ("'e" ?é)
 ("'c" ?ç)
 ("' " ?')
 ("`A" ?À)
 ("`E" ?È)
 ("`U" ?Ù)
 ("`a" ?à)
 ("`e" ?è)
 ("`u" ?ù)
 ("` " ?`)
 ("^A" ?Â)
 ("^E" ?Ê)
 ("^I" ?Î)
 ("^O" ?Ô)
 ("^U" ?Û)
 ("^a" ?â)
 ("^e" ?ê)
 ("^i" ?î)
 ("^o" ?ô)
 ("^u" ?û)
 ("^ " ?^)
 ("\"E" ?Ë)
 ("\"I" ?Ï)
 ("\"e" ?ë)
 ("\"i" ?ï)
 ("\" " ?\")
 ("/o" ?œ)
 ("/O" ?Œ)
 ("/ " ?/)
 ("~<" ?\«)
 ("~>" ?\»)
 ("~C" ?Ç)
 ("~c" ?ç)
 ("~ " ?~)
 (",C" ?Ç)
 (",c" ?ç)
 (",," ?,)
)

(quail-define-package
 "romanian-prefix" "Romanian" "RO>" t
 "Romanian (româneşte) input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+------------------
    breve    |   ~    | ~a -> ă
  circumflex |   ^    | ^a -> â, ^i -> î
   cedilla   |   ,    | ,s -> ş, ,t -> ţ
   ~         |   ~    | ~~ -> ~
   ^         |   ^    | ^^ -> ^
   ,         |   ,    | ,, -> ,
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("~A" ?Ă) ("~a" ?ă)
 ("^A" ?Â) ("^a" ?â)
 ("^I" ?Î) ("^i" ?î)
 (",S" ?Ş) (",s" ?ş)
 (",T" ?Ţ) (",t" ?ţ)
 ("^^" ?^) ("~~" ?~) (",," ?,))

(quail-define-package
 "romanian-alt-prefix" "Romanian" "RO>" t
 "Alternative Romanian (româneşte) input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+------------------
    breve    |   \\='    | \\='a -> ă
 circumflex  |  \" \\='   | \"a -> â  \\='i -> î
   cedilla   |   \\='    | \\='s -> ş  \\='t -> ţ
      \\='      |   \\='    | \\='\\=' -> \\='
      \"      |   \"    | \"\" -> \"
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Ă) ("'a" ?ă)
 ("\"A" ?Â) ("\"a" ?â)
 ("'I" ?Î) ("'i" ?î)
 ("'S" ?Ş) ("'s" ?ş)
 ("'T" ?Ţ) ("'t" ?ţ)
 ("''" ?') ("\"\"" ?\"))

(quail-define-package
 "german-prefix" "German" "DE>" t
 "German (Deutsch) input method with prefix modifiers
Key translation rules are:
 \"A -> Ä ->   \"O -> Ö   \"S -> ẞ   \"U -> Ü   \"s -> ß
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("\"A" ?Ä)
 ("\"O" ?Ö)
 ("\"U" ?Ü)
 ("\"S" ?ẞ)
 ("\"a" ?ä)
 ("\"o" ?ö)
 ("\"u" ?ü)
 ("\"s" ?ß)
 ("\" " ?\")
)

(quail-define-package
 "irish-prefix" "Latin-1" "GA>" t
 "Irish input method with prefix modifiers
Key translation rules are:
 \\='A -> Á   \\='E -> É   \\='I -> Í   \\='O -> Ó   \\='U -> Ú
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("' " ?')
)

(quail-define-package
 "portuguese-prefix" "Latin-1" "PT>" t
 "Portuguese input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á   \\='\\=' -> ´
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"u -> ü
    tilde    |   ~    | ~a -> ã
   cedilla   | \\=' or , | \\='c -> ç   ,c -> ç
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'C" ?Ç)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("'c" ?ç)
 ("' " ?')
 ("`A" ?À)
 ("`a" ?à)
 ("` " ?`)
 ("^A" ?Â)
 ("^E" ?Ê)
 ("^O" ?Ô)
 ("^a" ?â)
 ("^e" ?ê)
 ("^o" ?ô)
 ("^ " ?^)
 ("\"U" ?Ü)
 ("\"u" ?ü)
 ("\" " ?\")
 ("~A" ?Ã)
 ("~O" ?Õ)
 ("~a" ?ã)
 ("~o" ?õ)
 ("~ " ?~)
 (",c" ?ç)
 (",C" ?Ç)
 (",," ?,)
)

(quail-define-package
 "spanish-prefix" "Spanish" "ES>" t
 "Spanish (Español) input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á
  diaeresis  |   \"    | \"u -> ü
    tilde    |   ~    | ~n -> ñ
   symbol    |   ~    | ~> -> »   ~< -> «   ~! -> ¡   ~? -> ¿
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("' " ?')
 ("\"U" ?Ü)
 ("\"u" ?ü)
 ("\" " ?\")
 ("~N" ?Ñ)
 ("~n" ?ñ)
 ("~>" ?\»)
 ("~<" ?\«)
 ("~!" ?¡)
 ("~?" ?¿)
 ("~ " ?~)
)

(quail-define-package
 "latin-2-prefix" "Latin-2" "2>" t
 "Latin-2 characters input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á   \\='\\=' -> ?´
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"a -> ä   \"\" -> ¨
    breve    |   ~    | ~a -> ă
    caron    |   ~    | ~c -> č
   cedilla   |   \\=`    | \\=`c -> ç   \\=`e -> ?ę
    misc     | \\=' \\=` ~  | \\='d -> đ   \\=`l -> ł   \\=`z -> ż   ~o -> ő   ~u -> ű
   symbol    |   ~    | \\=`. -> ˙   ~~ -> ˘   ~. -> ?¸
"
 '(("\C-?" . quail-delete-last-char)
   (">" . quail-next-translation)
   ("\C-f" . quail-next-translation)
   ([right] . quail-next-translation)
   ("<" . quail-prev-translation)
   ("\C-b" . quail-prev-translation)
   ([left] . quail-prev-translation))
 t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'C" ?Ć)
 ("'D" ?Đ)
 ("'E" ?É)
 ("'I" ?Í)
 ("'L" ?Ĺ)
 ("'N" ?Ń)
 ("'O" ?Ó)
 ("'R" ?Ŕ)
 ("'S" ?Ś)
 ("'U" ?Ú)
 ("'Y" ?Ý)
 ("'Z" ?Ź)
 ("'a" ?á)
 ("'c" ?ć)
 ("'d" ?đ)
 ("'e" ?é)
 ("'i" ?í)
 ("'l" ?ĺ)
 ("'n" ?ń)
 ("'o" ?ó)
 ("'r" ?ŕ)
 ("'s" ?ś)
 ("'u" ?ú)
 ("'y" ?ý)
 ("'z" ?ź)
 ("''" ?´)
 ("' " ?')
 ("`A" ?Ą)
 ("`C" ?Ç)
 ("`E" ?Ę)
 ("`L" ?Ł)
 ("`S" "ŞȘ")
 ("`T" "ŢȚ") ; the second variant is for Romanian
 ("`Z" ?Ż)
 ("`a" ?ą)
 ("`l" ?ł)
 ("`c" ?ç)
 ("`e" ?ę)
 ("`s" "şș")
 ("`t" "ţț") ; the second variant is for Romanian
 ("`z" ?ż)
 ("``" ?Ş)
 ("`." ?˙)
 ("` " ?`)
 ("^A" ?Â)
 ("^I" ?Î)
 ("^O" ?Ô)
 ("^a" ?â)
 ("^i" ?î)
 ("^o" ?ô)
 ("^^" ?^)
 ("^ " ?^)
 ("\"A" ?Ä)
 ("\"E" ?Ë)
 ("\"O" ?Ö)
 ("\"U" ?Ü)
 ("\"a" ?ä)
 ("\"e" ?ë)
 ("\"o" ?ö)
 ("\"s" ?ß)
 ("\"u" ?ü)
 ("\"\"" ?¨)
 ("\" " ?\")
 ("~A" ?Ă)
 ("~C" ?Č)
 ("~D" ?Ď)
 ("~E" ?Ě)
 ("~L" ?Ľ)
 ("~N" ?Ň)
 ("~O" ?Ő)
 ("~R" ?Ř)
 ("~S" ?Š)
 ("~T" ?Ť)
 ("~U" ?Ű)
 ("~Z" ?Ž)
 ("~a" ?ă)
 ("~c" ?č)
 ("~d" ?ď)
 ("~e" ?ě)
 ("~l" ?ľ)
 ("~n" ?ň)
 ("~o" ?ő)
 ("~r" ?ř)
 ("~s" ?š)
 ("~t" ?ť)
 ("~u" ?ű)
 ("~z" ?ž)
 ("~v" ?˘)
 ("~~" ?˘)
 ("~." ?¸)
 ("~ " ?~)
)

(quail-define-package
 "latin-3-prefix" "Latin-3" "3>" t
 "Latin-3 characters input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á   \\='\\=' -> ?´
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"a -> ä   \"\" -> ¨
   cedilla   |   ~    | ~c -> ç   ~s -> ş   ~~ -> ¸
  dot above  |   / .  | /g -> ġ   .g -> ġ
    misc     | \" ~ /  | \"s -> ß   ~g -> ğ   ~u -> ŭ   /h -> ħ   /i -> ı
   symbol    |   ~    | ~\\=` -> ˘   /# -> £   /$ -> ¤   // -> °
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("''" ?´)
 ("' " ?')
 ("`A" ?À)
 ("`E" ?È)
 ("`I" ?Ì)
 ("`O" ?Ò)
 ("`U" ?Ù)
 ("`a" ?à)
 ("`e" ?è)
 ("`i" ?ì)
 ("`o" ?ò)
 ("`u" ?ù)
 ("``" ?`)
 ("` " ?`)
 ("^A" ?Â)
 ("^C" ?Ĉ)
 ("^E" ?Ê)
 ("^G" ?Ĝ)
 ("^H" ?Ĥ)
 ("^I" ?Î)
 ("^J" ?Ĵ)
 ("^O" ?Ô)
 ("^S" ?Ŝ)
 ("^U" ?Û)
 ("^a" ?â)
 ("^c" ?ĉ)
 ("^e" ?ê)
 ("^g" ?ĝ)
 ("^h" ?ĥ)
 ("^i" ?î)
 ("^j" ?ĵ)
 ("^o" ?ô)
 ("^s" ?ŝ)
 ("^u" ?û)
 ("^^" ?^)
 ("^ " ?^)
 ("\"A" ?Ä)
 ("\"E" ?Ë)
 ("\"I" ?Ï)
 ("\"O" ?Ö)
 ("\"U" ?Ü)
 ("\"a" ?ä)
 ("\"e" ?ë)
 ("\"i" ?ï)
 ("\"o" ?ö)
 ("\"u" ?ü)
 ("\"s" ?ß)
 ("\"\"" ?¨)
 ("\" " ?\")
 ("~C" ?Ç)
 ("~N" ?Ñ)
 ("~c" ?ç)
 ("~n" ?ñ)
 ("~S" ?Ş)
 ("~s" ?ş)
 ("~G" ?Ğ)
 ("~g" ?ğ)
 ("~U" ?Ŭ)
 ("~u" ?ŭ)
 ("~`" ?˘)
 ("~~" ?¸)
 ("~ " ?~)
 ("/C" ?Ċ)
 ("/G" ?Ġ)
 ("/H" ?Ħ)
 ("/I" ?İ)
 ("/Z" ?Ż)
 ("/c" ?ċ)
 ("/g" ?ġ)
 ("/h" ?ħ)
 ("/i" ?ı)
 ("/z" ?ż)
 ("/." ?˙)
 ("/#" ?£)
 ("/$" ?¤)
 ("//" ?°)
 ("/ " ?/)
 (".C" ?Ċ)
 (".G" ?Ġ)
 (".I" ?İ)
 (".Z" ?Ż)
 (".c" ?ċ)
 (".g" ?ġ)
 (".z" ?ż)
)

(quail-define-package
 "polish-prefix" "Polish" "PL>" nil
 "Input method for Polish, Kashubian, Kurpie and Silesian.
Similar in spirit to `polish-slash', but uses the most intuitive
prefix for each diacritic.  In addition to ordinary Polish diacritics,
this input method also contains characters from the Kashubian, Kurpie
and Silesian (both Steuer and Ślabikŏrzowy szrajbōnek) scripts."
 nil t t nil nil nil nil nil nil nil t)

(quail-define-rules
 (",a" ?ą)
 (",A" ?Ą)
 ("/a" ?á)
 ("/A" ?Á)
 ("'a" ?á)
 ("'A" ?Á)
 ("\\a" ?à)
 ("\\A" ?À)
 ("`a" ?à)
 ("`A" ?À)
 (".a" ?å)
 (".A" ?Å)
 ("~a" ?ã)
 ("~A" ?Ã)
 ("/c" ?ć)
 ("/C" ?Ć)
 ("'c" ?ć)
 ("'C" ?Ć)
 ("'e" ?é)
 ("'E" ?É)
 ("/e" ?é)
 ("/E" ?É)
 (",e" ?ę)
 (",E" ?Ę)
 (":e" ?ë)
 (":E" ?Ë)
 (":i" ?ï)
 (":I" ?Ï)
 ("/l" ?ł)
 ("/L" ?Ł)
 ("/n" ?ń)
 ("/N" ?Ń)
 ("'n" ?ń)
 ("'N" ?Ń)
 ("`o" ?ò)
 ("`O" ?Ò)
 ("\\o" ?ò)
 ("\\O" ?Ò)
 ("'o" ?ó)
 ("'O" ?Ó)
 ("/o" ?ó)
 ("/O" ?Ó)
 ("^o" ?ô)
 ("^O" ?Ô)
 ("-o" ?ō)
 ("-O" ?Ō)
 ("~o" ?õ)
 ("~O" ?Õ)
 ("#o" ?ŏ)
 ("#O" ?Ŏ)
 ("/s" ?ś)
 ("/S" ?Ś)
 ("'s" ?ś)
 ("'S" ?Ś)
 ("`u" ?ù)
 ("`U" ?Ù)
 (".u" ?ů)
 (".U" ?Ů)
 ("/z" ?ź)
 ("/Z" ?Ź)
 ("'z" ?ź)
 ("'Z" ?Ź)
 (".z" ?ż)
 (".Z" ?Ż)
 ;; Explicit input of prefix characters.  Normally, to input a prefix
 ;; character itself, one needs to press <Tab>.  Definitions below
 ;; allow inputting those characters by entering them twice.
 ("//" ?/)
 ("\\\\" ?\\)
 ("~~" ?~)
 ("''" ?')
 ("::" ?:)
 ("``" ?`)
 ("^^" ?^)
 (".." ?.)
 (",," ?,)
 ("--" ?-))

(quail-define-package
 "polish-slash" "Polish" "PL>" nil
 "Polish diacritics and slash character are input as `/[acelnosxzACELNOSXZ/]'.
For example, the character named `aogonek' is obtained by `/a'."
 nil t t nil nil nil nil nil nil nil t)

(quail-define-rules
 ("//" ?/)
 ("/a" ?ą)
 ("/c" ?ć)
 ("/e" ?ę)
 ("/l" ?ł)
 ("/n" ?ń)
 ("/o" ?ó)
 ("/s" ?ś)
 ("/x" ?ź)
 ("/z" ?ż)
 ("/A" ?Ą)
 ("/C" ?Ć)
 ("/E" ?Ę)
 ("/L" ?Ł)
 ("/N" ?Ń)
 ("/O" ?Ó)
 ("/S" ?Ś)
 ("/X" ?Ź)
 ("/Z" ?Ż))

(quail-define-package
 "latin-9-prefix" "Latin-9" "0>" t
 "Latin-9 characters input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"a -> ä, \"Y -> Ÿ
    tilde    |   ~    | ~a -> ã
    caron    |   ~    | ~z -> ž
   cedilla   |   ~    | ~c -> ç
    misc     | \" ~ /  | \"s -> ß  ~d -> ð  ~t -> þ  /a -> å  /e -> æ  /o -> ø
             | \" ~ /  | /o -> œ
   symbol    |   ~    | ~> -> »  ~< -> «  ~! -> ¡  ~? -> ¿  ~~ -> ž
             |   ~    | ~s -> §  ~e -> €  ~. -> ·  ~$ -> £  ~u -> µ
             |   ~    | ~- -> ­  ~= -> ¯
   symbol    |  _ /   | _o -> º  _a -> ª  // -> °  /\\ -> ×  _y -> ¥
             |  _ /   | _: -> ÷  /c -> ¢  ~p -> ¶
             |  _ /   | /= -> ¬
   symbol    |   ^    | ^r -> ®  ^c -> ©  ^1 -> ¹  ^2 -> ²  ^3 -> ³  _a -> ª
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'Y" ?Ý)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("'y" ?ý)
 ("' " ?')
 ("`A" ?À)
 ("`E" ?È)
 ("`I" ?Ì)
 ("`O" ?Ò)
 ("`U" ?Ù)
 ("`a" ?à)
 ("`e" ?è)
 ("`i" ?ì)
 ("`o" ?ò)
 ("`u" ?ù)
 ("``" ?`)
 ("` " ?`)
 ("^A" ?Â)
 ("^E" ?Ê)
 ("^I" ?Î)
 ("^O" ?Ô)
 ("^U" ?Û)
 ("^a" ?â)
 ("^e" ?ê)
 ("^i" ?î)
 ("^o" ?ô)
 ("^u" ?û)
 ("^^" ?^)
 ("^ " ?^)
 ("\"A" ?Ä)
 ("\"E" ?Ë)
 ("\"I" ?Ï)
 ("\"O" ?Ö)
 ("\"U" ?Ü)
 ("\"a" ?ä)
 ("\"e" ?ë)
 ("\"i" ?ï)
 ("\"o" ?ö)
 ("\"s" ?ß)
 ("\"u" ?ü)
 ("\"y" ?ÿ)
 ("\" " ?\")
 ("~A" ?Ã)
 ("~C" ?Ç)
 ("~D" ?Ð)
 ("~N" ?Ñ)
 ("~O" ?Õ)
 ("~S" ?Š)
 ("~T" ?Þ)
 ("~Z" ?Ž)
 ("~a" ?ã)
 ("~c" ?ç)
 ("~d" ?ð)
 ("~n" ?ñ)
 ("~o" ?õ)
 ("~s" ?š)
 ("~t" ?þ)
 ("~z" ?ž)
 ("~>" ?\»)
 ("~<" ?\«)
 ("~!" ?¡)
 ("~?" ?¿)
 ("~ " ?~)
 ("/A" ?Å)
 ("/E" ?Æ)
 ("/O" ?Ø)
 ("/a" ?å)
 ("/e" ?æ)
 ("/o" ?ø)
 ("//" ?°)
 ("/ " ?/)
 ("_o" ?º)
 ("_a" ?ª)
 ("_+" ?±)
 ("_y" ?¥)
 ("_:" ?÷)
 ("_ " ? )
 ("__" ?_)
 ("/c" ?¢)
 ("/\\" ?×)
 ("/o" ?œ)				; clash with ø, but æ uses /
 ("/O" ?Œ)
 ("\"Y" ?Ÿ)
 ("~s" ?§)
 ("~p" ?¶)
 ;; Is this the best option for Euro entry?
 ("~e" ?€)
 ("~." ?·)
 ("~$" ?£)
 ("~u" ?µ)
 ("^r" ?®)
 ("^c" ?©)
 ("^1" ?¹)
 ("^2" ?²)
 ("^3" ?³)
 ("~-" ?­)
 ("~=" ?¯)
 ("/=" ?¬))

;; Latin-8 was done by an Englishman -- Johnny Celt should take a
;; squint at it.

(quail-define-package
 "latin-8-prefix" "Latin-8" "8>" t
 "Latin-8 characters input method with prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^w -> ŵ
  diaeresis  |   \"    | \"a -> ä
  dot above  |   .    | .b -> ḃ
    tilde    |   ~    | ~a -> ã
   cedilla   |   ~    | ~c -> ç
    misc     | \" ~ /  | \"s -> ß   /a -> å  /e -> æ  /o -> ø
             |   ~    | ~s -> §  ~$ -> £  ~p -> ¶
   symbol    |   ^    | ^r -> ®  ^c -> ©
" nil t nil nil nil nil nil nil nil nil t)

;; Basically following Latin-1, plus dottiness from Latin-3.
(quail-define-rules
 (".B" ?Ḃ)
 (".b" ?ḃ)
 (".c" ?ċ)
 (".C" ?Ċ)
 (".D" ?Ḋ)
 (".d" ?ḋ)
 (".f" ?ḟ)
 (".F" ?Ḟ)
 (".g" ?ġ)
 (".G" ?Ġ)
 (".m" ?ṁ)
 (".M" ?Ṁ)
 (".p" ?ṗ)
 (".P" ?Ṗ)
 (".s" ?ṡ)
 (".S" ?Ṡ)
 (".t" ?ṫ)
 (".T" ?Ṫ)
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'Y" ?Ý)
 ("'W" ?Ẃ)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("'w" ?ẃ)
 ("'y" ?ý)
 ("' " ?')
 ("`A" ?À)
 ("`E" ?È)
 ("`I" ?Ì)
 ("`O" ?Ò)
 ("`U" ?Ù)
 ("`W" ?Ẁ)
 ("`Y" ?Ỳ)
 ("`a" ?à)
 ("`e" ?è)
 ("`i" ?ì)
 ("`o" ?ò)
 ("`u" ?ù)
 ("`w" ?ẁ)
 ("`y" ?ỳ)
 ("``" ?`)
 ("` " ?`)
 ("^A" ?Â)
 ("^E" ?Ê)
 ("^I" ?Î)
 ("^O" ?Ô)
 ("^U" ?Û)
 ("^a" ?â)
 ("^e" ?ê)
 ("^i" ?î)
 ("^o" ?ô)
 ("^u" ?û)
 ("^w" ?ŵ)
 ("^W" ?Ŵ)
 ("^y" ?ŷ)
 ("^Y" ?Ŷ)
 ("^^" ?^)
 ("^ " ?^)
 ("\"A" ?Ä)
 ("\"E" ?Ë)
 ("\"I" ?Ï)
 ("\"O" ?Ö)
 ("\"U" ?Ü)
 ("\"a" ?ä)
 ("\"e" ?ë)
 ("\"i" ?ï)
 ("\"o" ?ö)
 ("\"s" ?ß)
 ("\"u" ?ü)
 ("\"w" ?ẅ)
 ("\"W" ?Ẅ)
 ("\"y" ?ÿ)
 ("\"Y" ?Ÿ)
 ("\" " ?\")
 ("~A" ?Ã)
 ("~C" ?Ç)
 ("~N" ?Ñ)
 ("~O" ?Õ)
 ("~a" ?ã)
 ("~c" ?ç)
 ("~n" ?ñ)
 ("~o" ?õ)
 ("~ " ?~)
 ("/A" ?Å)
 ("/E" ?Æ)
 ("/O" ?Ø)
 ("/a" ?å)
 ("/e" ?æ)
 ("/o" ?ø)
 ("/ " ?/)
 ("~p" ?¶)
 ("~s" ?§)
 ("~$" ?£)
 ("^r" ?®)
 ("^c" ?©))

(quail-define-package
 "latin-prefix" "Latin" "L>" t
 "Latin characters input method with prefix modifiers.
This is the union of various input methods originally made for input
of characters from a single Latin-N charset.

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   \\='    | \\='a -> á  \\='\\=' -> ´
    grave    |   \\=`    | \\=`a -> à
  circumflex |   ^    | ^a -> â
  diaeresis  |   \"    | \"a -> ä  \"\" -> ¨
    tilde    |   ~    | ~a -> ã
   cedilla   |  , ~   | ,c -> ç  ~c -> ç
    caron    |   ~    | ~c -> č  ~g -> ğ
    breve    |   ~    | ~a -> ă
    macron   |   -    | -a -> ā  -/e -> ǣ  -- -> ¯
  dot above  |   / .  | /g -> ġ   .g -> ġ
    misc     | \" ~ /  | \"s -> ß  ~d -> ð  ~t -> þ  /a -> å  /e -> æ  /o -> ø
             |   [    | [\\=' -> ‘  [\" -> “
             |   ]    | ]\\=' -> ’  ]\" -> ”
             |   ,    | ,\\=' -> ‚  ,\" -> „
   symbol    |   ~    | ~> -> »  ~< -> «  ~! -> ¡  ~? -> ¿  ~~ -> ¸
   symbol    |  _ /   | _o -> º  _a -> ª  // -> °  /\\ -> ×  _y -> ¥
   symbol    |   ^    | ^r -> ®  ^t -> ™  ^c -> ©  ^1 -> ¹  ^2 -> ²  ^3 -> ³
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("--" ?¯)
 ("-A" ?Ā)
 ("-a" ?ā)
 ("-E" ?Ē)
 ("-e" ?ē)
 ("-/E" ?Ǣ)
 ("-/e" ?ǣ)
 ("-G" ?Ḡ)
 ("-g" ?ḡ)
 ("-I" ?Ī)
 ("-i" ?ī)
 ("-O" ?Ō)
 ("-o" ?ō)
 ("-U" ?Ū)
 ("-u" ?ū)
 ("-Y" ?Ȳ)
 ("-y" ?ȳ)
 ("' " ?')
 ("''" ?´)
 ("['" ?‘)
 ("]'" ?’)
 ("[\"" ?“)
 ("]\"" ?”)
 (",\"" ?„)
 (",'" ?‚)
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'W" ?Ẃ)
 ("'Y" ?Ý)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("'w" ?ẃ)
 ("'y" ?ý)
 (".B" ?Ḃ)
 (".C" ?Ċ)
 (".D" ?Ḋ)
 (".F" ?Ḟ)
 (".G" ?Ġ)
 (".I" ?İ)
 (".M" ?Ṁ)
 (".P" ?Ṗ)
 (".S" ?Ṡ)
 (".T" ?Ṫ)
 (".Z" ?Ż)
 (".b" ?ḃ)
 (".c" ?ċ)
 (".d" ?ḋ)
 (".f" ?ḟ)
 (".g" ?ġ)
 (".m" ?ṁ)
 (".p" ?ṗ)
 (".s" ?ṡ)
 (".t" ?ṫ)
 (".z" ?ż)
 ("/ " ?/)
 ("/#" ?£)
 ("/$" ?¤)
 ("/." ?˙)
 ("//" ?°)
 ("/2" ?½)
 ("/3" ?¾)
 ("/4" ?¼)
 ("/=" ?¬)
 ("/A" ?Å)
 ("/C" ?Ċ)
 ("/E" ?Æ)
 ("/G" ?Ġ)
 ("/H" ?Ħ)
 ("/I" ?İ)
 ("/O" ?Ø)
 ("/O" ?Œ)
 ("/Z" ?Ż)
 ("/\\" ?×)
 ("/a" ?å)
 ("/c" ?¢)
 ("/c" ?ċ)
 ("/e" ?æ)
 ("/g" ?ġ)
 ("/h" ?ħ)
 ("/i" ?ı)
 ("/o" ?ø)
 ("/o" ?œ)
 ("/z" ?ż)
 ("\" " ?\")
 ("\"A" ?Ä)
 ("\"E" ?Ë)
 ("\"I" ?Ï)
 ("\"O" ?Ö)
 ("\"S" ?ẞ)
 ("\"U" ?Ü)
 ("\"W" ?Ẅ)
 ("\"Y" ?Ÿ)
 ("\"\"" ?¨)
 ("\"a" ?ä)
 ("\"e" ?ë)
 ("\"i" ?ï)
 ("\"o" ?ö)
 ("\"s" ?ß)
 ("\"u" ?ü)
 ("\"w" ?ẅ)
 ("\"y" ?ÿ)
 ("^ " ?^)
 ("^0" ?⁰)
 ("^1" ?¹)
 ("^2" ?²)
 ("^3" ?³)
 ("^4" ?⁴)
 ("^5" ?⁵)
 ("^6" ?⁶)
 ("^7" ?⁷)
 ("^8" ?⁸)
 ("^9" ?⁹)
 ("^A" ?Â)
 ("^C" ?Ĉ)
 ("^E" ?Ê)
 ("^G" ?Ĝ)
 ("^H" ?Ĥ)
 ("^I" ?Î)
 ("^J" ?Ĵ)
 ("^O" ?Ô)
 ("^S" ?Ŝ)
 ("^U" ?Û)
 ("^W" ?Ŵ)
 ("^Y" ?Ŷ)
 ("^^" ?^)
 ("^a" ?â)
 ("^c" ?©)
 ("^c" ?ĉ)
 ("^e" ?ê)
 ("^g" ?ĝ)
 ("^h" ?ĥ)
 ("^i" ?î)
 ("^j" ?ĵ)
 ("^o" ?ô)
 ("^r" ?®)
 ("^s" ?ŝ)
 ("^t" ?™)
 ("^u" ?û)
 ("^w" ?ŵ)
 ("^y" ?ŷ)
 ("^+" ?⁺)
 ("^-" ?⁻)
 ("_0" ?₀)
 ("_1" ?₁)
 ("_2" ?₂)
 ("_3" ?₃)
 ("_4" ?₄)
 ("_5" ?₅)
 ("_6" ?₆)
 ("_7" ?₇)
 ("_8" ?₈)
 ("_9" ?₉)
 ("_++" ?₊)
 ("_-" ?₋)
 ("_+" ?±)
 ("_:" ?÷)
 ("_a" ?ª)
 ("_o" ?º)
 ("_y" ?¥)
 ("_ " ? )
 ("` " ?`)
 ("`A" ?À)
 ("`E" ?È)
 ("`I" ?Ì)
 ("`O" ?Ò)
 ("`U" ?Ù)
 ("`W" ?Ẁ)
 ("`Y" ?Ỳ)
 ("``" ?`)
 ("`a" ?à)
 ("`e" ?è)
 ("`i" ?ì)
 ("`o" ?ò)
 ("`u" ?ù)
 ("`w" ?ẁ)
 ("`y" ?ỳ)
 ("~ " ?~)
 ("~!" ?¡)
 ("~$" ?£)
 ("~-" ?­)
 ("~." ?·)
 ("~<" ?\«)
 ("~~<" ?\‹)
 ("~=" ?¯)
 ("~>" ?\»)
 ("~~>" ?\›)
 ("~?" ?¿)
 ("~A" ?Ã)
 ("~A" ?Ă)
 ("~C" ?Ç)
 ("~C" ?Č)
 (",C" ?Ç)
 ("~D" ?Ð)
 ("~G" ?Ğ)
 ("~N" ?Ñ)
 ("~O" ?Õ)
 ("~O" ?Ġ)
 ("~S" ?Ş)
 ("~S" ?Š)
 ("~T" ?Þ)
 ("~U" ?Ŭ)
 ("~Z" ?Ž)
 ("~`" ?˘)
 ("~a" ?ã)
 ("~a" ?ă)
 ("~c" ?ç)
 ("~c" ?č)
 (",c" ?ç)
 ("~d" ?ð)
 ("~e" ?€)
 ("~g" ?ğ)
 ("~n" ?ñ)
 ("~o" ?õ)
 ("~p" ?¶)
 ("~s" ?§)
 ("~s" ?ş)
 ("~s" ?š)
 ("~t" ?þ)
 ("~u" ?µ)
 ("~u" ?ŭ)
 ("~x" ?¤)
 ("~z" ?ž)
 ("~|" ?¦)
 ("~~" ?¸)
)

;;; Hawaiian prefix input method. It's a small subset of Latin-4
;;; with the addition of an ʻokina mapping.  Hopefully the ʻokina shows
;;; correctly on most displays.

;;; This reference is an authoritative guide to Hawaiian orthography:
;;; https://www2.hawaii.edu/~strauch/tips/HawaiianOrthography.html

;;; Initial coding 2018-09-08 Bob Newell, Honolulu, Hawaiʻi
;;; Comments to bobnewell@bobnewell.net

(quail-define-package
 "hawaiian-prefix" "Hawaiian Prefix" "H>" t
 "Hawaiian characters input method with postfix modifiers

             | prefix | examples
 ------------+---------+----------
  ʻokina     |    \\=`    | \\=` -> ʻ
  kahakō     |    -    | -a -> ā

Doubling the prefix separates the letter and prefix. --a -> -a
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("-A" ?Ā)
 ("-E" ?Ē)
 ("~I" ?Ĩ)
 ("-O" ?Ō)
 ("-U" ?Ū)
 ("-a" ?ā)
 ("-e" ?ē)
 ("-i" ?ī)
 ("-o" ?ō)
 ("-u" ?ū)
 ("`" ?ʻ)

 ("--A" ["-A"])
 ("--E" ["-E"])
 ("--I" ["-I"])
 ("--O" ["-O"])
 ("--U" ["-U"])
 ("--a" ["-a"])
 ("--e" ["-e"])
 ("--i" ["-i"])
 ("--o" ["-o"])
 ("--u" ["-u"])
 ("``"  ["`"])
 )

(quail-define-package
 "lakota-slo-prefix" "Lakota" "SLO " t
 "Suggested Lakota Orthography input method with prefix modifier.
To add stress to a vowel, simply type the single quote ' before the vowel.
The glottal stop is produced by repeating the ' character.  All other
characters are bound to a single key.  Mitákuyepi philámayayapi ló."
nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ;; accented vowels
 ("'a" ?á) ("'A" ?Á)
 ("'e" ?é) ("'E" ?É)
 ("'i" ?í) ("'I" ?Í)
 ("'o" ?ó) ("'O" ?Ó)
 ("'u" ?ú) ("'U" ?Ú)

 ;; consonants with caron
 ("c" ?č) ("C" ?Č)
 ("j" ?ȟ) ("J" ?Ȟ)
 ("q" ?ǧ) ("Q" ?Ǧ)
 ("x" ?ž) ("X" ?Ž)
 ("r" ?š) ("R" ?Š)

 ;; velar nasal n
 ("f" ?ŋ)

 ;; glottal stop
 ("''" ?’))

;;; latin-pre.el ends here
