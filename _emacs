;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

;; Make ctrl-h backspace
(define-key key-translation-map [?\C-h] [?\C-?])

;; Make emacs work in mac
(set-keyboard-coding-system nil)

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

;; show parens
(show-paren-mode 1)
