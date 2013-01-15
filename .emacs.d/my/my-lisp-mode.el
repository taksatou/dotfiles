(add-to-list 'load-path "~/share/emacs/site-lisp/slime")
(add-to-list 'load-path "~/share/emacs/site-lisp/slime/contrib")

(use 'slime
     (require 'hyperspec)

     (setq auto-mode-alist (append '(("\\.lisp$" . lisp-mode)) auto-mode-alist))
     (setq auto-mode-alist (append '(("\\.cl$" . lisp-mode)) auto-mode-alist))

     (cond ((eq system-type 'darwin) (setq inferior-lisp-program "/usr/local/bin/sbcl"))
           (t (setq inferior-lisp-program "/home/takayuki/data/build/clozure-cl/ccl/./lx86cl64")))
           ;; (t (setq inferior-lisp-program "/usr/bin/sbcl")))

     (setq slime-net-coding-system 'utf-8-unix)

     (setq common-lisp-hyperspec-root
           (concat "file://" (expand-file-name "~/share//emacs/site-lisp/hyperspec/"))
           common-lisp-hyperspec-symbol-table
           (expand-file-name "~/share//emacs/site-lisp/hyperspec/Data/Data/Map_Sym.txt"))

     (add-hook 'slime-mode-hook (lambda ()
                                  (define-key slime-mode-map (kbd "M-p") 'previous-line-and-recenter)
                                  (define-key slime-mode-map (kbd "M-n") 'next-line-and-recenter)

                                  (define-key slime-mode-map (kbd "C-C C-k") 'kill-current-buffer)
                                  (define-key slime-mode-map (kbd "C-C C-o") 'slime-compile-and-load-hook)
                                  (define-key slime-mode-map (kbd "C-C C-j") 'anything)
                                  ))


                                        ;w3mの設定
     ;; (require 'w3)

     ;; ;; HyperSpecをw3mで見る
     ;; (defadvice common-lisp-hyperspec
     ;;   (around hyperspec-lookup-w3 () activate)
     ;;   (let* ((window-configuration (current-window-configuration))
     ;;          (browse-url-browser-function
     ;;           `(lambda (url new-window)
     ;;              (browse-url-w3 url nil)
     ;;              (let ((hs-map (copy-keymap w3m-mode-map)))
     ;;                (define-key hs-map (kbd "q")
     ;;                  (lambda ()
     ;;                    (interactive)
     ;;                    (kill-buffer nil)
     ;;                    (set-window-configuration ,window-configuration)))
     ;;                (use-local-map hs-map)))))
     ;;     ad-do-it))

     (use 'popwin
          (slime-setup '(slime-repl slime-fancy slime-banner))

          ;; Apropos
          (push '("*slime-apropos*") popwin:special-display-config)
          ;; Macroexpand
          (push '("*slime-macroexpansion*" :noselect t) popwin:special-display-config)
          ;; Help
          (push '("*slime-description*") popwin:special-display-config)
          ;; Compilation
          (push '("*slime-compilation*" :noselect t) popwin:special-display-config)
          ;; Cross-reference
          (push '("*slime-xref*") popwin:special-display-config)
          ;; Debugger
          (push '(sldb-mode :stick t) popwin:special-display-config)
          ;; REPL
          (push '(slime-repl-mode) popwin:special-display-config)
          ;; Connections
          (push '(slime-connection-list-mode) popwin:special-display-config)

          )

     (use 'auto-complete
          (use 'ac-slime
               (add-hook 'slime-mode-hook 'set-up-slime-ac)
               (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

               (add-to-list 'ac-modes 'lisp-mode)
               (add-to-list 'ac-modes 'slime-mode)
               (add-to-list 'ac-modes 'slime-repl-mode)
               ))
     (if (file-exists-p inferior-lisp-program)
         (slime)))

(provide 'my-lisp-mode)
