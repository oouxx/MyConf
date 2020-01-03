;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '("~/.spacemacs.d/layers/")
   dotspacemacs-configuration-layers
   '(
     shell-scripts
     (auto-completion :variables
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-use-company-box t)
     (python :variables
             python-backend 'lsp
             python-formatter 'yapf
             python-format-on-save t
             )
     (java :variables
           java-backend 'lsp
           )
     (go :variables
         go-backend 'lsp)
     emacs-lisp
     (javascript :variables
                 javascript-backend 'lsp)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode
            c-c++-backend 'lsp-clangd)
     rust
     html
     latex
     better-defaults
     emacs-lisp
     ranger
     (git :variables
          git-magit-status-fullscreen t
          magit-push-always-verify nil
          magit-save-repository-buffers 'dontask
          magit-revert-buffers 'silent
          magit-refs-show-commit-count 'all
          magit-revision-show-gravatars nil)
     (ivy :variable ivy-enable-advanced-buffer-information nil)
     lsp
     markdown
     multiple-cursors
     (org :variables org-want-todo-bindings t)
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     ;; (shell :variables
     ;;       shell-default-height 30
     ;;       shell-default-position 'bottom)
     (syntax-checking :variables
                      syntax-checking-enable-by-default nil
                      syntax-checking-enable-tooltips nil)
     (spell-checking :variables spell-checking-enable-by-default nil)
     dap
     pdf
     yaml
     treemacs
     version-control
     (my-better-default :location local)
     ;;(my-programming :location local)
     ;;(my-org :location local)
     (my-display :location local)
     (my-misc :location local)
     )

   dotspacemacs-additional-packages '()
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages
     '(org-projectile org-brain magit-gh-pulls magit-gitflow  evil-mc realgud tern company-tern
                      evil-args evil-ediff evil-exchange evil-unimpaired
                      evil-indent-plus volatile-highlights
                      holy-mode skewer-mode rainbow-delimiters
                      highlight-indentation vi-tilde-fringe eyebrowse ws-butler
                      org-bullets smooth-scrolling org-repo-todo org-download org-timer
                      livid-mode git-gutter git-gutter-fringe  evil-escape
                      leuven-theme gh-md evil-lisp-state spray lorem-ipsum symon
                      ac-ispell ace-jump-mode auto-complete auto-dictionary
                      define-word google-translate disaster epic
                      fancy-battery org-present orgit orglue spaceline
                      helm-flyspell flyspell-correct-helm clean-aindent-mode
                      helm-c-yasnippet ace-jump-helm-line helm-make magithub
                      helm-themes helm-swoop helm-spacemacs-help smeargle
                      ido-vertical-mode flx-ido company-quickhelp ivy-rich helm-purpose
                      )
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-enable-emacs-pdumper nil
   dotspacemacs-emacs-pdumper-executable-file "emacs"
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-gc-cons '(100000000 0.1)
   dotspacemacs-use-spacelpa nil
   dotspacemacs-verify-spacelpa-archives t
   dotspacemacs-elpa-subdirectory 'emacs-version
   dotspacemacs-editing-style 'vim
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-new-empty-buffer-major-mode 'text-mode
   dotspacemacs-scratch-mode 'org-mode
   dotspacemacs-initial-scratch-message nil
   dotspacemacs-themes '(dracula
                         spacemacs-dark
                         spacemacs-light)

   dotspacemacs-mode-line-theme 'all-the-icons
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 10.0
                               :weight normal
                               :width normal)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-generate-layout-names nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-undecorated-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-enable-server nil
   dotspacemacs-server-socket-dir nil
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   dotspacemacs-frame-title-format "%I@%S"
   dotspacemacs-icon-title-format nil
   dotspacemacs-whitespace-cleanup nil
   dotspacemacs-zone-out-when-idle nil
   dotspacemacs-pretty-docs t))

(defun dotspacemacs/user-env ()
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  (setq socks-server '("Default server" "127.0.0.1" 1080 5))
  (setq evil-shift-round nil)
  (setq byte-compile-warnings '(not obsolete))
  (setq warning-minimum-level :error)
  (setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
  (setq configuration-layer-elpa-archives
        '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

  )

(defun dotspacemacs/user-load ()
  )

(defun dotspacemacs/user-config ()
  (golden-ratio-mode t)
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
)
