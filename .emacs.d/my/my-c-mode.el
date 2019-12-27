
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++ mode


;; (add-hook 'c-mode-common-hook
;;           (lambda()
;;             (c-set-offset 'inextern-lang 0)))

;; (add-hook 'c-mode-hook
;;           '(lambda ()
;;              (setq c-basic-offset 4)
;;              (setq tab-width 4)
;;              (setq indent-tabs-mode nil)
;;              ;; (define-key c-mode-map (kbd "C-C C-a") 'ac-start)
;;              ;; (define-key c-mode-map (kbd "C-c C-o") 'ff-find-other-file)
;;              ))

;; (add-hook 'c++-mode-hook
;;           '(lambda ()
;;              (setq c-basic-offset 4)
;;              (setq tab-width 4)
;;              (setq indent-tabs-mode nil)
;;              (define-key c++-mode-map (kbd "C-C C-a") 'ac-start)
;;              (define-key c++-mode-map (kbd "C-c C-o") 'ff-find-other-file)))

(setq c-default-style "k&r")

;; (defun my-c-mode-hook ()
;;   (define-key c-mode-map (kbd "C-c C-o") 'ff-find-other-file)
;;   (define-key c++-mode-map (kbd "C-c C-o") 'ff-find-other-file)
;;   (setq comment-start "//")
;;   (setq comment-end "")
  
;;   (if (boundp 'cc-search-directories)
;;       nil
;;     (use 'find-file
;;          (setq-default ff-search-directories (append cc-search-directories
;;                                                      '("./include"
;;                                                        "./include/*"
;;                                                        "../include"
;;                                                        "../src"
;;                                                        ".."
;;                                                        "../..")))))
;;   (c-set-offset 'inextern-lang 0)
;;   (gtags-mode 1))

(add-hook 'cc-mode-hook 'my-c-mode-hook)
(add-hook 'c-mode-hook 'my-c-mode-hook)
          ;; (lambda()
          ;;   (define-key c-mode-map (kbd "C-c C-o") 'ff-find-other-file)
          ;;   (gtags-mode 1)))

(add-hook 'c++-mode-hook 'my-c-mode-hook)
          ;; (lambda()
          ;;   (define-key c++-mode-map (kbd "C-c C-o") 'ff-find-other-file)
          ;;   (gtags-mode 1)))

(provide 'my-c-mode)
