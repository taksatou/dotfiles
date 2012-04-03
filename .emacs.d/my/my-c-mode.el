
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++ mode
(add-hook 'c-mode-hook
	  '(lambda ()
	    (setq c-basic-offset 4)
	    (setq tab-width 4)
	    (setq indent-tabs-mode nil)
            (define-key c-mode-map (kbd "C-C C-a") 'ac-start)
            )
	  )

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (setq c-basic-offset 4)
	     (setq tab-width 4)
	     (setq indent-tabs-mode nil)
             (define-key c++-mode-map (kbd "C-C C-a") 'ac-start)
             )
	  )

(provide 'my-c-mode)
