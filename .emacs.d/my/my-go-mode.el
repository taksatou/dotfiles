
(use 'go-autocomplete)

(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'godef-jump)))

;; flymake
(add-to-list 'load-path (format "%s/src/github.com/dougm/goflymake" (getenv "GOPATH")))
(use 'go-flymake)


(provide 'my-go-mode)

