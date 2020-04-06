  ;; org-pom notify
  (defun org-pom-notify (msg)
    "Send an org-pomodoro desktop notification"
    (cond
     ((string-equal system-type "windows-nt")
      ;; note that they're required to be closed before another can be displayed, but there's no
      ;; problem with double-closing and the ID seems to always be 42, so we just proactively close
      ;; any open notifications before trying to display another.
      (w32-notification-close 42)
      (w32-notification-notify :title "org-pomodoro" :body msg))
     ((string-equal system-type "darwin")
      (message "Pomodoro notifications not yet supported on OSX"))
     ((string-equal system-type "gnu/linux")
      (notifications-notify :title "org-pomodoro" :body msg))))
  ;; org-pomodoro mode hooks
  (with-eval-after-load "org-pomodoro"
    (setq org-pomodoro-play-sounds nil)
    (add-hook 'org-pomodoro-started-hook
              (lambda ()
                (org-pom-notify "Pomodoro Started. You can do it!")))
    (add-hook 'org-pomodoro-finished-hook
              (lambda ()
                (org-pom-notify "Pomodoro Finished, time for a break")))
    (add-hook 'org-pomodoro-break-finished-hook
              (lambda ()
                (org-pom-notify "Break Finished, try one more!")))
    (add-hook 'org-pomodoro-long-break-finished-hook
              (lambda ()
                (org-pom-notify "Long Break Finished, try one more!")))
    (add-hook 'org-pomodoro-killed-hook
              (lambda ()
                (org-pom-notify "Pomodoro Cancelled"))))
