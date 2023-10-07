;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kaushal Bundel"
      user-mail-address "kaushalbundel@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Iosevka Term" :size 14 :weight 'medium)
     doom-variable-pitch-font (font-spec :family "Iosevka Comfy Motion Duo" :size 13 :weight 'Regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark-high-contrast)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `t)

;; some new defaults
(setq undo-limit 80000000)    ;;raise undo limit
(setq evil-want-fine-undo t)  ;;more granular undo
(setq scroll-margin 2)        ;;maintaining a little margin while scrolling


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Company mode to not work in Org
(setq company-global-modes '(not org-mode))

;;elfeed links opening in eww

(setq browse-url-browser-function 'eww-browse-url)

;; Org elfeed
(setq rmh-elfeed-org-files '("~/org/elfeed.org"))
;; elfeed update when search doom starts
(add-hook! 'elfeed-search-mode-hook #'elfeed-update)
(use-package! elfeed-goodies)
(elfeed-goodies/setup)
(setq elfeed-goodies/entry-pane-size 0.9)
(add-hook! 'elfeed-show-mode-hook 'visual-line-mode)
;; (evil-define-key 'normal elfeed-show-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)
;; (evil-define-key 'normal elfeed-search-mode-map
;;   (kbd "J") 'elfeed-goodies/split-show-next
;;   (kbd "K") 'elfeed-goodies/split-show-prev)


;;keybinding defination for org-pomodoro in all buffers
(map! "M-o M-p" #'org-pomodoro)


;; Org Mode
;; Org agenda view (Goals-Check the day agenda or the week's agenda)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/OneDrive/09-Notes/04-org-notes")
(setq org-agenda-files '("~/OneDrive/01-Vision-Plan/02-Plan/01-todo"
                         "~/OneDrive/01-Vision-Plan/02-Plan/02-habit"))

;; Custom agenda commands to display goals in the agenda buffer
(setq org-agenda-custom-commands
'(("d" "Today's Tasks"
	((tags-todo
	  "GHD+ACTIVE+PRIORITY=\"A\""
	  ((org-agenda-files '("~/OneDrive/01-Vision-Plan/02-Plan/01-todo/goals.org"))
	   (org-agenda-overriding-header "Primary goals this month")))
	 (tags-todo
	  "GHD+ACTIVE+PRIORITY=\"C\""
	  ((org-agenda-files '("~/OneDrive/01-Vision-Plan/02-Plan/01-todo/goals.org"))
	   (org-agenda-overriding-header "Secondary goals this month")))
	 (agenda "" ((org-agenda-span 1)
                     (org-agenda-start-day "d")
		     (org-agenda-overriding-header "Today")))))

  ("w" "This Week's Tasks"
       ((tags-todo
	 "GHD+ACTIVE+PRIORITY=\"A\""
	 ((org-agenda-files '("~/OneDrive/01-Vision-Plan/02-Plan/01-todo/goals.org"))
	  (org-agenda-overriding-header "Primary goals this month")))
	(tags-todo
	 "GHD+ACTIVE+PRIORITY=\"C\""
	 ((org-agenda-files '("~/OneDrive/01-Vision-Plan/02-Plan/01-todo/goals.org"))
	  (org-agenda-overriding-header "Secondary goals this month")))
	(agenda))))
)

;; Give better structure to the agenda page
(use-package! org-agenda
  :after org
  :custom
  (org-agenda-prefix-format '((agenda . " %i %-20:c%?-12t%-6e% s")
			      (todo   . " %i %-20:c %-6e")
			      (tags   . " %i %-20:c")
			      (search . " %i %-20:c"))))

;; Org Mode- As children are marked Done, mark the parent Done automatically
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)


;; Org-Agenda setup
(use-package! org-habit
  :after org
  :config
  (setq org-habit-following-days 3
        org-habit-preceding-days 7
        org-habit-show-all-today t))
;; org mode changes
(after! org
  (setq org-agenda-skip-deadline-if-done t
        org-agenda-skip-scheduled-if-done t))

;; specific keybindings
(map! "C-c C-w" #'osx-dictionary-search-input
      "C-c C-p" #'osx-dictionary-search-word-at-point)
