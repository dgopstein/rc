;; clojure auto-complete
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; don't overide C-h with the help screen
(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-h") nil)
  (define-key company-active-map (kbd "M-h") 'company-show-doc-buffer))

(setq company-idle-delay 0.3) ; default is 0.5

;; tooltip colors
;; https://github.com/mattrudder/dotfiles/blob/69f0f5766f2444b834429e98e1c88f29c9021560/emacs.d/themes/wombat-custom-theme.el
(require 'color)
(custom-set-faces
  '(company-tooltip ((t (:background "#505050" :foreground "#95e454"))))
  '(company-tooltip-annotation ((t (:foreground "#73B041")))) ; package names
  '(company-tooltip-selection ((t (:background "#686868")))) ; cursor bar highlight
  '(company-scrollbar-bg ((t (:background "#686868" :inherit company-tooltip))))
  '(company-scrollbar-fg ((t (:background "#808080"))))
  '(company-echo ((t nil)))
  '(company-tooltip-common ((t (:inherit nil :background "black")))) ; highlights the search term in the results
  )
