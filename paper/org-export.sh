#!/bin/bash
# -*- mode: shell-script -*-
#
# Export files with org-mode
#
# customize the following two variables to match your local install directories
ORGROOT="~/emacs/src/org"
ESSROOT="~/emacs/src/ess"

DIR=`pwd`
FILES=""
ORGINSTALL="$ORGROOT/lisp/org-install.el"
ORGBABEL="$ORGROOT/lisp/ob.el"
ESSLOAD="\"$ESSROOT/lisp/\""

# wrap each argument in the code required to call tangle on it
for i in $@; do
    FILES="$FILES \"$i\""
done

emacs -Q --batch -l $ORGINSTALL -l $ORGBABEL \
--eval "(progn
(add-to-list 'load-path $ESSLOAD)
(require 'ess-site)
(require 'org)
(require 'org-exp)
(require 'ob)
(require 'ob-exp)
(require 'ob-C)
(require 'ob-dot)
(require 'ob-emacs-lisp)
(require 'ob-haskell)
(require 'ob-org)
(require 'ob-perl)
(require 'ob-python)
(require 'ob-R)
(require 'ob-ruby)
(require 'ob-sh)
(require 'ob-sqlite)
(let ((org-confirm-babel-evaluate nil))
  (mapc (lambda (file)
         (find-file (expand-file-name file \"$DIR\"))
         (goto-char 2423) (org-babel-execute-src-block) ; load jss customization
         (org-export-as-latex nil)
         (kill-buffer)) '($FILES))))"
