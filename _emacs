;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

;; no tabs
(setq c-basic-offset 2)
(setq css-indent-offset 2)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq js-indent-level 2)
(setq default-tab-width 2)
;(setq indent-line-function 'insert-tab)
(setq tab-stop-list (number-sequence 2 200 2))

;; show trailing whitespace
(defun enable-trailing-whitespace ()
  (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook #'enable-trailing-whitespace)

;; Make ctrl-h backspace
;(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'help-command)

;; Make emacs work in mac
(set-keyboard-coding-system nil)
(setq x-alt-keysym 'meta)

;; Install MELPA package manager
(when (>= emacs-major-version 24)
 (require 'package)
 (add-to-list
  'package-archives
  '("melpa" . "http://melpa.org/packages/")
  t)
 (package-initialize))

;; Add personal binaries to path
(add-to-list 'exec-path "~/opt/bin")

;; Show line numbers
(global-linum-mode t)
(setq column-number-mode t)
(setq linum-format "%4d  ")

;; highlight matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis) ; highlight brackets if visible, else entire expression

;; highlight three of the closest delimiters from the location of the point with fixed colors
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; color theme
(load-theme 'wombat)

;; Better split navigation
(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <left>") 'windmove-left)

;; Keybindings
(global-set-key (kbd "M-s") 'isearch-forward-regexp)
(global-set-key (kbd "M-r") 'query-replace-regexp)

;; langauge modes
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)
(setq auto-mode-alist
       (append '(("\\..?css$" . css-mode))
               auto-mode-alist))
(put 'upcase-region 'disabled nil)

;; Follow symlinks to git files (like .emacs -> ~/.rc/_emacs)
(setq vc-follow-symlinks t)

;; Fix repl to same pane
;; http://stackoverflow.com/questions/29332242/is-there-a-way-to-fix-window-buffer-in-emacs-for-cider-error-repl
(add-to-list 'same-window-buffer-names "<em>nrepl</em>")
; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
	 (set-window-dedicated-p window
				 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
      (current-buffer)))

; Enable evil mode (vim emulation) and all customizations
(load-file "~/.emacs.d/personal/evil.el")

; enable lispy (paredit with vi-like keybindings)
; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))

; enable evil-cleverparens
;(require 'smartparens-config)
;(setq smartparens-strict-mode t)
;(add-hook 'clojure-mode-hook #'smartparens-mode)

;(require 'evil-cleverparens)
;(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)

; clojure

;; lookup library function signatures as you type
(add-hook 'cider-repl-mode-hook #'eldoc-mode)

;; keybindings for executing code
(global-set-key (kbd "C-c C-j") 'cider-eval-last-sexp)
(global-set-key (kbd "C-RET") 'cider-eval-defun-at-point)

; ruby
(unless (package-installed-p 'inf-ruby) (package-install 'inf-ruby)) ; install inf-ruby
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

(global-set-key (kbd "C-c C-j") 'ruby-send-line)

; enable projectile (for easy file finding)
(projectile-global-mode)

; better defaults for moving files
; https://emacs.stackexchange.com/questions/5603/how-to-quickly-copy-move-file-in-emacs-dired
(setq dired-dwim-target t)

; remove menu bar
(menu-bar-mode -1)
