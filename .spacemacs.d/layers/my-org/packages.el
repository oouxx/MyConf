;;; packages.el --- my-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: wxx <wxx@wxx-pc>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `my-org-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-org/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-org/pre-init-PACKAGE' and/or
;;   `my-org/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq my-org-packages
    '())
(defun my-org/post-init-org ()
  (with-eval-after-load 'org
    (progn
      ;; org-mode setup

      ;; when opening a org file, don't collapse headings
      (setq org-startup-folded nil)

      ;; wrap long lines. don't let it disappear to the right
      (setq org-startup-truncated nil)

      ;; when in a url link, enter key should open it
      (setq org-return-follows-link t)

      ;; make org-mode” syntax color embedded source code
      (setq org-src-fontify-natively t)

      (org-babel-do-load-languages
       'org-babel-load-languages
       '((perl . t)
         (ruby . t)
         (shell . t)
         (dot . t)
         (js . t)
         (latex .t)
         (python . t)
         (emacs-lisp . t)
         (C . t)))
         (setq org-todo-keywords
              (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                      (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))

      )))

;;; packages.el ends here
