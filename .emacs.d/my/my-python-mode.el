;; (add-to-list 'load-path "~/share/emacs/site-lisp/python-mode")
;; (add-to-list 'load-path "~/share/emacs/site-lisp/python-mode/completion")
;; (setq py-install-directory "~/share/emacs/site-lisp/python-mode")

;(require 'python)
;; (require 'pymacs)
;; (require 'pycomplete)

;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)

;; (add-hook 'python-mode-hook (lambda ()
;; ;                              (load "py-mode-ext")
;; ;;                               (load "pyp")
;; ;;                               (require 'pycomplete)
;;                               (highlight-indentation-on)
;;                               ;; (define-key py-mode-map [f12] 'pyp)
;;                               ;; (define-key py-mode-map "\C-c\C-c" 'py-execute-prog)
;;                               ;; (define-key py-mode-map "\C-c\C-g" 'py-call-pdb)
;;                               ;; (define-key py-mode-map "\C-c\C-w" 'pychecker)))

;;                               ))



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

(use 'python
     (add-to-list 'auto-mode-alist '("\\.mako?\\'" . html-mode))
     (define-key python-mode-map (kbd "C-c C-k") 'kill-current-buffer))

(provide 'my-python-mode)
