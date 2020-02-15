;;; packages.el --- my-ui layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author:  <wxx@wxx-arch>
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
;; added to `my-ui-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-ui/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-ui/pre-init-PACKAGE' and/or
;;   `my-ui/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-ui-packages
  '(spaceline)
  )

(defun my-ui/post-init-spaceline ()
  (use-package spaceline
    :init
    (spaceline-toggle-minor-modes-off)
    ))

;;; packages.el ends here
