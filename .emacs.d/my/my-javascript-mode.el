;;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-jsx-mode))

(add-hook 'javascript-mode-hook
          '(lambda ()
             (setq js-indent-level 2)
             (setq c-basic-offset 2)
             (setq tab-width 2)
             (setq indent-tabs-mode nil)
             ))

(add-hook 'js2-mode-hook
          '(lambda ()
             (define-key js2-mode-map (kbd "C-c C-a") 'my-global-map)

             (define-key js2-mode-map (kbd "C-c C-s") 'js2-mode-hide-functions)
             (define-key js2-mode-map (kbd "C-c C-o") 'js2-mode-show-functions)

             (define-key js2-mode-map (kbd "C-c C-e") nil)

             (setq js2-global-externs (list "require" "export" "module" "FIVE" ))
             (setq js2-strict-missing-semi-warning nil)
             (setq js2-strict-trailing-comma-warning nil)
             ))


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
