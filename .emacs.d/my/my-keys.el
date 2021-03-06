;;
;; my prefix
;;
(define-prefix-command 'my-global-map)
(global-set-key (kbd "C-c C-a") 'my-global-map)

(define-prefix-command 'my-global2-map)
(global-set-key (kbd "C-c C-q") 'my-global2-map)

(define-key my-global-map (kbd "C-o") 'moccur-grep-find)
(use 'fold-dwim
     (define-key my-global-map (kbd "0") 'hs-minor-mode)
     (define-key my-global-map (kbd "C-f") 'fold-dwim-toggle)
     ;; useful aliases
     ;; (define-key my-global-map-a (kbd "C-<SPC>") 'pop-global-mark)
     )


;;
;; fix prefixkey
;;
(define-key c-mode-map (kbd "C-c C-a") 'my-global-map)
(define-key c++-mode-map (kbd "C-c C-a") 'my-global-map)
(define-key objc-mode-map (kbd "C-c C-a") 'my-global-map)
(define-key java-mode-map (kbd "C-c C-a") 'my-global-map)
(use 'inf-ruby
     (define-key inf-ruby-mode-map (kbd "C-c C-a") 'my-global-map))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (define-key sql-interactive-mode-map (kbd "C-c C-a") 'my-global-map)))
;; (add-hook 'inf-ruby-mode-hook
;;           (lambda ()
;;             (define-key inf-ruby-mode-map (kbd "C-c C-a") 'my-global-map)))

(add-hook 'diff-mode-hook
          (lambda ()
            (define-key diff-mode-map (kbd "C-c C-a") 'my-global-map)))
(add-hook 'html-mode-hook
          (lambda ()
            (define-key html-mode-map (kbd "C-c C-a") 'my-global-map)))
(add-hook 'sgml-mode-hook
          (lambda ()
            (define-key sgml-mode-map (kbd "C-c C-a") 'my-global-map)))
(add-hook 'comint-mode-hook
          (lambda ()
            (define-key comint-mode-map (kbd "C-c C-a") 'my-global-map)
            (message "hook for comint")))
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (define-key sql-interactive-mode-map (kbd "C-c C-a") 'my-global-map)))
(add-hook 'conf-space-mode-hook
          (lambda ()
            (define-key conf-space-mode-map (kbd "C-c C-a") 'my-global-map)))
(add-hook 'csharp-mode-hook
          (lambda ()
            (define-key csharp-mode-map (kbd "C-c C-a") 'my-global-map)))

;;
;; git gutter
;;
(define-key my-global-map (kbd "C-l")
  (lambda ()
    (interactive)
    (git-gutter-mode +1)))
;(define-key my-global-map (kbd "9") 'git-guttertoggle)
(define-key my-global-map (kbd "C-n") 'git-gutter:next-hunk)
(define-key my-global-map (kbd "C-p") 'git-gutter:previous-hunk)
(define-key my-global-map (kbd "C-d") 'git-gutter:popup-hunk)
;(define-key my-global-map (kbd "C-h") 'git-gutter+-popup-hunk)

;;
;; gtags
;;
(add-hook 'gtags-mode-hook
          (lambda ()
            (define-key gtags-mode-map (kbd "M-.") 'gtags-find-tag)
            (define-key gtags-mode-map (kbd "M-,") 'gtags-find-rtag)
            (define-key gtags-mode-map (kbd "M-*") 'gtags-pop-stack)))


(define-key my-global-map (kbd "C-j") 'anything-gtags-select)
(define-key my-global-map (kbd "C-k") 'skk-mode)
(define-key my-global-map (kbd "C-w") 'delete-trailing-whitespace)


;;  this doesnt work...
;; (defun anything-gtags-from-here ()
;;   (interactive)
;;   (anything
;;    :source '(anything-c-source-gtags-select)
;;    :input (thing-at-point 'symbol)))

(define-key my-global-map (kbd "C-SPC") 'window-toggle-division)
(define-key my-global-map (kbd "t") 'toggle-truncate-lines)

(define-key my-global-map (kbd "C-a") 'execute-alc)
(define-key my-global-map (kbd "C-c") 'execute-make-clean)
(define-key my-global-map (kbd "C-v") 'execute-make)
(define-key my-global-map (kbd ";") 'execute-current-file)
(define-key my-global-map (kbd "C-;") 'execute-current-file)

(define-key my-global-map (kbd "C-m") 'man)
(define-key my-global-map (kbd "C-0") 'my-toggle-fullscreen)
(define-key my-global-map (kbd "C-r") 'reset-tab-width)
(define-key my-global-map (kbd "C-b") 'reload-file-as-compile-log)
(define-key my-global-map (kbd "C-e") 'flymake-display-err-menu-for-current-line)

(use 'dash-at-point
     (define-key my-global-map (kbd "q") 'dash-at-point))

(defun region-to-osx (start end)
  (interactive "r")
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc (buffer-substring start end))
      (process-send-eof proc))))
(defun paste-to-osx ()
  (interactive)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc (buffer-string))
      (process-send-eof proc))))
(defun paste-from-osx ()
  (interactive)
  (insert (shell-command-to-string "pbpaste")))
(define-key my-global-map (kbd "C-w") 'paste-to-osx)
(define-key my-global-map (kbd "C-y") 'paste-from-osx)
(define-key my-global-map (kbd "C-q") 'region-to-osx)

(provide 'my-keys)
