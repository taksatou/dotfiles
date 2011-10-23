
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++ mode
(add-hook 'c-mode-hook
	  '(lambda ()
	    (setq c-basic-offset 4)
	    (setq tab-width 4)
	    (setq indent-tabs-mode nil))
	  )

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (setq c-basic-offset 4)
	     (setq tab-width 4)
	     (setq indent-tabs-mode nil))
	  )

(provide 'my-c-mode)
