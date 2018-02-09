;; Slightly adapted from:
;; https://github.com/wavexx/python-x.el/blob/master/python-x.el
(defun python-shell-send-region-or-line ()
  "Send the current region to the inferior Python process, if active.
   Otherwise, send the current line."
  (interactive)
  (if (use-region-p)
    (python-shell-send-region (region-beginning) (region-end))
    (python-shell-send-line)))

(defun my-python-mode-config ()
  "For use in `cider-mode-hook'."
  (local-unset-key (kbd "C-c C-b"))
  (local-set-key   (kbd "C-c C-b") 'python-x-shell-send-buffer)
  (local-unset-key (kbd "C-c C-c"))
  (local-set-key   (kbd "C-c C-c") 'python-shell-send-region-or-line)
  (local-unset-key (kbd "C-c C-r"))
  (local-set-key   (kbd "C-c C-r") 'python-shell-send-region-or-paragraph)
  )

;; add to hook
(add-hook 'python-mode-hook 'my-python-mode-config)
