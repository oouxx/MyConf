(require 'init-java)
(require 'sudo-edit)
(require 'init-docker)
;; (require 'fcitx)
(require 'all-the-icons)
;; (require 'company-box)
;; (add-hook 'company-mode-hook 'company-box-mode)
;; (add-to-list 'melpa-include-packages 'company-box)
(add-to-list 'melpa-include-packages 'all-the-icons)

;; python setup
(require 'company-anaconda)
(add-to-list 'melpa-include-packages 'company-anaconda)
(add-to-list 'company-backends 'company-anaconda)
(add-hook 'python-mode-hook 'anaconda-mode)

;; evil optimize
(setq evil-escape-key-sequence "fd")

;; melpa mirrors
(setq package-archives
      '(("localelpa" . "~/.emacs.d/localelpa/")
        ;; uncomment below line if you need use GNU ELPA
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
        ;; ("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")

        ;; Use either 163 or tsinghua mirror repository when official melpa
        ;; is slow or shutdown.

        ;; ;; {{ Option 1: 163 mirror repository:
        ;; ;; ("gnu" . "https://mirrors.163.com/elpa/gnu/")
        ;; ("melpa" . "https://mirrors.163.com/elpa/melpa/")
        ;; ("melpa-stable" . "https://mirrors.163.com/elpa/melpa-stable/")
        ;; ;; ;; }}

        ;; ;; {{ Option 2: tsinghua mirror repository
        ;; ;; @see https://mirror.tuna.tsinghua.edu.cn/help/elpa/ on usage:
        ;; ;; ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")
        ;; }}
        ))
;; disable pyim. I use fcitx-sogou
(setq-default company-minimum-prefix-length 1)
(setq-default org-default-notes-file "~/org/notes.org")
(setq-default mm-text-html-renderer 'w3m)
;; (with-eval-after-load 'flycheck
;;   (flycheck-pos-tip-mode))
;; (fcitx-aggressive-setup)
;; (setq fcitx-use-dbus t)
;; ;; (add-hook 'after-save-hook 'counsel-etags-virtual-update-tags)
;; evil-matchit 2.3.0 is required
;; (setq my-use-m-for-matchit t)
;; set evil-set-marker key
(load-theme 'gruvbox t)

;; lsp-mode
(eval-after-load 'lsp-mode
  '(progn
     ;; enable log only for debug
     (setq lsp-log-io t)
     ;; use `evil-matchit' instead
     (setq lsp-enable-folding nil)
     ;; don't handle yasnippet by myself
     (setq lsp-enable-snippet t)
     ;; use `company-ctags' only.
     ;; Please `company-lsp' is automatically enabled if installed
     (setq lsp-enable-completion-at-point t)
     ;; turn off for better performance
     (setq lsp-enable-symbol-highlighting nil)
     ;; use ffip instead
     (setq lsp-enable-links nil)
     ;; don't scan 3rd party javascript libraries
     (push "[/\\\\]\\node_modules$" lsp-file-watch-ignored)))


;; I used to spacemacs keybinding principle
 (my-space-leader-def
 "SPC" 'counsel-M-x
 "/" 'swiper
 ;; search

 ;; quit emacs
 "qq" 'save-buffers-kill-terminal
 ;; files/fold
 "fr" 'counsel-recentf
 "ft" 'neotree-toggle
 "ff" 'counsel-find-file
 "fs" 'save-buffer
 "fj" 'dired
 ;; project

 "pf" 'find-file-in-project
 ;; "pf" 'find-file-in-current-directory
 "pp" 'find-file-in-project-at-point
 "ps" 'find-file-in-project-by-selected
 ;; "ps" 'find-file-with-similar-name ; ffip v5.3.1
 "pd" 'find-directory-in-project-by-selected

 ;; help
 "hp" 'describe-package
 "hv" 'describe-variable
 "hk" 'describe-key
 "hf" 'describe-function
 ;; windows
 "wh" 'evil-window-left
 "wl" 'evil-window-right
 "wj" 'evil-window-down
 "wk" 'evil-window-up
 "wd" 'delete-window
 "wu" 'winner-undo
 "w/" 'split-window-horizontally
 "wv" 'split-window-vertically
 ;; buffers
 "bp" 'previous-buffer
 "bn" 'next-buffer
 "bb" 'counsel-buffer-or-recentf
 "bi" 'ibuffer

 "ee" 'my-swap-sexps
 "pc" 'my-dired-redo-from-commands-history
 "ps" 'profiler-start
 "pr" 'profiler-report
 "pw" 'pwd
 "mm" 'counsel-evil-goto-global-marker
 "mf" 'mark-defun
 "cc" 'my-dired-redo-last-command
 "cl" 'comment-line
 "ss" 'wg-create-workgroup ; save windows layout
 "se" 'iedit-mode ; start iedit in emacs
 "sc" 'shell-command
 "ll" 'my-wg-switch-workgroup ; load windows layout
 "kk" 'scroll-other-window
 "jj" 'scroll-other-window-up
 "rt" 'random-color-theme
 "yy" 'hydra-launcher/body
 "gi" 'gist-region ; only workable on my computer
 "tt" 'my-toggle-indentation

 ;; git&version controll
 "ggg" 'magit-status
 "gs" 'magit-show-commit
 "gl" 'magit-log-all
 "gff" 'magit-find-file ; loading file in specific version into buffer
 "gdd" 'magit-diff-dwim
 "gdc" 'magit-diff-staged
 "gau" 'magit-stage-modified
 "gcc" 'magit-commit-popup
 "gca" 'magit-commit-amend
 "ggt" 'git-commit-tracked
 "gja" 'magit-commit-extend
 "gtt" 'magit-stash
 "gta" 'magit-stash-apply
 "gv" 'git-gutter:set-start-revision
 "gh" 'git-gutter-reset-to-head-parent
 "gr" 'git-gutter-reset-to-default

 ;; org-mode
 "oa" 'org-agenda
 "ot" 'org-todo
 "oxb" 'org-toggle-checkbox
 "oc<" 'org-do-demote
 "oc>" 'org-do-promote
 "ost" 'org-set-tags

 ;; quick jump to window
 "0" 'winum-select-window-0-or-10
 "1" 'winum-select-window-1
 "2" 'winum-select-window-2
 "3" 'winum-select-window-3
 "4" 'winum-select-window-4
 "5" 'winum-select-window-5
 "6" 'winum-select-window-6
 "7" 'winum-select-window-7
 "8" 'winum-select-window-8
 "9" 'winum-select-window-9

 ;; gud
 "ud" 'my-gud-gdb
 "uk" 'gud-kill-yes
 "ur" 'gud-remove
 "ub" 'gud-break
 "uu" 'gud-run
 "up" 'gud-print
 "ue" 'gud-cls
 "un" 'gud-next
 "us" 'gud-step
 "ui" 'gud-stepi
 "uc" 'gud-cont
 "uf" 'gud-finish)


(my-comma-leader-def
 "bf" 'beginning-of-defun
 "bu" 'backward-up-list
 "bb" 'back-to-previous-buffer
 "ef" 'end-of-defun
 "m" 'evil-set-marker
 "em" 'erase-message-buffer
 "eb" 'eval-buffer
 "sd" 'sudo-edit
 "sc" 'scratch
 "ee" 'eval-expression
 "aa" 'copy-to-x-clipboard ; used frequently
 "aw" 'ace-swap-window
 "af" 'ace-maximize-window
 "ac" 'aya-create
 "zz" 'paste-from-x-clipboard ; used frequently
 "bs" '(lambda () (interactive) (goto-edge-by-comparing-font-face -1))
 "es" 'goto-edge-by-comparing-font-face
 "vj" 'my-validate-json-or-js-expression
 "kc" 'kill-ring-to-clipboard
 "ntt" 'neotree-toggle
 "ntf" 'neotree-find ; open file in current buffer in neotree
 "ntd" 'neotree-project-dir
 "nth" 'neotree-hide
 "nts" 'neotree-show
 "fn" 'cp-filename-of-current-buffer
 "fp" 'cp-fullpath-of-current-buffer
 "dj" 'dired-jump ;; open the dired from current file
 "xd" 'dired
 "xo" 'ace-window
 "ff" 'toggle-full-window ;; I use WIN+F in i3
 "ip" 'find-file-in-project
 "tt" 'find-file-in-current-directory
 "jj" 'find-file-in-project-at-point
 "kk" 'find-file-in-project-by-selected
 "kn" 'find-file-with-similar-name ; ffip v5.3.1
 "fd" 'find-directory-in-project-by-selected
 "trm" 'get-term
 "tff" 'toggle-frame-fullscreen
 "tfm" 'toggle-frame-maximized
 "ti" 'fastdef-insert
 "th" 'fastdef-insert-from-history
 "ci" 'evilnc-comment-or-uncomment-lines
 "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
 "cc" 'evilnc-copy-and-comment-lines
 "cp" 'my-evilnc-comment-or-uncomment-paragraphs
 "ct" 'evilnc-comment-or-uncomment-html-tag ; evil-nerd-commenter v3.3.0 required
 "ic" 'my-imenu-comments
 "epy" 'emmet-expand-yas
 "epl" 'emmet-expand-line
 "rv" 'evilmr-replace-in-defun
 "rb" 'evilmr-replace-in-buffer
 "ts" 'evilmr-tag-selected-region ;; recommended
 "cby" 'cb-switch-between-controller-and-view
 "cbu" 'cb-get-url-from-controller
 "rt" 'counsel-etags-recent-tag
 "ft" 'counsel-etags-find-tag
 "yy" 'counsel-browse-kill-ring
 "cf" 'counsel-grep ; grep current buffer
 "gf" 'counsel-git ; find file
 "gg" 'counsel-git-grep-by-selected ; quickest grep should be easy to press
 "gm" 'counsel-git-find-my-file
 "gs" (lambda ()
        (interactive)
        (let* ((ffip-diff-backends
                '(("Show git commit" . (let* ((git-cmd "git --no-pager log --date=short --pretty=format:'%h|%ad|%s|%an'")
                                              (collection (nonempty-lines (shell-command-to-string git-cmd)))
                                              (item (ffip-completing-read "git log:" collection)))
                                         (when item
                                           (shell-command-to-string (format "git show %s" (car (split-string item "|" t))))))))))
          (ffip-show-diff 0)))
 "gd" 'ffip-show-diff-by-description ;find-file-in-project 5.3.0+
 "gl" 'my-git-log-trace-definition ; find history of a function or range
 "sf" 'counsel-git-show-file
 "sh" 'my-select-from-search-text-history
 "df" 'counsel-git-diff-file
 "rjs" 'run-js
 "jsr" 'js-send-region
 "jsb" 'js-clear-send-buffer
 "rmz" 'run-mozilla
 "rpy" 'run-python
 "rlu" 'run-lua
 "tci" 'toggle-company-ispell
 "kb" 'kill-buffer-and-window ;; "k" is preserved to replace "C-g"
 "ls" 'highlight-symbol
 "lq" 'highlight-symbol-query-replace
 "ln" 'highlight-symbol-nav-mode ; use M-n/M-p to navigation between symbols
 "ii" 'counsel-imenu
 "ij" 'rimenu-jump
 "." 'evil-ex
 ;; @see https://github.com/pidu/git-timemachine
 ;; p: previous; n: next; w:hash; W:complete hash; g:nth version; q:quit
 "tg" 'dumb-jump-go
 "tb" 'dumb-jump-back
 "tm" 'my-git-timemachine
 ;; toggle overview,  @see http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/
 "ov" 'my-overview-of-current-buffer
 "oo" 'compile
 "c$" 'org-archive-subtree ; `C-c $'
 ;; org-do-demote/org-do-premote support selected region
 "c<" 'org-do-promote ; `C-c C-<'
 "c>" 'org-do-demote ; `C-c C->'
 "cam" 'org-tags-view ; `C-c a m': search items in org-file-apps by tag
 "cxi" 'org-clock-in ; `C-c C-x C-i'
 "cxo" 'org-clock-out ; `C-c C-x C-o'
 "cxr" 'org-clock-report ; `C-c C-x C-r'
 "qq" 'my-multi-purpose-grep
 "dd" 'counsel-etags-grep-current-directory
 "xc" 'save-buffers-kill-terminal
 "rr" 'my-counsel-recentf
 "rh" 'counsel-yank-bash-history ; bash history command => yank-ring
 "rd" 'counsel-recent-directory
 "da" 'diff-region-tag-selected-as-a
 "db" 'diff-region-compare-with-b
 "di" 'evilmi-delete-items
 "si" 'evilmi-select-items
 "jb" 'js-beautify
 "jp" 'my-print-json-path
 "xe" 'eval-last-sexp
 "x0" 'delete-window
 "x1" 'delete-other-windows
 "x2" 'my-split-window-vertically
 "x3" 'my-split-window-horizontally
 "s1" 'delete-other-windows
 "s2" 'fip-split-window-vertically
 "s3" 'ffip-split-window-horizontally
 "rw" 'rotate-windows
 "ru" 'undo-tree-save-state-to-register ; C-x r u
 "rU" 'undo-tree-restore-state-from-register ; C-x r U
 "xt" 'toggle-two-split-window
 "uu" 'winner-undo
 "UU" 'winner-redo
 "to" 'toggle-web-js-offset
 "fs" 'ffip-save-ivy-last
 "fr" 'ffip-ivy-resume
 "fc" 'cp-ffip-ivy-last
 "ss" 'counsel-grep-or-swiper ; better performance, got Cygwin grep installed on Windows always
 "hst" 'hs-toggle-fold
 "hsa" 'hs-toggle-fold-all
 "hsh" 'hs-hide-block
 "hss" 'hs-show-block
 "hd" 'describe-function
 "hf" 'find-function
 "hk" 'describe-key
 "hv" 'describe-variable
 "gt" 'counsel-gtags-dwim ; jump from reference to definition or vice versa
 "gr" 'counsel-gtags-find-symbol
 "gu" 'counsel-gtags-update-tags
 "fb" 'flyspell-buffer
 "fe" 'flyspell-goto-next-error
 "fa" 'flyspell-auto-correct-word
 "lb" 'langtool-check-buffer
 "ll" 'langtool-goto-next-error
 "pe" 'flymake-goto-prev-error
 "ne" 'flymake-goto-next-error
 "bc" '(lambda () (interactive) (wxhelp-browse-class-or-api (thing-at-point 'symbol)))
 "og" 'org-agenda
 "otl" 'org-toggle-link-display
 "oa" '(lambda ()
         (interactive)
         (unless (featurep 'org) (require 'org))
         (counsel-org-agenda-headlines))
 "om" 'toggle-org-or-message-mode
 "ut" 'undo-tree-visualize
 "ar" 'align-regexp
 "wrn" 'httpd-restart-now
 "wrd" 'httpd-restart-at-default-directory
 "bk" 'buf-move-up
 "bj" 'buf-move-down
 "bh" 'buf-move-left
 "bl" 'buf-move-right
 "0" 'winum-select-window-0-or-10
 "1" 'winum-select-window-1
 "2" 'winum-select-window-2
 "3" 'winum-select-window-3
 "4" 'winum-select-window-4
 "5" 'winum-select-window-5
 "6" 'winum-select-window-6
 "7" 'winum-select-window-7
 "8" 'winum-select-window-8
 "9" 'winum-select-window-9
 "xm" 'counsel-M-x
 "xx" 'er/expand-region
 "xf" 'counsel-find-file
 "xb" 'ivy-switch-buffer-by-pinyin
 "xh" 'mark-whole-buffer
 "xk" 'kill-buffer
 "xs" 'save-buffer
 "xz" 'switch-to-shell-or-ansi-term
 "vm" 'vc-rename-file-and-buffer
 "vc" 'vc-copy-file-and-rename-buffer
 "xvv" 'vc-next-action ; 'C-x v v' in original
 "va" 'git-add-current-file
 "vk" 'git-checkout-current-file
 "vg" 'vc-annotate ; 'C-x v g' in original
 "vs" 'git-gutter:stage-hunk
 "vr" 'git-gutter:revert-hunk
 "vl" 'vc-print-log
 "vv" 'vc-msg-show
 "v=" 'git-gutter:popup-hunk
 "hh" 'cliphist-paste-item
 "yu" 'cliphist-select-item
 "ih" 'my-goto-git-gutter ; use ivy-mode
 "ir" 'ivy-resume
 "nn" 'my-goto-next-hunk
 "pp" 'my-goto-previous-hunk

 "ww" 'narrow-or-widen-dwim
 "xnw" 'widen
 "xnd" 'narrow-to-defun
 "xnr" 'narrow-to-region
 "ycr" 'my-yas-reload-all
 "wf" 'popup-which-function)


;; disable emacs ring-bell
(setq ring-bell-function 'ignore)

(setq org-capture-templates
'(("t" "Todo" entry (file+headline "~/org/todo.org" "Todo soon")
"* TODO %? \n %^t")
("i" "Idea" entry (file+headline "~/org/ideas.org" "Ideas")
"* %? \n %U")
("e" "Tweak" entry (file+headline "~/org/tweaks.org" "Tweaks")
"* %? \n %U")
("l" "Learn" entry (file+headline "~/org/learn.org" "Learn")
"* %? \n")
("w" "Work note" entry (file+headline "~/org/work.org" "Work")
"* %? \n")
("m" "Check movie" entry (file+headline "~/org/check.org" "Movies")
"* %? %^g")
("n" "Check book" entry (file+headline "~/org/check.org" "Books")
"* %^{book name} by %^{author} %^g")))

(add-hook 'org-agenda-mode-hook (lambda ()
            (add-hook 'auto-save-hook 'org-save-all-org-buffers nil t)
            (auto-save-mode)))
;; org-download
(require 'org-download)
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)
(setq-default org-download-image-dir "~/org/pictures")

(setq org-todo-keyword-faces
 '(("TODO" . "red")
   ("STARTED" . "yellow")
   ("WAITING" . "purple")
   ("CANCELLED" . (:foreground "blue" :weight bold))
   ("DONE" . "green")
   ("BUG" . "red")
   ("PROGRESS" . "yellow")
   ("UNTESTED" . "purple")
   ("DROPPED" . (:foreground "blue" :weight bold))
   ("FIXED" . "green")))

(setq org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s)" "WAITING(w@/!)"  "|" "CANCELLED(c@/!)" "DONE(d!/!)")
                                (sequence "BUG(b)" "PROGRESS(p)" "UNTESTED(u)"  "|" "DROPPED(D@/!)" "FIXED(f!/!)"))))

;; (setq eldoc-idle-delay 0)
(menu-bar-mode 1)
;; (elp-instrument-package "elpy-")
(provide '.custom)
;;; .custom.el ends here
