(add-to-list 'load-path "~/share/emacs/site-lisp/slime")

(require 'slime)
(require 'hyperspec)

(setq inferior-lisp-program "sbcl")
(setq slime-net-coding-system 'utf-8-unix)

(add-hook 'lisp-mode-hook (lambda ()
                            (slime-mode t)
                            (show-paren-mode t)))

(add-hook 'slime-mode-hook (lambda ()
                             (define-key slime-mode-map (kbd "C-C C-k") 'kill-current-buffer)
                             (define-key slime-mode-map (kbd "C-C C-o") 'slime-compile-and-load-hook)
                             ))

(setq common-lisp-hyperspec-root
      (concat "file://" (expand-file-name "~/share//emacs/site-lisp/hyperspec/"))
      common-lisp-hyperspec-symbol-table
      (expand-file-name "~/share//emacs/site-lisp/hyperspec/Data/Data/Map_Sym.txt"))

;w3mの設定
(require 'w3)

;; HyperSpecをw3mで見る
(defadvice common-lisp-hyperspec
  (around hyperspec-lookup-w3 () activate)
  (let* ((window-configuration (current-window-configuration))
         (browse-url-browser-function
          `(lambda (url new-window)
             (w3m-browse-url url nil)
             (let ((hs-map (copy-keymap w3m-mode-map)))
               (define-key hs-map (kbd "q")
                 (lambda ()
                   (interactive)
                   (kill-buffer nil)
                   (set-window-configuration ,window-configuration)))
               (use-local-map hs-map)))))
    ad-do-it))

(slime-setup '(slime-autodoc))


(add-hook 'slime-inferior-process-start-hook (lambda ()
                                               (slime-mode t)))

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

(provide 'my-lisp-mode)
