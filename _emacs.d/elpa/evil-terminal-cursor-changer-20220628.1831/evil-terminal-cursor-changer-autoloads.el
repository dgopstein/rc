;;; evil-terminal-cursor-changer-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "evil-terminal-cursor-changer" "evil-terminal-cursor-changer.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from evil-terminal-cursor-changer.el

(autoload 'evil-terminal-cursor-changer-activate "evil-terminal-cursor-changer" "\
Enable evil terminal cursor changer." t nil)

(defalias 'etcc-on 'evil-terminal-cursor-changer-activate)

(autoload 'evil-terminal-cursor-changer-deactivate "evil-terminal-cursor-changer" "\
Disable evil terminal cursor changer." t nil)

(defalias 'etcc-off 'evil-terminal-cursor-changer-deactivate)

(register-definition-prefixes "evil-terminal-cursor-changer" '("etcc-"))

;;;***

;;;### (autoloads nil nil ("evil-terminal-cursor-changer-pkg.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; evil-terminal-cursor-changer-autoloads.el ends here
