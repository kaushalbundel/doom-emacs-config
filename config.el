;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kaushal Bundel"
      user-mail-address "kaushalbundel@x.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

(setq doom-font (font-spec :family "Iosevka Term SS05" :size 14 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "Iosevka Term SS05" :size 13 :weight 'Regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi-tinted)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")


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

;; some new defaults
(setq undo-limit 80000000)    ;;raise undo limit
(setq evil-want-fine-undo t)  ;;more granular undo
(setq scroll-margin 2)        ;;maintaining a little margin while scrolling
(setq menu-bar-mode -1)

;; mac specific controls
                                        ;(cond (IS-MAC
                                        ;       (setq mac-option-modifier        'meta
                                        ;             mac-right-option-modifier  'meta
                                        ;             mac-command-modifier       'control)))

;;Turning off the Tool bar
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

;; Deleted files to Trash
(setq delete-by-moving-to-trash t)

(setq company-global-modes '(not org-mode))

;;elfeed links opening in eww

(setq browse-url-browser-function 'eww-browse-url)

;; Org elfeed
(setq rmh-elfeed-org-files '("~/.doom.d/elfeed.org"))
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

;; elfeed-youtube setup
(use-package! elfeed-tube
  ;;  :demand t    ;; Check: If the commented out feature is hamporing the feature in any way
  ;;  :after! elfeed
  :config
  ;; (setq elfeed-tube-auto-save-p nil) ; default value
  ;; (setq elfeed-tube-auto-fetch-p t)  ; default value
  (elfeed-tube-setup)
  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)))

;; elfeed-tube-mpv setup
(use-package! elfeed-tube-mpv
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))



;; Org Mode
;; Org agenda view (Goals-Check the day agenda or the week's agenda)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Insync/kaushalbundel@outlook.com/OneDrive/09-Notes")
(setq org-agenda-files '("~/Insync/kaushalbundel@outlook.com/OneDrive/01-Vision-Plan/02-Plan/02-habit"
                         "~/Insync/kaushalbundel@outlook.com/OneDrive/09-Notes"
                         "~/Insync/kaushalbundel@outlook.com/OneDrive/07-Programming"))

(after! org
  (setq org-todo-keywords '((sequence "BACKLOG" "TODO(t!)" "IN-PROGRESS(p!)" "WAITING(w@)" "|" "Rescheduled" "DONE(d!)" "DROPPED(r@)")))
  (setq org-todo-keywords-for-agenda '((sequence "BACKLOG" "TODO(t!)" "IN-PROGRESS(p!)" "WAITING(w@)" "|" "Rescheduled" "DONE(d!)" "DROPPED(r@)"))))

;; Denote Configuration
(setq denote-directory (expand-file-name "~/Insync/kaushalbundel@outlook.com/OneDrive/09-Notes/"))      ;creating Denote directory
(setq denote-known-keywords '("work" "personal" "health" "article" "course" "video" "audio"))           ;setting the keywords
(setq denote-infer-keywords t)                                                                          ;if any new keywords are added in Denote will add them to the list of keywords
(setq denote-sort-keywords t)                                                                           ;keyword sorting
(denote-rename-buffer-mode 1)                                                                           ;rename buffers as denote buffers

;;denote org-specific
(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))



;; capture keybindings
(map! "C-c C-w" #'osx-dictionary-search-input
      "C-c C-p" #'osx-dictionary-search-word-at-point)

;; ;; Dictionary setup
(setq ispell-dictionary "en")

(defun my-auth (key)
  (with-temp-buffer
    (insert-file-contents-literally "~/.my-auth")
    (alist-get key (read (current-buffer)))))

;;gptel config
(use-package! gptel
  :config
  (setq! gptel-api-key (my-auth 'key1)))
(map! "<f1>" #'gptel-send)

;;eww config
(setq! eww-auto-rename-buffer 'title)

;; to address Failed to connect to mpv error
(setq mpv-start-timeout 5)
