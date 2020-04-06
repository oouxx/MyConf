(defvar org-agenda-dir "~/org/")
(setq org-todo-keyword-faces
      '(("TODO" . "red")
        ("STARTED" . "yellow")
        ("WAITING" . "purple")
        ("CANCELLED" . "blue")
        ("DONE" . "white")
        ("BUG" . "red")
        ("PROGRESS" . "yellow")
        ("UNTESTED" . "purple")
        ("DROPPED" . "blue")
        ("FIXED" . "white")))

;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/org/todo.org" "Todo soon")
;;           "* TODO %? \n %^t")
;;         ("i" "Idea" entry (file+headline "~/org/ideas.org" "Ideas")
;;           "* %? \n %U")
;;         ("e" "Tweak" entry (file+headline "~/org/tweaks.org" "Tweaks")
;;           "* %? \n %U")
;;         ("l" "Learn" entry (file+headline "~/org/learn.org" "Learn")
;;           "* %? \n")
;;         ("w" "Work note" entry (file+headline "~/org/work.org" "Work")
;;           "* %? \n")
;;         ("m" "Check movie" entry (file+headline "~/org/check.org" "Movies")
;;           "* %? %^g")
;;         ("n" "Check book" entry (file+headline "~/org/check.org" "Books")
;;           "* %^{book name} by %^{author} %^g")))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-targets
      '((nil :maxlevel . 4)
        (org-agenda-files :maxlevel . 4)))

(setq org-stuck-projects
      '("TODO={.+}/-DONE" nil nil "SCHEDULED:\\|DEADLINE"))

(setq org-agenda-inhibit-startup t);; ~50x speedup
(setq org-agenda-span 'day)
(setq org-agenda-use-tag-inheritance nil) ;; 3-4x speedup
(setq org-agenda-window-setup 'current-window)
(setq org-log-done t)

;; Org clock
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 00:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-tags-match-list-sublevels nil)

(setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-gtd (expand-file-name "todo.org" org-agenda-dir))
;; (setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
;; (setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))
(setq org-default-notes-file (expand-file-name "todo.org" org-agenda-dir))
;; (setq org-agenda-file-blogposts (expand-file-name "all-posts.org" org-agenda-dir))
(setq org-agenda-files (list org-agenda-dir))

;; BUG invalid function org-preserve-local-variables
;; FIXED https://github.com/syl20bnr/spacemacs/issues/11801#issuecomment-451755821

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Workspace")
          "* TODO [#B] %?\n  %i\n %U"
          :empty-lines 1)
        ("n" "notes" entry (file+headline org-agenda-file-note "Quick notes")
          "* %?\n  %i\n %U"
          :empty-lines 1)
        ;; ("b" "Blog Ideas" entry (file+headline org-agenda-file-note "Blog Ideas")
        ;;   "* TODO [#B] %?\n  %i\n %U"
        ;;   :empty-lines 1)
        ;; ("s" "Code Snippet" entry
        ;;   (file org-agenda-file-code-snippet)
        ;;   "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
        ("w" "work" entry (file+headline org-agenda-file-gtd "Work")
          "* TODO [#A] %?\n  %i\n %U"
          :empty-lines 1)
        ;; ("x" "Web Collections" entry
        ;;   (file+headline org-agenda-file-note "Web")
        ;;   "* %U %:annotation\n\n%:initial\n\n%?")
        ("p" "Protocol" entry (file+headline org-agenda-file-note "Inbox")
          "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
        ("L" "Protocol Link" entry (file+headline org-agenda-file-note "Inbox")
            "* %? [[%:link][%:description]] \nCaptured On: %U")
        ("c" "Chrome" entry (file+headline org-agenda-file-note "Quick notes")
          "* TODO [#C] %?\n %(zilongshanren/retrieve-chrome-current-tab-url)\n %i\n %U"
          :empty-lines 1)
        ("l" "links" entry (file+headline org-agenda-file-note "Quick notes")
          "* TODO [#C] %?\n  %i\n %a \n %U"
          :empty-lines 1)
        ;; ("j" "Journal Entry"
        ;;   entry (file+datetree org-agenda-file-journal)
        ;;   "* %?"
        ;;   :empty-lines 1)
        ))

(setq org-enforce-todo-dependencies t)
;; disable DOWNLOADED attribute
(setq org-download-annotate-function (lambda (_link) ""))
