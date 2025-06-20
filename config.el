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

(setq doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 13 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "IosevkaTermSlab Nerd Font Mono" :size 13 :weight 'Regular))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

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
(setq evil-move-cursor-back nil) ;; problem: when M+enter is pressed the last character gets pushed to the last line
(setq scroll-margin 2)        ;;maintaining a little margin while scrolling
(setq menu-bar-mode -1)


;;Turning off the Tool bar
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

;; Deleted files to Trash
(setq delete-by-moving-to-trash t)


;;mac-specific settings
(cond (IS-MAC
       (setq mac-option-modifier        'meta
             mac-right-option-modifier  'meta
             mac-command-modifier       'control)))

(setq company-global-modes '(not org-mode))

;;elfeed links opening in eww

(setq browse-url-browser-function 'eww-browse-url)

(use-package! elfeed
  :config
  (setq elfeed-show-entry-delete 'elfeed-goodies/delete-pane
        elfeed-show-entry-switch 'elfeed-goodies/switch-pane))

;; Org elfeed
(setq rmh-elfeed-org-files '("~/.config/doom/elfeed.org"))

;; elfeed update when search doom starts
(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

(use-package! elfeed-goodies
  :config
  (elfeed-goodies/setup)
  (setq elfeed-goodies/entry-pane-size 0.85
        elfeed-goodies/entry-pane-position 'bottom
        elfeed-goodies/show-mode-padding 5))

;; changing feed using evil keybindings
(with-eval-after-load 'evil
  (evil-define-key 'normal elfeed-show-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev)
  (evil-define-key 'normal elfeed-search-mode-map
    (kbd "J") 'elfeed-goodies/split-show-next
    (kbd "K") 'elfeed-goodies/split-show-prev))

;; copy elfeed link
(map! :leader "e y" #'elfeed-show-yank)

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
                         "~/Insync/kaushalbundel@outlook.com/OneDrive/07-Programming"
                         "~/Insync/kaushalbundel@outlook.com/OneDrive/09-Notes/journal"))

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

;;setting denote daily journal (the package has been discontinued)
;; (require 'denote-journal-extras)
;; (setq denote-journal-extras-title-format 'day-date-month-year)

;; Denote specific keybindings
(map! :leader "d k" #'denote
      :leader "d z" #'denote-link-or-create)  ;; Create denote buffer if not already created

;; consult-denote for better note navigation
(map! :leader "d f" #'consult-denote-find
      :leader "d g" #'consult-denote-grep)

;; capture keybindings
(map! "C-c C-w" #'osx-dictionary-search-input
      "C-c C-p" #'osx-dictionary-search-word-at-point)

;; ;; Dictionary setup
(setq ispell-dictionary "en")

;; (defun my-auth (key)
;;   (with-temp-buffer
;;     (insert-file-contents-literally "~/.my-auth")

;;gptel config
;; (use-package! gptel
;;   :config
;;   (setq! gptel-api-key (my-auth 'key1)))
;; (map! "<f1>" #'gptel-send)

;;eww config
(setq! eww-auto-rename-buffer 'title)

;; to address Failed to connect to mpv error
(setq mpv-start-timeout 5)

;; configuring python dap mode(debugging)
;; TODO: Debugging to be done 
;; (after! dap-mode
;;   (setq dap-python-debugger 'debugpy))
;; (map! :map dap-mode-map
;;       :leader
;;       :prefix ("d" . "dap")
;;       ;; basics
;;       :desc "dap next"          "n" #'dap-next
;;       :desc "dap step in"       "i" #'dap-step-in
;;       :desc "dap step out"      "o" #'dap-step-out
;;       :desc "dap continue"      "c" #'dap-continue
;;       :desc "dap hydra"         "h" #'dap-hydra
;;       :desc "dap debug restart" "r" #'dap-debug-restart
;;       :desc "dap debug"         "s" #'dap-debug

;;       ;; debug
;;       :prefix ("dd" . "Debug")
;;       :desc "dap debug recent"  "r" #'dap-debug-recent
;;       :desc "dap debug last"    "l" #'dap-debug-last

;;       ;; eval
;;       :prefix ("de" . "Eval")
;;       :desc "eval"                "e" #'dap-eval
;;       :desc "eval region"         "r" #'dap-eval-region
;;       :desc "eval thing at point" "s" #'dap-eval-thing-at-point
;;       :desc "add expression"      "a" #'dap-ui-expressions-add
;;       :desc "remove expression"   "d" #'dap-ui-expressions-remove

;;       :prefix ("db" . "Breakpoint")
;;       :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
;;       :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
;;       :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
;;       :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)


;;avy-configuration
;;avy is a package that is used to easily navigate the buffer
(map! "C-c g l" #'avy-goto-line
      "C-c g w" #'avy-goto-word-0)

;; function  to kill whole line or just a word
;; usage is just select the k or K to kill the whole line and press the selection word
(defun avy-action-kill-whole-line (pt)
  (save-excursion
    (goto-char pt)
    (kill-whole-line))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(setf (alist-get ?k avy-dispatch-alist) 'avy-action-kill-stay
      (alist-get ?K avy-dispatch-alist) 'avy-action-kill-whole-line)

;; function for copying whole line
(defun avy-action-copy-whole-line (pt)
  (save-excursion
    (goto-char pt)
    (cl-destructuring-bind (start . end)
        (bounds-of-thing-at-point 'line)
      (copy-region-as-kill start end)))
  (select-window
   (cdr
    (ring-ref avy-ring 0)))
  t)

(defun avy-action-yank-whole-line (pt)
  (avy-action-copy-whole-line pt)
  (save-excursion (yank))
  t)

(setf (alist-get ?y avy-dispatch-alist) 'avy-action-yank
      (alist-get ?w avy-dispatch-alist) 'avy-action-copy
      (alist-get ?W avy-dispatch-alist) 'avy-action-copy-whole-line
      (alist-get ?Y avy-dispatch-alist) 'avy-action-yank-whole-line)

;; function for zapping
;; zapping is used to remove stuff between similar character. for eg, stuff between quotes or html tags


;;consult
(map! :leader "b a" #'consult-buffer)

;; lsp shortcuts
(map! :leader "c g" #'lsp-goto-type-definition) ;; get the documentation
(map! :leader "c p" #'lsp-describe-thing-at-point) ;;get the entire class defintion in a popup buffer

;; spacious-padding config
(use-package! spacious-padding
  :config
  (setq spacious-padding-widths
        '( :internal-border-width 15
           :header-line-width 4
           :mode-line-width 2
           :tab-width 2
           :right-divider-width 24
           :scroll-bar-width 8))
  (spacious-padding-mode 1))

;; for better reading experience
(use-package! olivetti
  :defer 10
  :custom
  (olivetti-body-width 130))

;; disabling auto format in web mode
;; The issue is with the formatting of django templates which on format become distorted
(add-to-list '+format-on-save-disabled-modes 'web-mode)


;; Writeroom  mode keybinding
(map! "<f12>" #'writeroom-mode)
;; writeroom-mode
;; Setup writeroom width and appearance (https://joshblais.com/posts/my-literate-doom-emacs-config/)
(after! writeroom-mode
  ;; Set width for centered text
  (setq writeroom-width 40)

  ;; Ensure the text is truly centered horizontally
  (setq writeroom-fringes-outside-margins nil)
  (setq writeroom-center-text t)

  ;; Add vertical spacing for better readability
  (setq writeroom-extra-line-spacing 4)  ;; Adds space between lines

  ;; Improve vertical centering with visual-fill-column integration
  (add-hook! 'writeroom-mode-hook
    (defun my-writeroom-settings ()
      "Configure various settings when entering/exiting writeroom-mode."
      (if writeroom-mode
          (progn
            ;; When entering writeroom mode
            (display-line-numbers-mode -1)       ;; Turn off line numbers
            (setq cursor-type 'bar)              ;; Change cursor to a thin bar for writing
            (hl-line-mode -1)                    ;; Disable current line highlighting
            (setq left-margin-width 0)           ;; Let writeroom handle margins
            (setq right-margin-width 0)
            ;; (text-scale-set -2)                   ;; Slightly increase text size
            (setq-local my-writeroom-face-cookie
                        (face-remap-add-relative 'default :height 0.9)) ;; Adjust this value
            (variable-pitch-mode 1)

            ;; Improve vertical centering
            (when (bound-and-true-p visual-fill-column-mode)
              (visual-fill-column-mode -1))      ;; Temporarily disable if active
            (setq visual-fill-column-width 40)   ;; Match writeroom width
            (setq visual-fill-column-center-text t)
            (setq visual-fill-column-extra-text-width '(0 . 0))

            ;; Set top/bottom margins to improve vertical centering
            ;; These larger margins push content toward vertical center
            (setq-local writeroom-top-margin-size
                        (max 10 (/ (- (window-height) 40) 3)))
            (setq-local writeroom-bottom-margin-size
                        (max 10 (/ (- (window-height) 40) 3)))

            ;; Enable visual-fill-column for better text placement
            (visual-fill-column-mode 1))

        ;; When exiting writeroom mode
        (progn
          (display-line-numbers-mode +1)       ;; Restore line numbers
          (setq cursor-type 'box)              ;; Restore default cursor
          (hl-line-mode +1)                    ;; Restore line highlighting
          (text-scale-set 0)                   ;; Restore normal text size
          (when (bound-and-true-p my-writeroom-face-cookie)
            (face-remap-remove-relative my-writeroom-face-cookie))
          (when (bound-and-true-p visual-fill-column-mode)
            (visual-fill-column-mode -1))))))  ;; Disable visual fill column mode

  ;; Hide modeline for a cleaner look
  (setq writeroom-mode-line nil)

  ;; Add additional global effects for writeroom
  (setq writeroom-global-effects
        '(writeroom-set-fullscreen        ;; Enables fullscreen
          writeroom-set-alpha             ;; Adjusts frame transparency
          writeroom-set-menu-bar-lines
          writeroom-set-tool-bar-lines
          writeroom-set-vertical-scroll-bars
          writeroom-set-bottom-divider-width))

  ;; Set frame transparency
  (setq writeroom-alpha 0.95))
