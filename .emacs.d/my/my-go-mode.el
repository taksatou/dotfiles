
(use 'go-autocomplete)

(add-hook 'go-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'godef-jump)))

(provide 'my-go-mode)

