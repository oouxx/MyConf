;;; packages.el --- my-programming layer packages file for Spacemacs.
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
;; added to `my-programming-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-programming/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-programming/pre-init-PACKAGE' and/or
;;   `my-programming/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(setq my-programming-packages
      '(
        js2-mode
        (cc-mode :location built-in)
        lsp-java
        company
        company-lsp
        company-tabnine
        ))

(defun my-programming/post-init-cc-mode ()
  (use-package cc-mode
    :config
    (setq c-basic-offset 4)
    ;; give me NO newline automatically after electric expressions are entered
    (setq c-auto-newline nil)

    ;; syntax-highlight aggressively
    ;; (setq font-lock-support-mode 'lazy-lock-mode)
    (setq lazy-lock-defer-contextually t)
    (setq lazy-lock-defer-time 0)
    ;make DEL take all previous whitespace with it
    (c-toggle-hungry-state 1)))

(defun my-programming/post-init-js2-mode ()
  (use-package js2-mode)
  )
(defun my-programming/post-init-lsp-java ()
  (use-package lsp-java
    :after lsp-mode
    :config
    (use-package request :defer t)
    :custom
    (lsp-java-server-install-dir (expand-file-name "~/.lsp/eclipse.jdt.ls/"))))

(defun my-programming/post-init-company ()
  (use-package company
    :diminish company-mode
    :hook ((prog-mode LaTeX-mode latex-mode ess-r-mode) . company-mode)
    :bind
    (:map company-active-map
          ([tab] . smarter-yas-expand-next-field-complete)
          ("TAB" . smarter-yas-expand-next-field-complete))
    :custom
    (company-minimum-prefix-length 1)
    (company-tooltip-align-annotations t)
    (company-begin-commands '(self-insert-command))
    (company-require-match 'never)
    ;; Don't use company in the following modes
    (company-global-modes '(not shell-mode eaf-mode))
    ;; Trigger completion immediately.
    (company-idle-delay 0.1)
    ;; Number the candidates (use M-1, M-2 etc to select completions).
    (company-show-numbers t)
    :config
    ;;(unless *clangd* (delete 'company-clang company-backends))
    (global-company-mode 1)
    (defun smarter-yas-expand-next-field-complete ()
      "Try to `yas-expand' and `yas-next-field' at current cursor position.
  If failed try to complete the common part with `company-complete-common'"
      (interactive)
      (if yas-minor-mode
          (let ((old-point (point))
                (old-tick (buffer-chars-modified-tick)))
            (yas-expand)
            (when (and (eq old-point (point))
                      (eq old-tick (buffer-chars-modified-tick)))
              (ignore-errors (yas-next-field))
              (when (and (eq old-point (point))
                        (eq old-tick (buffer-chars-modified-tick)))
                (company-complete-common))))
        (company-complete-common))))
    )


(defun my-programming/post-init-company-lsp ()
  (use-package company-lsp
    :defer t
    :custom (company-lsp-cache-candidates 'auto)))

(defun my-programming/post-init-company-tabnine()
  (use-package company-tabnine
    :defer 1
    :custom
    (company-tabnine-max-num-results 9)
    :bind
    (("M-q" . company-other-backend)
     ("C-z t" . company-tabnine))
    :hook
    (lsp-after-open . (lambda ()
                        (setq company-tabnine-max-num-results 3)
                        (add-to-list 'company-transformers 'company//sort-by-tabnine t)
                        (add-to-list 'company-backends '(company-lsp :with company-tabnine :separate))))
    :config
    ;; Enable TabNine on default
    (add-to-list 'company-backends #'company-tabnine)

    ;; Integrate company-tabnine with lsp-mode
    (defun company//sort-by-tabnine (candidates)
      (if (or (functionp company-backend)
              (not (and (listp company-backend) (memq 'company-tabnine company-backend))))
          candidates
        (let ((candidates-table (make-hash-table :test #'equal))
              candidates-lsp
              candidates-tabnine)
          (dolist (candidate candidates)
            (if (eq (get-text-property 0 'company-backend candidate)
                    'company-tabnine)
                (unless (gethash candidate candidates-table)
                  (push candidate candidates-tabnine))
              (push candidate candidates-lsp)
              (puthash candidate t candidates-table)))
          (setq candidates-lsp (nreverse candidates-lsp))
          (setq candidates-tabnine (nreverse candidates-tabnine))
          (nconc (seq-take candidates-tabnine 3)
                (seq-take candidates-lsp 6))))))
)
;;; packages.el ends here
