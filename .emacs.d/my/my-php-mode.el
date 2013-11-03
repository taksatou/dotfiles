
;;;;;;;;;;;;;;;;;;;;;;;;;
;; php
;; (require 'php-mode)
;; (add-hook  'php-mode-hook
;;            (lambda ()
;;              (when (require 'auto-complete nil t)
;;                (make-variable-buffer-local 'ac-sources)
;;                (add-to-list 'ac-sources 'ac-source-php-completion)
;;                ;; if you like patial match,
;;                ;; use `ac-source-php-completion-patial' instead of `ac-source-php-completion'.
;;                ;; (add-to-list 'ac-sources 'ac-source-php-completion-patial)
;;                (auto-complete-mode t))))

(defun my-php-mode-hook ()
  (gtags-mode 1))

(add-hook 'php-mode-hook 'my-php-mode-hook)


(provide 'my-php-mode)
