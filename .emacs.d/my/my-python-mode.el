
;; ;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; python
;; (setq python-program-name "python -i")
;; ;; (autoload 'python-mode "python" "Major mode for Scheme." t)
;; ;; (autoload 'run-python "python" "Run an inferior Scheme process." t)

;; (defun python-other-window ()  
;;   "Run python on other window"  
;;   (interactive)  
;; ;  (switch-to-buffer-other-window
;; ;   (get-buffer-create "*python*"))  
;;   (run-python python-program-name))  

;; (define-key global-map "\C-cp" 'python-other-window)

;; (when (load "python" t)
;;   (define-key python-mode-map "\C-c\C-c" 'comment-region)
;;   (define-key python-mode-map "\C-c\C-g" 'python-send-buffer)
;; )
