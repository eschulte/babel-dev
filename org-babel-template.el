;;; org-babel-template.el --- org-babel functions for template evaluation

;; Copyright (C) your name here

;; Author: your name here
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file is not intended to ever be loaded by org-babel, rather it
;; is a template for use in adding new language support to Org-babel.
;; Good first steps are to copy this file to a file named by the
;; language you are adding, and then use `query-replace' to replace
;; all strings of "template" in this file with the name of your new
;; language.
;;
;; If you have questions as to any of the portions of the file defined
;; below please look to existing language support for guidance.
;;
;; If you are planning on adding a language to org-babel we would ask
;; that if possible you fill out the FSF copyright assignment form
;; available at http://orgmode.org/request-assign-future.txt as this
;; will simplify the eventual inclusion of your addition into
;; org-babel and possibly at some point into org-mode and Emacs
;; proper.

;;; Requirements:

;; Use this section to list the requirements of this language.  Most
;; languages will require that at least the language be installed on
;; the user's system, and the Emacs major mode relevant to the
;; language be installed as well.

;;; Code:
(require 'org-babel)
;; possibly require modes required for your language

;; Add this language to the list of supported languages.  Org-babel
;; will match the string below against the declared language of the
;; source-code block.
(org-babel-add-interpreter "template")

;; specify the name, file extension, and shebang line for this language
(add-to-list 'org-babel-tangle-langs '("template" "template-extension" "#!/usr/bin/env template"))

;; This is the main function which is called to evaluate a code
;; block.  It should setup the source code block according to all of
;; the header arguments packaged into params, including...
;; - defining variables
;; - optionally starting up a session (depending on the value of the
;;   :session) header argument
;;
;; This function will then evaluate the body of the source code and
;; return the results as emacs-lisp depending on the value of the
;; :results header argument
;; - output means that the output to STDOUT will be captured and
;;   returned
;; - value means that the value of the last statement in the
;;   source code block will be returned
;;
;; The most common first step in this function is the expansion of the
;; PARAMS argument using `org-babel-process-params'.
;;
;; Please feel free to not implement options which aren't appropriate
;; for your language (e.g. not all languages support interactive
;; "session" evaluation).  Also you are free to define any new header
;; arguments which you feel may be useful -- all header arguments
;; specified by the user will be available in the PARAMS variable.
(defun org-babel-execute:template (body params)
  "Execute a block of Template code with org-babel.  This function is
called by `org-babel-execute-src-block'"
  (message "executing Template source code block")
  (let* ((processed-params (org-babel-process-params params))
         ;; set the session if the session variable is non-nil
         (session (org-babel-template-initiate-session (first processed-params)))
         ;; variables assigned for use in the block
         (vars (second processed-params))
         (result-params (third processed-params))
         ;; either OUTPUT or VALUE which should behave as described above
         (result-type (fourth processed-params))
         (full-body (concat
                     ;; prepend code to define all arguments passed to the code block
                     ;; (may not be appropriate for all languages)
                     (mapconcat
                      (lambda (pair)
                        (format "%s=%s"
                                (car pair)
                                (org-babel-template-var-to-template (cdr pair))))
                      vars "\n") "\n" body "\n")))
    ;; actually execute the source-code block either in a session or
    ;; possibly by dropping it to a temporary file and evaluating the
    ;; file.
    ;; 
    ;; for session based evaluation the helpers defined in
    ;; `org-babel-comint' will probably be helpful.
    ))

;; This function should be used to assign any variables in params in
;; the context of the session environment.
(defun org-babel-prep-session:template (session params)
  "Prepare SESSION according to the header arguments specified in PARAMS."
  )

(defun org-babel-template-var-to-template (var)
  "Convert an elisp var into a string of template source code
specifying a var of the same value."
  )

(defun org-babel-template-table-or-string (results)
  "If the results look like a table, then convert them into an
Emacs-lisp table, otherwise return the results as a string."
  )

(defun org-babel-template-initiate-session (&optional session)
  "If there is not a current inferior-process-buffer in SESSION
then create.  Return the initialized session."
  (unless (string= session "none")
    ))

(provide 'org-babel-template)
;;; org-babel-template.el ends here
