;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka" :size 24 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/kimsia-org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; for some reason the projectile discovery-projects-in-discovery is now missing
;; so i am following this iadvice https://www.reddit.com/r/DoomEmacs/comments/qiwfj2/comment/him9olr/?utm_source=share&utm_medium=web2x&context=3
;; (setq projectile-project-search-path '("~/Dendron/vault/org/" "~/Projects/"))

;; M-x projectile-discover-projects-in-search-path
;;(add-hook 'after-init-hook #'toggle-frame-maximized)
(delete-selection-mode 1)

(after! org
  (setq org-capture-templates
        `(("i" "Inbox" entry (file "todo.org")
           ,(concat "* TODO %?\n"
                    "/Entered on/ %u")))))

(defun kimsia/org-inbox-capture ()
  (interactive)
  "Capture a task in agenda mode."
  (org-capture nil "i"))

(map! :map org-agenda-mode-map "c" #'kimsia/org-inbox-capture)

(setq org-agenda-custom-commands `((" " "Agenda"
                                      ((agenda ""
                                               ((org-agenda-span 'week)
                                                (org-deadline-warning-days 365)))
                                       (todo "TODO"
                                             ((org-agenda-overriding-header "Inbox")
                                              (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'deadline))))
                                       (tags "proj1"
                                             ((org-agenda-overriding-header "Project 1")))
                                       (tags "proj2"
                                             ((org-agenda-overriding-header "Project 2")))))))
