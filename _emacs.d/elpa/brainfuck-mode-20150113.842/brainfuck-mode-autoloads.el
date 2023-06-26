;;; brainfuck-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "brainfuck-mode" "brainfuck-mode.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from brainfuck-mode.el

(autoload 'brainfuck-mode "brainfuck-mode" "\
Major mode for brainfuck

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.bf\\'" . brainfuck-mode))

(langdoc-define-help-mode bf-help "Major mode for brainfuck help" "*Brainfuck Help*" 'bf-help-sym-called-at-point '(">" "<" "+" "-" "." "," "[" "]") 'bf-help-lookup-doc "`\\([^']+\\)'" (lambda (a b) b) (lambda (a b) b) "`" "'")

(register-definition-prefixes "brainfuck-mode" '("bf-" "brainfuck-mode-local-map" "define-bf-keymap"))

;;;***

;;;### (autoloads nil nil ("brainfuck-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; brainfuck-mode-autoloads.el ends here
