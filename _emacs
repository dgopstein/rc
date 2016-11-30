;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

;; Make ctrl-h backspace
;(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "C-h") 'delete-backward-char)

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

;; show parens
(show-paren-mode 1)

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


;; switch to vi emulation (evil)
(require 'evil)
(evil-mode 1)

;; Move cursor beyond last character so that 'c-x c-e' can work
;; https://github.com/syl20bnr/spacemacs/issues/646
(setq evil-move-cursor-back nil)

;; Change cursor on evil mode change - https://github.com/7696122/evil-terminal-cursor-changer
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  )

(setq evil-motion-state-cursor 'box)
(setq evil-visual-state-cursor 'box)
(setq evil-normal-state-cursor 'box)
(setq evil-insert-state-cursor 'bar)
(setq evil-emacs-state-cursor  'hbar) ; switch to emacs-state with C-z

;;; esc quits - http://wikemacs.org/wiki/Evil
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

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


;; https://github.com/holguinj/evil-clojure-emacs/blob/master/config/evil-config.el
;; Set leader key to the spacebar
(require 'evil-leader)
(setq evil-leader/leader "<SPC>" ;; cool tip from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
      evil-leader/in-all-states t)
(global-evil-leader-mode)

(evil-leader/set-key
 "ag" 'ag-project
 "ci" 'evilnc-comment-or-uncomment-lines
 "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
 "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
 "cp" 'evilnc-comment-or-uncomment-paragraphs
 "cr" 'comment-or-uncomment-region
 "cv" 'evilnc-toggle-invert-comment-line-by-line
 "\\" 'evilnc-comment-operator
 )

; <leader> W to cleanup whitespace
(evil-leader/set-key "W" 'whitespace-cleanup)

;; Magit key (RIP Fugitive)
(evil-leader/set-key "g" 'magit-status)

;; M-+ for zoom in, M-_ for zoom out (yeah, _ is shift-minus)
(define-key evil-normal-state-map (kbd "M-+") 'text-scale-increase)
(define-key evil-normal-state-map (kbd "M-_") 'text-scale-decrease)

;; Return some Emacs conveniences to insert mode
(define-key evil-insert-state-map (kbd "C-k") 'paredit-kill)
(define-key evil-insert-state-map (kbd "C-y") 'yank)
(define-key evil-insert-state-map (kbd "C-p") 'evil-scroll-line-up)
(define-key evil-insert-state-map (kbd "C-n") 'evil-scroll-line-down)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)

;; I don't know why this is necessary:
(define-key evil-insert-state-map (kbd "C-w") 'evil-delete-backward-word)

;; move between windows like a civilized fucking human being
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up)

;; remap k to gk and j to gj
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "gk") 'evil-previous-line)
(define-key evil-normal-state-map (kbd "gj") 'evil-next-line)

(define-key evil-motion-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "gk") 'evil-previous-line)
(define-key evil-motion-state-map (kbd "gj") 'evil-next-line)


; paredit for evil
;; (require 'evil-lispy)
;; (add-hook 'emacs-lisp-mode-hook #'evil-lispy-mode)
;; (add-hook 'clojure-mode-hook #'evil-lispy-mode)
