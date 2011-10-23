
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; java
;;(require 'jde)
(add-to-list 'load-path "~/.emacs.d/malabar-1.4.0/lisp")

(require 'cedet)
(semantic-load-enable-minimum-features) ;; or enable more if you wish
(require 'malabar-mode)

(setq malabar-groovy-lib-dir "~/.emacs.d/malabar-1.4.0/lib")
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

(provide 'my-java-mode)

