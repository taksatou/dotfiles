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
(setq recentf-auto-cleanup 'never)

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  
  ;; (require 'package)
  (add-to-list 'package-archives 
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

(load-file "~/.emacs.d/init.el")

(if (file-exists-p "~/.emacs.include.el")
    (load-file "~/.emacs.include.el"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(popwin:special-display-config (quote ((slime-connection-list-mode) (slime-repl-mode) (sldb-mode :stick t) ("*slime-xref*") ("*slime-compilation*" :noselect t) ("*slime-description*") ("*slime-macroexpansion*" :noselect t) ("*slime-apropos*") ("*Help*") ("*Completions*" :noselect t) ("*compilation*" :noselect t) ("*Occur*" :noselect t))))
 '(recentf-auto-cleanup (quote never))
 '(recentf-exclude (quote ("tmp")))
 '(recentf-max-saved-items 9999999)
 '(safe-local-variable-values (quote ((eval when (and (buffer-file-name) (file-regular-p (buffer-file-name)) (string-match-p "^[^.]" (buffer-file-name))) (emacs-lisp-mode) (unless (featurep (quote package-build)) (let ((load-path (cons ".." load-path))) (require (quote package-build)))) (package-build-minor-mode)) (Package . DRAKMA) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby") (Package . CL-FAD) (Package . CL-PPCRE) (Package . CL-USER) (Syntax . COMMON-LISP) (change-log-indent-text . 2) (add-log-time-format lambda nil (let* ((time (current-time)) (system-time-locale "C") (diff (+ (cadr time) 32400)) (lo (% diff 65536)) (hi (+ (car time) (/ diff 65536)))) (format-time-string "%a %b %e %H:%M:%S %Y" (list hi lo) t))) (Syntax . ANSI-Common-Lisp) (Base . 10))))
 '(use-dialog-box nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
