(defun browse-hugo-maybe ()
  (interactive)
  (let ((hugo-service-name "Hugo Server")
        (hugo-service-port "1313"))
    (if (prodigy-service-started-p (prodigy-find-service hugo-service-name))
        (progn
          (message "Hugo detected, launching browser...")
          (browse-url (concat "http://localhost:" hugo-service-port))))))
(defun ivy-with-thing-at-point (cmd)
  (let ((ivy-initial-inputs-alist
         (list
          (cons cmd (thing-at-point 'symbol)))))
    (funcall cmd)))

(defun my-swiper-search (p)
  (interactive "P")
  (let ((current-prefix-arg nil))
    (call-interactively
     (if p #'spacemacs/swiper-region-or-symbol
       #'swiper))))
