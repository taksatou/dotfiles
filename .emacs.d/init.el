;;;;;;;;;;;;;;;;;;;;;;
;; load files
;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (append load-path '("~/.emacs.d"
                                    "~/.emacs.d/my"
                                    "~/share/emacs"
                                    "~/share/emacs/site-lisp"
                                    "~/share/emacs/color-theme"
                                    "~/.emacs.d/auto-install"
                                    "~/.emacs.d/ddskk-15.1"
                                    "~/.emacs.d/malabar-1.4.0/lisp"
                                    "~/.emacs.d/auto-complete"
                                    "~/.emacs.d/vendor"
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
(global-set-key "\C-c\C-l" nil) ;; disable toggle-electric-state


;;;;;;;;;;;;;;;;;;;;;;
;; base settings
;;;;;;;;;;;;;;;;;;;;;;
(if (boundp 'tool-bar-mode)
    (tool-bar-mode 0))


(if (boundp 'scroll-bar-mode)
    (scroll-bar-mode 0))

;; (if (boundp 'x-window-system-initialization-alist)
;;     (if (assq 'x-window-system-initialization-alist)
;;         (progn
;;           (tool-bar-mode 0)
;;           (scroll-bar-mode 0)
;;           )))
(menu-bar-mode 0)

(setq scroll-step 2)
(setq scroll-conservatively 100000)
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
(add-hook 'dired-mode-hook 'toggle-truncate-lines)

(cond (window-system
       (cond ((eq system-type 'darwin)
              (setq x-select-enable-clipboard t)
              (set-frame-parameter (selected-frame) 'alpha '(90 70))

              ;; font
              ;; http://sakito.jp/emacs/emacs23.html#id17
              (when (>= emacs-major-version 23)
                (set-face-attribute 'default nil
                                    :family "monaco"
                                    :height 110)
                (set-fontset-font
                 (frame-parameter nil 'font)
                 'japanese-jisx0208
                 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
                (set-fontset-font
                 (frame-parameter nil 'font)
                 'japanese-jisx0212
                 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
                (set-fontset-font
                 (frame-parameter nil 'font)
                 'mule-unicode-0100-24ff
                 '("monaco" . "iso10646-1"))
                (setq face-font-rescale-alist
                      '(("^-apple-hiragino.*" . 1.2)
                        (".*osaka-bold.*" . 1.2)
                        (".*osaka-medium.*" . 1.2)
                        (".*courier-bold-.*-mac-roman" . 1.0)
                        (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
                        (".*monaco-bold-.*-mac-roman" . 0.9)
                        ("-cdac$" . 1.3)))))
             
             ((eq system-type 'gnu/linux)
              (set-face-attribute 'default nil
                                  :family "Ricty"
                                  :height 120
                                  :weight 'normal
                                  )
              (set-fontset-font (frame-parameter nil 'font)
                                'japanese-jisx0208
                                (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))
              (set-fontset-font (frame-parameter nil 'font)
                                'japanese-jisx0212
                                (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))
              (set-fontset-font (frame-parameter nil 'font)
                                'katakana-jisx0201
                                (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))

              ))
                   
              
       ;(setenv "LC_ALL" "en_US.UTF-8")
       ))

(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
;;(set-language-environment 'Japanese)

;; set font size
(if (display-graphic-p)
    (set-face-attribute 'default nil :height 105))

(iswitchb-mode 0)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default Man-notify-method 'pushy)

(setq-default require-final-newline nil)

;; (add-hook 'before-save-hook
;; 	  (lambda ()
;; 	    (delete-trailing-whitespace)))

;; elisp bible p.268
(require 'generic-x)
;(add-hook 'text-mode-hook 'auto-fill-mode)
;(add-hook 'text-mode-hook '(lambda () (skk-mode 1)))

(show-paren-mode t)

;(hs-minor-mode t)                       ;

;;;;;;;;;;;;;;;;;;;;;;
;; base utils
;;;;;;;;;;;;;;;;;;;;;;
(defmacro use (pkg &rest body)
  `(if (require ,pkg nil t)
       (progn ,@body
              (message (format "Using %s" ,pkg)))
     (message (format "Unable to use %s" ,pkg))
     ))

(defvar kmacro-save-file "~/.emacs.d/my/kmacro-save.el" "keymacro file")
(defun kmacro-save (symbol)
  (interactive "SName for last kbd macro: ")
  (name-last-kbd-macro symbol)
  (with-current-buffer (find-file-noselect kmacro-save-file)
    (goto-char (point-max))
    (insert-kbd-macro symbol)
    (basic-save-buffer)))


;;;;;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;;;;;
(use 'color-theme
     (require 'cus-edit)
     (require 'org-faces)
     ;(color-theme-zenburn)
     (color-theme-initialize)
     (cond (window-system
           (color-theme-dark-blue2)))
     
     ;; (color-theme-deep-blue)
     )

(use 'gtags
     (setq gtags-path-style 'relative))

(use 'my-elisp
     (global-set-key "\M-p" 'previous-line-and-recenter)
     (global-set-key "\M-n" 'next-line-and-recenter)
     (global-set-key "\C-c\C-k" 'kill-current-buffer)
     (global-set-key "\M-@" 'shell-command-with-color)
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

(use 'auto-complete
     (setq load-path (append load-path '("~/.emacs.d/auto-complete/lib/ert"
                                         "~/.emacs.d/auto-complete/lib/fuzzy"
                                         "~/.emacs.d/auto-complete/lib/popup"))))

(use 'auto-complete-config
     (add-to-list 'ac-dictionary-directories "~/share/emacs/site-lisp/ac-dict")
     (ac-config-default)

     (global-auto-complete-mode t)
;;     (auto-complete-mode t)

     (setq ac-auto-start nil)
     (global-set-key (kbd "M-/") 'ac-start) ;; override dabbrev-expand
     (define-key ac-complete-mode-map (kbd "RET") 'ac-stop) ;; test

     (define-key ac-complete-mode-map "\C-n" 'ac-next)
     (define-key ac-complete-mode-map "\C-p" 'ac-previous)
     (ac-set-trigger-key "C-M-i")

     ;; (define-key ac-complete-mode-map "\M-/" 'ac-stop)

     ;; (global-set-key "\C-c\C-a" 'ac-start)
     ;; (global-set-key "\C-c\C-q" 'ac-stop)

     (add-to-list 'ac-sources 'ac-source-yasnippet)

     (defun emacs-lisp-ac-setup ()
       (setq ac-sources (append '(ac-source-words-in-same-mode-buffers ac-source-symbols) ac-sources)))
     (add-hook 'emacs-lisp-mode-hook 'emacs-lisp-ac-setup)

)


;; from-emacswiki
(use 'point-undo
     (define-key global-map (kbd "<f7>") 'point-undo)
     (define-key global-map (kbd "S-<f7>") 'point-redo))

(use 'goto-chg
     (define-key global-map (kbd "<f8>") 'goto-last-change)
     (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))

;; http://cvs.savannah.gnu.org/viewvc/*checkout*/bm/bm/bm.el
(use 'bm
     ;; (setq-default bm-buffer-persistence t)
     ;; (setq bm-restore-repository-on-load t)
     ;; (add-hook 'find-file-hooks 'bm-buffer-restore)
     ;; (add-hook 'kill-buffer-hook 'bm-save)
     ;; (add-hook 'after-save-hook 'bm-save)
     ;; (add-hook 'after-revert-hook 'bm-buffer-restore)
     ;; (add-hook 'vc-before-checkin-hook 'bm-save)
     (global-set-key (kbd "M-SPC") 'bm-toggle)
     (global-set-key (kbd "M-[") 'bm-previous)
     (global-set-key (kbd "M-]") 'bm-next))

(use 'gist)

;;;;;;;;;;;;;;
;; wget http://www.emacswiki.org/emacs/download/auto-install.el
;; see also. http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
(use 'auto-install
;     (auto-install-update-emacswiki-package-name t)
     (auto-install-compatibility-setup)
     (setq ediff-window-setup-function 'ediff-setup-windows-plain))


(use 'recentf-ext
     (custom-set-variables '(recentf-auto-cleanup (quote never)))
     (custom-set-variables '(recentf-max-saved-items 9999999))
     (custom-set-variables '(recentf-exclude '("tmp"))))

(use 'anything-startup
     (global-set-key (kbd "C-c C-j") 'anything)

     (use 'anything-gtags)
     (use 'anything-config
          (add-to-list 'anything-sources
                       'anything-c-source-files-in-current-dir
                       'anything-c-source-emacs-commands
		       )))


;;;;;;;;;;;;;;;;;;;;;;
;; html-mode
(use 'html-mode
     (define-key html-mode-map (kbd "C-c C-v") 'compile))

(use 'mustache-mode
     (add-to-list 'auto-mode-alist '("\\.mustache?\\'" . mustache-mode))
     )

;; http://d.hatena.ne.jp/syohex/20111201/1322665378
(use 'quickrun
     ;;     (push '("*quickrun*") popwin:special-display-config)
     (global-set-key (kbd "<f5>") 'quickrun))

(use 'paredit)

(use 'my-ghc)
(use 'my-c-mode
     )

(use 'my-codingstyles)
(use 'my-local)

;; http://users.skynet.be/ppareit/projects/graphviz-dot-mode/graphviz-dot-mode.el
;; http://d.hatena.ne.jp/n9d/20080419/1208614482
;(use 'graphviz-dot-mode)
;;(load-file "PATH_TO_FILE/graphviz-dot-mode.el")

(use 'tramp
     (setq tramp-default-method "scpx")
     )

(use 'yaml-mode
     (add-to-list 'auto-mode-alist '("\\.yml?\\'" . yaml-mode))
     (add-to-list 'auto-mode-alist '("\\.yaml?\\'" . yaml-mode))

     (add-hook 'yaml-mode-hook
               '(lambda ()
                  (use 'yaml-mode-ext)))
     )

(use 'markdown-mode
     (add-to-list 'auto-mode-alist '("\\.md?\\'" . markdown-mode))
     (add-to-list 'auto-mode-alist '("\\.markdown?\\'" . markdown-mode))

     (define-key markdown-mode-map (kbd "C-M-b") 'backward-sexp)
     (define-key markdown-mode-map (kbd "C-M-f") 'forward-sexp)
     (define-key markdown-mode-map (kbd "M-p") 'previous-line-and-recenter)
     (define-key markdown-mode-map (kbd "M-n") 'next-line-and-recenter)

     (add-hook 'markdown-mode-hook 'skk-mode))


(use 'php-mode
     (define-key php-mode-map (kbd "C-c C-a") 'my-global-map)
     
     (use 'symfony
          (define-key sf:minor-mode-map (kbd "C-c ; m") 'sf-cmd:model-files)
          (define-key sf:minor-mode-map (kbd "C-c ; a") 'sf-cmd:action-files)
          (define-key sf:minor-mode-map (kbd "C-c ; h") 'sf-cmd:helper-files)
          (define-key sf:minor-mode-map (kbd "C-c ; j") 'sf-cmd:js-files)
          (define-key sf:minor-mode-map (kbd "C-c ; v") 'sf-cmd:template-files)
          (define-key sf:minor-mode-map (kbd "C-c ; e") 'sf-cmd:relative-files)
          (define-key sf:minor-mode-map (kbd "C-c ; c") 'sf-cmd:config-files))

     (add-hook 'php-mode-hook
               '(lambda ()
                  (c-set-style "php/symfony"))))

;; (use 'mmm-mode
;;      (setq mmm-global-mode 'maybe)
;;      (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
;;      (mmm-add-classes
;;       '((html-php
;;       :submode php-mode
;;       :front "<\\?\\(php\\)?"
;;       :back "\\?>")))
;;      (add-to-list 'auto-mode-alist '("\\.php?\\'" . html-mode))
;;      )


;; (use 'highlight-parentheses
;;      (define-globalized-minor-mode global-highlight-parentheses-mode
;;        highlight-parentheses-mode
;;        (lambda ()
;;          (highlight-parentheses-mode t)))
;;      (global-highlight-parentheses-mode t)
;;      (setq hl-paren-colors '("color-208" "color-213" "color-148" "")))

(use 'highline
     (highline-mode-on)
     (if (or (not (window-system)) (not (eq system-type 'darwin)))
         (setq highline-face 'hl-line)))

(use 'highlight-symbol)

(use 'my-overriding-mode
     (add-hook 'html-mode-hook '(lambda () (auto-fill-mode 0)))
     )

(use 'my-lisp-mode)

;; (use 'popwin
;;      (setq display-buffer-function 'popwin:display-buffer))


(use 'my-python-mode)

(use 'edit-server
     (edit-server-start)
     )

(use 'skk
     (setq skk-server-portnum 1178)
     (setq skk-server-host "localhost"))

     ;; (add-hook 'isearch-mode-hook
     ;;           (function (lambda ()
     ;;                       (and (boundp 'skk-mode) skk-mode
     ;;                            (skk-isearch-mode-setup)))))
     ;; (add-hook 'isearch-mode-end-hook
     ;;           (function (lambda ()
     ;;                       (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
     ;;                       (and (boundp 'skk-mode-invoked) skk-mode-invoked
     ;;                            (skk-set-cursor-properly)))))

(use 'my-objectivec-mode)
(use 'applescript-mode)
(use 'my-javascript-mode)

(use 'dired-x
     (setq dired-omit-files "^\\...+$"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ffap settings
;; (ffap-bindings)
;; (setq ffap-kpathsea-depth 5)
(setq ff-other-file-alist
      '(("\\.mm$" (".h"))
        ("\\.m$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".m" ".mm" ".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake
(use 'flymake
     (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
       (setq flymake-check-was-interrupted t))
     (ad-activate 'flymake-post-syntax-check)

     ;; flymake 現在行のエラーをpopup.elのツールチップで表示する
     (defun flymake-display-err-menu-for-current-line ()
       (interactive)
       (let* ((line-no             (flymake-current-line-no))
              (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no))))
         (when line-err-info-list
           (let* ((count           (length line-err-info-list))
                  (menu-item-text  nil))
             (while (> count 0)
               (setq menu-item-text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                      (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
                 (if file
                     (setq menu-item-text (concat menu-item-text " - " file "(" (format "%d" line) ")"))))
               (setq count (1- count))
               (if (> count 0) (setq menu-item-text (concat menu-item-text "\n")))
               )
             (popup-tip menu-item-text)))))

     (global-set-key "\C-c\C-m" 'flymake-display-err-menu-for-current-line)
     )

;; cshartp
;; (add-to-list 'auto-mode-alist '("\\.cs?\\'" . (lambda ()
;;                                                 ;; load csharp-mode lazily
;;                                                 (use 'csharp-mode)
;;                                                 (csharp-mode))))


;; (use 'csharp-mode
;;      (setq auto-mode-alist
;;            (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;;      (defun my-csharp-mode-fn ()
;;        "function that runs when csharp-mode is initialized for a buffer."
;;        (turn-on-auto-revert-mode)
;;        (setq indent-tabs-mode nil)
;;        (require 'flymake)
;;        (flymake-mode 1)
;;        (require 'yasnippet)
;;        (yas/minor-mode-on)
;;        (require 'rfringe)
;;        ...insert more code here...
;;        ...including any custom key bindings you might want ...
;;        )
;;      (add-hook  'csharp-mode-hook 'my-csharp-mode-fn t))

;; (use 'multi-term
;;      (setq multi-term-program "/bin/zsh"))

(use 'my-java-mode
     (define-key malabar-mode-map (kbd "C-c C-a") 'my-global-map))

(use 'open-junk-file)
(use 'summarye)

(use 'all)
(use 'tail)

;; override keybinds
(use 'nxml-mode
     (define-key nxml-mode-map (kbd "M-h") 'backward-kill-word))

(use 'color-moccur
     (use 'moccur-edit))

;;
;; http://kray.jp/blog/emacs-lisp-7/
;;
(use 'wdired
     (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
     (define-key wdired-mode-map (kbd "C-g") 'wdired-abort-changes))

(use 'browse-kill-ring
     (global-set-key (kbd "C-c C-l k") 'browse-kill-ring)
     (setq browse-kill-ring-quit-action 'kill-and-delete-window)
     (setq browse-kill-ring-highlight-current-entry t))


;; yas
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(use 'yasnippet
     (yas-global-mode 1)
     (use 'dropdown-list
          (setq yas-prompt-functions '(yas-dropdown-prompt
                                       yas-ido-prompt
                                       yas-completing-prompt)))

     (define-prefix-command 'my-yas-map)
     (global-set-key (kbd "C-c C-y") 'my-yas-map)
     (define-key my-yas-map (kbd "C-y") 'yas/insert-snippet)
     (define-key my-yas-map (kbd "C-c") 'yas/new-snippet)

     (use 'auto-complete-yasnippet)

     )

(use 'my-ruby-mode)

(use 'inf-php
     ;(setq inf-php-enable-launch-workaround t)
     )

(if (file-exists-p "~/.emacs.include.el")
    (add-hook 'emacs-startup-hook '(lambda () (load-file "~/.emacs.include.el"))))


;; 
;; git-gutter
;; 
(if window-system
    (use 'git-gutter-fringe
         (set-face-foreground 'git-gutter-fr:modified "yellow")
         (set-face-foreground 'git-gutter-fr:added    "cyan")
         (set-face-foreground 'git-gutter-fr:deleted  "magenta"))
  (use 'git-gutter))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;; http://d.hatena.ne.jp/syohex/20120304/1330822993
(use 'ace-jump-mode
     (global-set-key (kbd "C-c C-SPC") 'ace-jump-mode))


;;
;; should be the last
;; 
(use 'my-keys)
