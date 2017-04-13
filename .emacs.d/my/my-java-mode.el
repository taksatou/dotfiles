
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; java
;;(require 'jde)

(defun my-java-mode-hook ()
  (c-set-offset 'inexpr-class 0)
  )
(add-hook 'java-mode-hook 'my-java-mode-hook)
;; (use 'cedet
;;      (semantic-mode)
;;      (add-to-list 'load-path "~/.emacs.d/malabar-1.4.0/lisp")
;;                                         ;(semantic-load-enable-minimum-features) ;; or enable more if you wish
;;      (require 'malabar-mode)

;;      (setq malabar-groovy-lib-dir "~/.emacs.d/malabar-1.4.0/lib")
;;      (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode)))

(provide 'my-java-mode)

