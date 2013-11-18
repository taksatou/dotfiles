
(use 'go-autocomplete)

(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (local-set-key (kbd "M-.") 'godef-jump)
            (local-set-key (kbd "C-c ;") 'go-import-add)))
(add-hook 'before-save-hook
		  (lambda ()
			(gofmt-before-save)))

;; flymake
(add-to-list 'load-path (format "%s/src/github.com/dougm/goflymake" (getenv "GOPATH")))
(use 'go-flymake)


(provide 'my-go-mode)

