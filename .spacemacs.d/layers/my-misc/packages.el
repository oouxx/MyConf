;;; packages.el --- my-misc layer packages file for Spacemacs.
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
;; added to `my-misc-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-misc/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-misc/pre-init-PACKAGE' and/or
;;   `my-misc/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-misc-packages
  '(
    ;;(emacs-application-framework :location local)
    (eaf :location (recipe
                    :fetcher github
                    :repo "manateelazycat/emacs-application-framework"
                    :files ("*")))
    ))

(defun my-misc/init-eaf ()
  (use-package eaf
    :custom
    (eaf-find-alternate-file-in-dired t)
    ;;(browse-url-browser-function 'eaf-open-browser) ;; Make EAF Browser my default browser
    :config
    (defalias 'browse-web #'eaf-open-browser)
    ;; I already bind "RET", "<mouse-2>", "^" to `dired-find-alternate-file' in `init-dired.el'.
    ;; Comment this line out of you don't want to use EAF to open available files in dired.
    ;; (global-set-key [remap dired-find-alternate-file] #'eaf-file-open-in-dired)
    (eaf-bind-key scroll_up "RET" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_down_page "DEL" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_down_page "u" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_up_page "d" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_to_end "M->" eaf-pdf-viewer-keybinding)
    (eaf-bind-key scroll_to_home "M-<" eaf-pdf-viewer-keybinding)
    (eaf-bind-key quit-window "q" eaf-pdf-viewer-keybinding)
    (eaf-bind-key take_photo "p" eaf-camera-keybinding))
  )

;;; packages.el ends here
