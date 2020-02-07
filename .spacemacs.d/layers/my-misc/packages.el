;;; packages.el --- my-misc layer packages file for Spacemacs.
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
    pyim
    ))

(defun my-misc/post-init-pyim ()
(use-package pyim
  :ensure nil
  :demand t
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure nil
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")
  ;; 我使用ziranman
  (setq pyim-default-scheme 'ziranma-shuangpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(
                  ;; pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  ;; pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)
  ;; 选词框显示5个候选词
  (setq pyim-page-length 7)
  :bind
  (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer))))
;;; packages.el ends here
