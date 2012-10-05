;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (let ((buffer (url-retrieve-synchronously
;;             "http://tromey.com/elpa/package-install.el")))
;;   (save-excursion
;;     (set-buffer buffer)
;;     (goto-char (point-min))
;;     (re-search-forward "^$" nil 'move)
;;     (eval-region (point) (point-max))
;;     (kill-buffer (current-buffer))))

(setq flymake-gui-warnings-enabled nil)

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(load-file "~/.emacs.d/init.el")

(if (file-exists-p "~/.emacs.include.el")
    (load-file "~/.emacs.include.el"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(recentf-auto-cleanup (quote never))
 '(recentf-exclude (quote ("tmp")))
 '(recentf-max-saved-items 9999999)
 '(use-dialog-box nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
