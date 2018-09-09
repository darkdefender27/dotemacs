;;; init-user.el --- Customizations on base emacs.d

;; Theme
(use-package dracula-theme
  :config
  (load-theme 'dracula t))

;; Font
(set-default-font "Monaco 17")

;; Fonts & Icons
(use-package all-the-icons)

(use-package spaceline-all-the-icons
  :after spaceline
  :config (spaceline-all-the-icons-theme))

(add-to-list 'load-path "~/.emacs.d/elpa/neotree-0.5.2/")
(require 'neotree)

;; Disables audio bell
(setq ring-bell-function
      (lambda () (message "*beep*")))

;; Hide startup message
(setq inhibit-startup-message t)

;; Line numbers
(global-linum-mode t)

;; Highlight current line
(global-hl-line-mode)

;; Enable neotreee - fancy file browser
(use-package neotree
  :init
  (use-package all-the-icons)

  :config
  (global-set-key (kbd "<f5>") 'neotree-toggle)

  (setq-default neo-smart-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'nerd))
  (setq neo-show-hidden-files t)
  ;; Scale the text down a notch when in a neotree buffer
  (defun kg/text-scale-down ()
    (interactive)
    (progn
      (text-scale-adjust 0)
      (text-scale-decrease 0)))

  (add-hook 'neo-after-create-hook
            (lambda (_)
              (call-interactively #'kg/text-scale-down))))

;; Enable spaceline - fancy modeline
(use-package spaceline
  :ensure t
  :init
  (require 'spaceline-config)
  (let ((faces '(mode-line
		 mode-line-buffer-id
		 mode-line-emphasis
		 mode-line-highlight
		 mode-line-inactive)))
    (mapc
     (lambda (face) (set-face-attribute face nil :font "Menlo:weight=light:pixelsize=11"))
     faces))
  ;; solves the issue with incorrect seperator colors in modeline
  ;; powerline now takes sRGB colorspace for rendering
  (setq powerline-image-apple-rgb t)
  :config
  (spaceline-spacemacs-theme)
  (setq spaceline-workspace-numbers-unicode nil)
  (setq spaceline-window-numbers-unicode nil)
  (setq spaceline-org-clock-p nil)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-modified))

;; Reveal.js + Org mode
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(use-package ox-reveal
  :load-path "~/slides/org-reveal")

(require 'ox-reveal)
(setq Org-Reveal-root "~/slides/reveal.js")
(setq Org-Reveal-title-slide nil)

;; elpy - python development
(elpy-enable)
(setq elpy-rpc-backend "jedi")

;; Jedi configuration
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")
