;;; flyspell-correct-ivy-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "flyspell-correct-ivy" "flyspell-correct-ivy.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from flyspell-correct-ivy.el

(autoload 'flyspell-correct-ivy "flyspell-correct-ivy" "\
Run `ivy-read' for the given CANDIDATES.

List of CANDIDATES is given by flyspell for the WORD.

Return result according to `flyspell-correct-interface'
specification.

\(fn CANDIDATES WORD)" nil nil)

(register-definition-prefixes "flyspell-correct-ivy" '("flyspell-correct-ivy-"))

;;;***

;;;### (autoloads nil nil ("flyspell-correct-ivy-pkg.el") (0 0 0
;;;;;;  0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; flyspell-correct-ivy-autoloads.el ends here
