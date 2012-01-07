;;;;;;;;;;;;;;;;;;;;;;
;; load files
;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (append load-path '("~/.emacs.d"
                                    "~/.emacs.d/my"
				    "~/.emacs.d/auto-install"
				    ;;
                                    ;; add paths here
				    ;;
				    )))

;;;;;;;;;;;;;;;;;;;;;;
;; global keybinds
;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\M-c" 'uncomment-region)
(global-set-key "\C-c\C-v" 'compile)

(global-set-key "\C-ck" 'windmove-up)
(global-set-key "\C-cj" 'windmove-down)
(global-set-key "\C-ch" 'windmove-left)
(global-set-key "\C-cl" 'windmove-right)

(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\C-cq" 'help-command)
(global-set-key "\C-]" 'undo)

(global-set-key "\C-m" 'reindent-then-newline-and-indent)
(global-set-key "\C-m" 'newline)
(global-set-key "\C-l" 'recenter)

(global-set-key "\C-x\C-w" 'delete-trailing-whitespace)

(global-set-key (kbd "C-<return>") "\n")

(global-set-key "\C-t" nil) ;; avoid conflict

;;;;;;;;;;;;;;;;;;;;;;
;; base settings
;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq frame-background-mode 'dark)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq column-number-mode t)
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/bak"))
            backup-directory-alist))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(cond (window-system
       (setq x-select-enable-clipboard t)))

(when (require 'color-theme nil t)
  (color-theme-zenburn))

(iswitchb-mode 0)


;;;;;;;;;;;;;;;;;;;;;;
;; base utils
;;;;;;;;;;;;;;;;;;;;;;
(defmacro use (pkg &rest body)
  `(if (require ,pkg nil t)
       (progn ,@body
	      (message (format "Using %s" ,pkg)))
     (message (format "Unable to use %s" ,pkg))
     ))

;;;;;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;;;;;
(use 'my-elisp
     (global-set-key "\M-p" 'previous-line-and-recenter)
     (global-set-key "\M-n" 'next-line-and-recenter)
     (global-set-key "\C-c\C-k" 'kill-current-buffer)
     (add-hook 'after-save-hook 'make-file-executable)
     )


(use 'dired
     (define-key dired-mode-map (kbd "C-<return>") 'dired-find-file)
     (define-key dired-mode-map (kbd "C-j") 'dired-find-file))

;; emacs kaizen book
(use 'uniquify
     (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
     (setq uniquify-ignore-bufffeers-re "*[*^]+*"))

;; (use 'ffap
;;      (ffap-bindings)
;;      )

;; http://homepage3.nifty.com/oatu/emacs/archives/auto-save-buffers.el
(use 'auto-save-buffers
     (run-with-idle-timer 30 t 'auto-save-buffers))

;; from-emacswiki
(use 'point-undo
     (define-key global-map (kbd "<f7>") 'point-undo)
     (define-key global-map (kbd "S-<f7>") 'point-redo))

(use 'goto-chg
     (define-key global-map (kbd "<f8>") 'goto-last-change)
     (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))

;; http://cvs.savannah.gnu.org/viewvc/*checkout*/bm/bm/bm.el
(use 'bm
     (setq-default bm-buffer-persistence t)
     (setq bm-restore-repository-on-load t)
     (add-hook 'find-file-hooks 'bm-buffer-restore)
     (add-hook 'kill-buffer-hook 'bm-buffer-save)
     (add-hook 'after-save-hook 'bm-buffer-save)
     (add-hook 'after-revert-hook 'bm-buffer-restore)
     (add-hook 'vc-before-checkin-hook 'bm-buffer-save)
     (global-set-key (kbd "M-SPC") 'bm-toggle)
     (global-set-key (kbd "M-[") 'bm-previous)
     (global-set-key (kbd "M-]") 'bm-next))

(use 'gist)

;;;;;;;;;;;;;;
;; wget http://www.emacswiki.org/emacs/download/auto-install.el
;; see also. http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
(use 'auto-install
     (auto-install-update-emacswiki-package-name t)
     (auto-install-compatibility-setup)
     (setq ediff-window-setup-function 'ediff-setup-windows-plain))

(use 'anything-startup)

(use 'recentf-ext
     (setq recentf-max-saved-item 50000)
     (setq recentf-exclude '("/tmp/")))


;; http://d.hatena.ne.jp/syohex/20111201/1322665378
(use 'quickrun
;;     (push '("*quickrun*") popwin:special-display-config)
     (global-set-key (kbd "<f5>") 'quickrun))

(use 'my-ghc)

(use 'my-local)


;; http://users.skynet.be/ppareit/projects/graphviz-dot-mode/graphviz-dot-mode.el
;; http://d.hatena.ne.jp/n9d/20080419/1208614482
(use 'graphviz-dot-mode)
;;(load-file "PATH_TO_FILE/graphviz-dot-mode.el") 