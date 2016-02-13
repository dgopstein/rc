;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

;; Make ctrl-h backspace
(define-key key-translation-map [?\C-h] [?\C-?])

;; Make emacs work in mac
(set-keyboard-coding-system nil)
