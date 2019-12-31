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
      (use-package org
        :ensure nil
        :defer t
        :bind
        ("C-c l" . org-store-link)
        ("C-c a" . org-agenda)
        ("C-c c" . org-capture)
        ("C-c b" . org-switch)
        (:map org-mode-map ("C-c C-p" . org-export-as-pdf-and-open))
        :custom
        (org-log-done 'time)
        (org-export-backends (quote (ascii html icalendar latex md odt)))
        (org-use-speed-commands t)
        (org-confirm-babel-evaluate 'nil)
        (org-todo-keywords
         '((sequence "TODO" "IN-PROGRESS" "REVIEW" "|" "DONE")))
        (org-agenda-window-setup 'other-window)
        :config
        (unless (version< org-version "9.2")
          (require 'org-tempo))
        (when (file-directory-p "~/org/agenda/")
          (setq org-agenda-files (list "~/org/agenda/")))

        (defun org-export-turn-on-syntax-highlight ()
          "Setup variables to turn on syntax highlighting when calling `org-latex-export-to-pdf'."
          (interactive)
          (setq org-latex-listings 'minted
                org-latex-packages-alist '(("" "minted"))
                org-latex-pdf-process
                '("pdflatex -shelnl-escape -interaction nonstopmode -output-directory %o %f"
                  "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

        (defun org-export-as-pdf-and-open ()
          "Run `org-latex-export-to-pdf', delete the tex file and open pdf in a new buffer."
          (interactive)
          (save-buffer)
          (let* ((pdf-path (org-latex-export-to-pdf))
                 (pdf-name (file-name-nondirectory pdf-path)))
            (if (try-completion pdf-name (mapcar #'buffer-name (buffer-list)))
                (progn
                  (kill-matching-buffers (concat "^" pdf-name) t t)
                  (find-file-other-window pdf-name))
              (find-file-other-window pdf-name))
            (delete-file (concat (substring pdf-path 0 (string-match "[^\.]*\/?$" pdf-path)) "tex"))))
        (setq org-startup-folded nil)
        (setq org-startup-truncated nil)
        (setq org-return-follows-link t)
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

        )

      )))

;;; packages.el ends here
