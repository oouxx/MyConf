(setq my-display-packages
      '(;; Owned packages
        all-the-icons-dired
        ;; pretty-mode
        (prettify-utils :location (recipe :fetcher github
                                          :repo "Ilazki/prettify-utils.el"))
        doom-modeline

        ;; Personal display-related packages
        (pretty-fonts    :location local)
        (pretty-magit    :location local)
        ))


;;;; All-the-icons-dired
(defun my-display/init-all-the-icons-dired ()
  (use-package all-the-icons-dired
    :hook (dired-mode . all-the-icons-dired-mode)))

(defun my-display/post-init-doom-modeline ()
  (use-package doom-modeline
    :hook (after-init . doom-modeline-mode)
    :custom
    ;; Don't compact font caches during GC. Windows Laggy Issue
    (inhibit-compacting-font-caches t)
    (doom-modeline-icon t)
    (doom-modeline-buffer-file-name 'file-name)
    (doom-modeline-major-mode-color-icon t)
    ))
;;;; Pretty-mode
(defun my-display/init-pretty-mode ()
  ;; I *only* use greek letter replacements at the moment.
  ;; However, I go back and forht on whether to use nil-like <-> emptyset.
  ;; I currently have it *enabled*. Uncomment the deactivation to remove it.

  (use-package pretty-mode
    :config
    (progn
      (global-pretty-mode t)

      (pretty-deactivate-groups
       '(:equality :ordering :ordering-double :ordering-triple
                   :arrows :arrows-twoheaded :punctuation
                   :logic :sets
                   ;; :nil
                   ))
      (pretty-activate-groups
       '(:greek)))))

;;;; Prettify-utils

(defun my-display/init-prettify-utils ()
  (use-package prettify-utils))


;;;; Pretty-fonts

(defun my-display/init-pretty-fonts ()
  (use-package pretty-fonts
    :config
    ;; !! This is required to avoid segfault when using emacs as daemon !!
    (spacemacs|do-after-display-system-init
     ;; (pretty-fonts-add-hook 'prog-mode-hook pretty-fonts-fira-code-alist)
     ;; (pretty-fonts-add-hook 'org-mode-hook  pretty-fonts-fira-code-alist)

     ;; (pretty-fonts-set-fontsets-for-fira-code)
     (pretty-fonts-set-fontsets
      '(;; All-the-icons fontsets
        ("fontawesome"
         ;;                         
         #xf07c #xf0c9 #xf0c4 #xf0cb #xf017 #xf101)

        ("all-the-icons"
         ;;    
         #xe907 #xe928)

        ("github-octicons"
         ;;                               
         #xf091 #xf059 #xf076 #xf075 #xe192  #xf016 #xf071)

        ("material icons"
         ;;              
         #xe871 #xe918 #xe3e7  #xe5da
         ;;              
         #xe3d0 #xe3d1 #xe3d2 #xe3d4))))))

;;;; Pretty-magit

(defun my-display/init-pretty-magit ()
  (use-package pretty-magit
    :config
    (progn
      (pretty-magit-add-leaders
       '(("Feature" ? (:foreground "slate gray" :height 1.2))
         ("Add"     ? (:foreground "#375E97" :height 1.2))
         ("Fix"     ? (:foreground "#FB6542" :height 1.2))
         ("Clean"   ? (:foreground "#FFBB00" :height 1.2))
         ("Docs"    ? (:foreground "#3F681C" :height 1.2))))

      (pretty-magit-setup))))
