;;; pug-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pug-mode" "pug-mode.el" (0 0 0 0))
;;; Generated autoloads from pug-mode.el

(autoload 'pug-mode "pug-mode" "\
Major mode for editing Pug files.

\\{pug-mode-map}

\(fn)" t nil)

(autoload 'pug-compile "pug-mode" "\
Compile the current pug file into html, using pug-cli.

If the universal argument is supplied, render pretty HTML (non-compressed).

\(fn &optional ARG)" t nil)

(add-to-list 'auto-mode-alist '("\\.\\(?:jade\\|pug\\)\\'" . pug-mode))

(register-definition-prefixes "pug-mode" '("pug-"))

;;;***

;;;### (autoloads nil nil ("pug-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pug-mode-autoloads.el ends here
