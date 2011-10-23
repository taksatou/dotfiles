;;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))

;; (add-hook 'js2-mode-hook
;; 	  '(lambda ()

;; 	     (defun indent-and-back-to-indentation ()
;; 	       (interactive)
;; 	       ;;(indent-for-tab-command)
;; 	       ;; (let ((point-of-indentation
;; 	       ;;        (save-excursion
;; 	       ;;  	(back-to-indentation)
;; 	       ;;  	(point))))

;;              ;; (skip-chars-forward "\s " point-of-indentation)))
;;                (indent-according-to-mode)
;;                (skip-chars-forward "\s "))

;; 	     (js2-auto-insert-catch-block nil)
;; 	     (js2-mode-escape-quotes nil)
;; 	     (setq js2-cleanup-whitespace t)
;; 	     (setq js2-mirror-mode nil)
;; 	     (setq js2-bounce-indent-flag nil)
;; 	     (setq c-basic-offset 4)
;; 	     (setq tab-width 4)
;;              (setq indent-tabs-mode nil)

;;              (define-key js2-mode-map "\C-i" 'indent-and-back-to-indentation)
;; 	     (define-key js2-mode-map "\C-m" 'reindent-then-newline-and-indent)
;; ;;	     (define-key js2-mode-map [9] 'indent-according-to-mode) ; TAB


;; 	     ))

;; (setq js-program-name "js")
;; (defun js-other-window ()
;;   "Run js on other window"
;;   (interactive)
;;   (switch-to-buffer-other-window
;;   (get-buffer-create "*python*"))
;;   (run-scheme js-program-name))		; use 'run-scheme' for convenience

;; (define-key global-map "\C-cm" 'js-other-window)

(provide 'my-javascript-mode)
