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

; Install MELPA package manager
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

;; Maximum line width
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'flyspell-mode)

;; Copy to system clipboard
;; https://gist.github.com/the-kenny/267162
(defun paste-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun copy-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

;;(setq interprogram-cut-function 'copy-to-osx)
;;(setq interprogram-paste-function 'paste-from-osx)

;; highlight matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis) ; highlight brackets if visible, else entire expression

;; highlight three of the closest delimiters from the location of the point with fixed colors
;(require 'highlight-parentheses)
;(define-globalized-minor-mode global-highlight-parentheses-mode
;  highlight-parentheses-mode
;  (lambda ()
;    (highlight-parentheses-mode t)))
;(global-highlight-parentheses-mode t)

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
;;(require 'yaml-mode)
;;(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

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

;; Grammar checking with langtool
;(require 'langtool)
;(setq langtool-language-tool-jar "~/opt/lib/LanguageTool-4.0/languagetool-commandline.jar")
;(setq langtool-default-language "en-US")
;(global-set-key "\C-x4w" 'langtool-check)
;(global-set-key "\C-x4W" 'langtool-check-done)

; Enable evil mode (vim emulation) and all customizations
(load-file "~/.emacs.d/personal/evil.el")

; Company flyspell spell-check configuration
(load-file "~/.emacs.d/personal/flyspell.el")

; Company auto-complete configuration
(load-file "~/.emacs.d/personal/company-mode.el")

; Customize python shell keybindings
(load-file "~/.emacs.d/personal/python-mode.el")

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
(add-hook 'cider-mode-hook #'eldoc-mode)

;; keybindings for executing code

(defun my-cider-mode-config ()
  "For use in `cider-mode-hook'."
  (local-set-key (kbd "C-c C-j") 'cider-eval-last-sexp)
  (local-set-key (kbd "C-RET") 'cider-eval-defun-at-point)
  (local-set-key (kbd "C-c C-v C-b") 'cider-eval-buffer)
  (local-unset-key (kbd "C-c M-."))
  (local-set-key (kbd "C-c M-.") 'cider-find-var)
  )

;; add to hook
(add-hook 'cider-mode-hook 'my-cider-mode-config)

;(require 'ac-cider)
;(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
;(add-hook 'cider-mode-hook 'ac-cider-setup)
;(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
;(eval-after-load "auto-complete"
;  '(progn
;     (add-to-list 'ac-modes 'cider-mode)
;          (add-to-list 'ac-modes 'cider-repl-mode)))
;;(setq ac-cider-show-ns nil) ; disable namespace in popup
;;; tab completion
;(defun set-auto-complete-as-completion-at-point-function ()
;  (setq completion-at-point-functions '(auto-complete)))
;
;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

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

; Use counsel/ivy for projectile completion
(add-hook 'after-init-hook 'counsel-mode)
(counsel-projectile-on)

;(require 'ein) ; iPython files
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (nodejs-repl pyenv-mode ## flyspell-correct-ivy flyspell-correct cider yaml-mode string-inflection smex scala-mode python-x pug-mode php-mode mmm-mode markdown-preview-mode langtool key-chord jedi-direx inf-ruby highlight-parentheses flycheck evil-terminal-cursor-changer evil-lispy evil-leader evil-commentary evil-cleverparens ess elpy csv-mode counsel-projectile coffee-mode brainfuck-mode auctex-lua auctex-latexmk ag ac-cider)))
 '(python-shell-interpreter "/Users/dgopstein/.pyenv/shims/python"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-echo ((t nil)) t)
 '(company-scrollbar-bg ((t (:background "#686868" :inherit company-tooltip))))
 '(company-scrollbar-fg ((t (:background "#808080"))))
 '(company-tooltip ((t (:background "#505050" :foreground "#95e454"))))
 '(company-tooltip-annotation ((t (:foreground "#73B041"))))
 '(company-tooltip-common ((t (:inherit nil :background "black"))))
 '(company-tooltip-selection ((t (:background "#686868")))))


(add-hook 'js-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))
