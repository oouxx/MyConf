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
      quickrun
      ;;lsp-mode
      ;;lsp-ui
      dap-mode
      company
      company-lsp
      ;;company-tabnine
      ;;company-box
      ))

(defun my-programming/post-init-dap-mode ()
  (use-package dap-mode
    :diminish
    :bind
    (:map dap-mode-map
          (("<f12>" . dap-debug)
           ("<f8>" . dap-continue)
           ("<f9>" . dap-next)
           ("<M-f11>" . dap-step-in)
           ("C-M-<f11>" . dap-step-out)
           ("<f7>" . dap-breakpoint-toggle)))
    :hook ((after-init . dap-mode)
           (dap-mode . dap-ui-mode)
           (python-mode . (lambda () (require 'dap-python)))
           (ruby-mode . (lambda () (require 'dap-ruby)))
           (go-mode . (lambda () (require 'dap-go)))
           (java-mode . (lambda () (require 'dap-java)))
           ((c-mode c++-mode objc-mode swift) . (lambda () (require 'dap-lldb)))
           (php-mode . (lambda () (require 'dap-php)))
           (elixir-mode . (lambda () (require 'dap-elixir)))
           ((js-mode js2-mode typescript-mode) . (lambda () (require 'dap-chrome))))))
(defun my-programming/post-init-quickrun ()
  (use-package quickrun
    :bind
    (("<f5>" . quickrun)
     ("M-<f5>" . quickrun-shell))))

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
    (compan-tabnine-max-num-results 9)
    :bind
    (("M-q" . company-other-backend)
     ("" . company-tabnine))
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
                (seq-take candidates-lsp 6)))))))
(defun my-programming/post-init-company-box ()
  (use-package company-box
    :diminish
    :functions (my-company-box--make-line
                my-company-box-icons--elisp)
    :commands (company-box--get-color
               company-box--resolve-colors
               company-box--add-icon
               company-box--apply-color
               company-box--make-line
               company-box-icons--elisp)
    :hook (company-mode . company-box-mode)
    :custom
    (company-box-backends-colors nil)
    (company-box-show-single-candidate t)
    (company-box-max-candidates 50)
    (company-box-doc-delay 0.3)
    :config
    ;; Support `company-common'
    (defun my-company-box--make-line (candidate)
      (-let* (((candidate annotation len-c len-a backend) candidate)
              (color (company-box--get-color backend))
              ((c-color a-color i-color s-color) (company-box--resolve-colors color))
              (icon-string (and company-box--with-icons-p (company-box--add-icon candidate)))
              (candidate-string (concat (propertize (or company-common "") 'face 'company-tooltip-common)
                                        (substring (propertize candidate 'face 'company-box-candidate) (length company-common) nil)))
              (align-string (when annotation
                              (concat " " (and company-tooltip-align-annotations
                                               (propertize " " 'display `(space :align-to (- right-fringe ,(or len-a 0) 1)))))))
              (space company-box--space)
              (icon-p company-box-enable-icon)
              (annotation-string (and annotation (propertize annotation 'face 'company-box-annotation)))
              (line (concat (unless (or (and (= space 2) icon-p) (= space 0))
                              (propertize " " 'display `(space :width ,(if (or (= space 1) (not icon-p)) 1 0.75))))
                            (company-box--apply-color icon-string i-color)
                            (company-box--apply-color candidate-string c-color)
                            align-string
                            (company-box--apply-color annotation-string a-color)))
              (len (length line)))
        (add-text-properties 0 len (list 'company-box--len (+ len-c len-a)
                                         'company-box--color s-color)
                             line)
        line))
    (advice-add #'company-box--make-line :override #'my-company-box--make-line)

    ;; Prettify icons
    (defun my-company-box-icons--elisp (candidate)
      (when (derived-mode-p 'emacs-lisp-mode)
        (let ((sym (intern candidate)))
          (cond ((fboundp sym) 'Function)
                ((featurep sym) 'Module)
                ((facep sym) 'Color)
                ((boundp sym) 'Variable)
                ((symbolp sym) 'Text)
                (t . nil)))))
    (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp)

      (declare-function all-the-icons-faicon 'all-the-icons)
      (declare-function all-the-icons-material 'all-the-icons)
      (declare-function all-the-icons-octicon 'all-the-icons)
      (setq company-box-icons-all-the-icons
            `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.85 :v-adjust -0.2))
              (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.05))
              (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-purple))
              (Field . ,(all-the-icons-octicon "tag" :height 0.8 :v-adjust 0 :face 'all-the-icons-lblue))
              (Variable . ,(all-the-icons-octicon "tag" :height 0.8 :v-adjust 0 :face 'all-the-icons-lblue))
              (Class . ,(all-the-icons-material "settings_input_component" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Interface . ,(all-the-icons-material "share" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Module . ,(all-the-icons-material "view_module" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.05))
              (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.85 :v-adjust -0.2))
              (Value . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Enum . ,(all-the-icons-material "storage" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.85 :v-adjust -0.2))
              (Snippet . ,(all-the-icons-material "format_align_center" :height 0.85 :v-adjust -0.2))
              (Color . ,(all-the-icons-material "palette" :height 0.85 :v-adjust -0.2))
              (File . ,(all-the-icons-faicon "file-o" :height 0.85 :v-adjust -0.05))
              (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.85 :v-adjust -0.2))
              (Folder . ,(all-the-icons-faicon "folder-open" :height 0.85 :v-adjust -0.05))
              (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-lblue))
              (Constant . ,(all-the-icons-faicon "square-o" :height 0.85 :v-adjust -0.05))
              (Struct . ,(all-the-icons-material "settings_input_component" :height 0.85 :v-adjust -0.2 :face 'all-the-icons-orange))
              (Event . ,(all-the-icons-faicon "bolt" :height 0.8 :v-adjust -0.05 :face 'all-the-icons-orange))
              (Operator . ,(all-the-icons-material "control_point" :height 0.85 :v-adjust -0.2))
              (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.05))
              (Template . ,(all-the-icons-material "format_align_center" :height 0.85 :v-adjust -0.2)))
            company-box-icons-alist 'company-box-icons-all-the-icons))
  )

;;; packages.el ends here
