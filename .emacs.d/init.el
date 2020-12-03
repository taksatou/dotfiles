;;;;;;;;;;;;;;;;;;;;;;
;; load files
;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (append load-path '("~/.emacs.d"
                                    "~/.emacs.d/my"
                                    ;;
                                    ;; add paths here
                                    ;;
                                    )))


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

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

(global-set-key (kbd "C-c C-_") 'shrink-window)
(global-set-key (kbd "C-c _") 'shrink-window)
(global-set-key (kbd "C-c C-=") 'enlarge-window)
(global-set-key (kbd "C-c =") 'enlarge-window)
(global-set-key (kbd "C-c 0") 'shrink-window-horizontally)
(global-set-key (kbd "C-c C-0") 'shrink-window-horizontally)
(global-set-key (kbd "C-c \\") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c C-\\") 'enlarge-window-horizontally)

;;;;;;;;;;;;;;;;;;;;;;
;; base settings
;;;;;;;;;;;;;;;;;;;;;;
;; (if (boundp 'tool-bar-mode)
;;     (tool-bar-mode 0))


(if (boundp 'scroll-bar-mode)
    (scroll-bar-mode 0))

;; (if (boundp 'x-window-system-initialization-alist)
;;     (if (assq 'x-window-system-initialization-alist)
;;         (progn
;;           (tool-bar-mode 0)
;;           (scroll-bar-mode 0)
;;           )))
(menu-bar-mode 0)

(setq-default show-trailing-whitespace t)
(setq hscroll-step 1)
(setq scroll-step 1)
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
(add-hook 'compilation-filter-hook
          (lambda ()
            (ansi-color-apply-on-region 0 (buffer-size))))

(add-to-list 'exec-path "/usr/local/bin")

(defun split-window-below (&optional size)
  (interactive "P")
  (split-window nil size'below))

(defadvice split-window (before my-split-window)
  (interactive "P")
  ;; letの中でad-set-argしてもなぜか動かない
  (message (format "arg: %s, %s, %s" (ad-get-arg 0) (ad-get-arg 1) (ad-get-arg 2)))
  (if (and (null (ad-get-arg 2))
           (< (window-height) (/ (window-width) 2)))
      (ad-set-arg 2 t)))

(ad-activate 'split-window)


(setq electric-indent-mode nil)

;;
;; http://stackoverflow.com/questions/4076360/error-in-dired-sorting-on-os-x
;;
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(add-to-list 'default-frame-alist
             '(font . "Dejavu Sans Mono-14"))

(cond (window-system

       ;; font
       (cond
        ;;
        ;; mac
        ;;
        ((eq system-type 'darwin)
         (setq ns-use-native-fullscreen nil)
         (setq x-select-enable-clipboard t)
         (set-frame-parameter (selected-frame) 'alpha '(93 85))
         (global-set-key (kbd "s-t") nil)

         ;; http://sakito.jp/emacs/emacs23.html#id17
         (when (>= emacs-major-version 23)
           (set-face-attribute 'default nil
                               :family "monaco"
                               :height 110)
           (set-fontset-font (frame-parameter nil 'font)
                             'japanese-jisx0208
                             '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
           (set-fontset-font (frame-parameter nil 'font)
                             'japanese-jisx0212
                             '("Hiragino Kaku Gothic Pro" . "iso10646-1"))
           (set-fontset-font (frame-parameter nil 'font)
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
        ;;
        ;; linux
        ;;
        ((eq system-type 'gnu/linux)
         (setq x-select-enable-clipboard t)
;         (set-frame-parameter (selected-frame) 'alpha '(93 70))

         (set-face-attribute 'default nil
                             :family "Ricty"
                             :height 110)

         (set-face-attribute 'default nil
                             :family "Ricty Discord"
                             :height 120)
         (set-fontset-font (frame-parameter nil 'font)
                           'japanese-jisx0208
                           (cons "Ricty Discord" "iso10646-1"))
         (set-fontset-font (frame-parameter nil 'font)
                           'japanese-jisx0212
                           (cons "Ricty Discord" "iso10646-1"))
         (set-fontset-font (frame-parameter nil 'font)
                           'katakana-jisx0201
                           (cons "Ricty Discord" "iso10646-1"))
         ;; ;;
         ;; ;; なぜか日本語フォントでboldがまざってしまうのを回避するためのwork around
         ;; ;;
         ;; (add-hook 'after-init-hook
         ;;           (lambda ()
         ;;             (set-fontset-font (frame-parameter nil 'font)
         ;;                               'japanese-jisx0208
         ;;                               (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))
         ;;             (set-fontset-font (frame-parameter nil 'font)
         ;;                               'japanese-jisx0212
         ;;                               (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))
         ;;             (set-fontset-font (frame-parameter nil 'font)
         ;;                               'katakana-jisx0201
         ;;                               (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))
         ;;             (set-fontset-font (frame-parameter nil 'font)
         ;;                               'mule-unicode-0100-24ff
         ;;                               (font-spec :family "Ricty" :weight 'bold :registry "iso10646-1"))))
;                           '("monaco" . "iso10646-1"))

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

(defun current-buffer-mode ()
  "Returns the major mode associated with a buffer."
  (interactive)
  (message "%s" major-mode))


;;;;;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;;;;;
(ac-config-default)

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



;; from-emacswiki
(use 'point-undo
     (define-key global-map (kbd "<f7>") 'point-undo)
     (define-key global-map (kbd "S-<f7>") 'point-redo))

(use 'goto-chg
     (define-key global-map (kbd "<f8>") 'goto-last-change)
     (define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse))



(use 'gist)


(use 'recentf
     (custom-set-variables '(recentf-auto-cleanup (quote never)))
     (custom-set-variables '(recentf-max-saved-items 9999999))
     (custom-set-variables '(recentf-exclude '("tmp"))))

;;;;;;;;;;;;;;;;;;;;;;
;; html-mode
(use 'html-mode
     (define-key html-mode-map (kbd "C-c C-v") 'compile))

(use 'mustache-mode
     (add-to-list 'auto-mode-alist '("\\.mustache?\\'" . mustache-mode))
     )



(use 'paredit)

(use 'my-c-mode)

(use 'my-codingstyles)

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
     (define-key markdown-mode-map (kbd "C-c C-k") 'kill-current-buffer)
     (define-key markdown-mode-map (kbd "C-c C-j") 'counsel-recentf)

;;     (add-hook 'markdown-mode-hook 'skk-mode)
     )


(use 'php-mode
     (define-key php-mode-map (kbd "C-c C-a") 'my-global-map)
     (define-key php-mode-map (kbd "C-c C-k") 'kill-current-buffer)

     (use 'symfony
          (define-key sf:minor-mode-map (kbd "C-c ; m") 'sf-cmd:model-files)
          (define-key sf:minor-mode-map (kbd "C-c ; a") 'sf-cmd:action-files)
          (define-key sf:minor-mode-map (kbd "C-c ; h") 'sf-cmd:helper-files)
          (define-key sf:minor-mode-map (kbd "C-c ; j") 'sf-cmd:js-files)
          (define-key sf:minor-mode-map (kbd "C-c ; v") 'sf-cmd:template-files)
          (define-key sf:minor-mode-map (kbd "C-c ; e") 'sf-cmd:relative-files)
          (define-key sf:minor-mode-map (kbd "C-c ; c") 'sf-cmd:config-files)

          )

     (add-hook 'php-mode-hook
               '(lambda ()
                  (gtags-mode t)
                  (c-set-style "php/symfony")
                  (setq comment-start "//")
                  (setq comment-end ""))))

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


;; highline changes goal-column behavior, so I switched to hl-line
;; (use 'hl-line
;;      (global-hl-line-mode)
;;      (custom-set-faces
;;       '(hl-line ((t (:background "#262626"))))))


(use 'highlight-symbol)

;; (use 'my-overriding-mode
;;      (add-hook 'html-mode-hook '(lambda () (auto-fill-mode 0)))
;;      )

;; (use 'my-lisp-mode)

;; (use 'popwin
;;      (popwin-mode 1))


;; (use 'my-python-mode)
;; (use 'my-php-mode)

;; (use 'edit-server
;;      (edit-server-start)
;;      (define-key edit-server-edit-mode-map (kbd "C-x C-s") 'write-to-temp-file)
;;      (define-key edit-server-edit-mode-map (kbd "C-x C-c") 'edit-server-done))

;; (use 'skk
;;      (setq skk-server-portnum 1178)
;;      (setq skk-server-host "localhost"))

     ;; (add-hook 'isearch-mode-hook
     ;;           (function (lambda ()
     ;;                       (and (boundp 'skk-mode) skk-mode
     ;;                            (skk-isearch-mode-setup)))))
     ;; (add-hook 'isearch-mode-end-hook
     ;;           (function (lambda ()
     ;;                       (and (boundp 'skk-mode) skk-mode (skk-isearch-mode-cleanup))
     ;;                       (and (boundp 'skk-mode-invoked) skk-mode-invoked
     ;;                            (skk-set-cursor-properly)))))

;; (use 'my-objectivec-mode)
;; (use 'applescript-mode)
;; (use 'my-javascript-mode)
(add-hook 'js-mode-hook
          '(lambda ()
             (define-key js-mode-map (kbd "C-c C-a") 'my-global-map)
             (define-key js-mode-map (kbd "C-c C-j") 'counsel-recentf)))
(setq js-indent-level 2)


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
        ("\\.h$"   (".c" ".cc" ".cxx" ".cpp" ".m" ".mm" ".C" ".CC" ))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake
;; (use 'flymake
;;      (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
;;        (setq flymake-check-was-interrupted t))
;;      (ad-activate 'flymake-post-syntax-check)

;;      ;; flymake 現在行のエラーをpopup.elのツールチップで表示する
;;      (defun flymake-display-err-menu-for-current-line ()
;;        (interactive)
;;        (let* ((line-no             (flymake-current-line-no))
;;               (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no))))
;;          (when line-err-info-list
;;            (let* ((count           (length line-err-info-list))
;;                   (menu-item-text  nil))
;;              (while (> count 0)
;;                (setq menu-item-text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                       (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;                  (if file
;;                      (setq menu-item-text (concat menu-item-text " - " file "(" (format "%d" line) ")"))))
;;                (setq count (1- count))
;;                (if (> count 0) (setq menu-item-text (concat menu-item-text "\n")))
;;                )
;;              (popup-tip menu-item-text)))))

;;      (global-set-key "\C-c\C-m" 'flymake-display-err-menu-for-current-line)
;;      )

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

(add-hook 'java-mode-hook
          '(lambda ()
             (define-key java-mode-map (kbd "C-c C-a") 'my-global-map)
             (define-key java-mode-map (kbd "C-c C-k") 'kill-current-buffer)))

;; (use 'my-java-mode
;;      (define-key malabar-mode-map (kbd "C-c C-a") 'my-global-map))
;; (use 'my-java-mode)

;; (use 'coffee-mode
;;      ;; coffeescript
;;      (custom-set-variables
;;       '(coffee-tab-width 2)
;;       '(coffee-args-compile '("-c" "--bare")))

;;      (eval-after-load "coffee-mode"
;;        '(progn
;;           (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
;;           (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)
;;           (define-key coffee-mode-map (kbd "C-c C-k") 'kill-current-buffer)
;;           (define-key coffee-mode-map (kbd "C-c C-a C-y") 'coffee-compile-buffer))))


;; (use 'open-junk-file)
;; (use 'summarye)

;; (use 'all)
;; (use 'tail)

;; override keybinds
(use 'nxml-mode
     (define-key nxml-mode-map (kbd "M-h") 'backward-kill-word))

(use 'color-moccur
     (use 'moccur-edit)
     (setq dmoccur-exclusion-mask (append dmoccur-exclusion-mask '("vendor")))
     )

;;
;; http://kray.jp/blog/emacs-lisp-7/
;;
(use 'wdired
     (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
     (define-key wdired-mode-map (kbd "C-g") 'wdired-abort-changes))


;; (use 'my-ruby-mode)

(use 'inf-php
     (setq inf-php-enable-launch-workaround t)
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

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


;; http://d.hatena.ne.jp/syohex/20120304/1330822993
;; (use 'ace-jump-mode
;;      (global-set-key (kbd "C-c C-SPC") 'ace-jump-mode))

(use 'region-bindings-mode
     (region-bindings-mode-enable)

     (use 'multiple-cursors
          ;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
          (define-key region-bindings-mode-map (kbd "s") 'mc/skip-to-next-like-this)
          (define-key region-bindings-mode-map (kbd "M-s") 'mc/skip-to-previous-like-this)
          (define-key region-bindings-mode-map (kbd "N") 'mc/unmark-next-like-this)
          (define-key region-bindings-mode-map (kbd "P") 'mc/unmark-previous-like-this)
          (define-key region-bindings-mode-map (kbd "n") 'mc/mark-next-like-this)
          (define-key region-bindings-mode-map (kbd "p") 'mc/mark-previous-like-this)))

(defun my-go-switch-test ()
  (interactive)
  (let* ((name (file-name-nondirectory (buffer-file-name)))
         (a (replace-regexp-in-string "\\.go$" "_test.go" name))
         (b (replace-regexp-in-string "_test\\.go$" ".go" name)))
    (message (format "trying <%s> or <%s>" a b))
    (if (and (not (eql a name)) (file-exists-p a)) (find-file a)
      (if (and (not (eql b name)) (file-exists-p b)) (find-file b)
        (message (format "not found <%s> or <%s>" a b))))))

(use 'go-mode
     (use 'my-go-mode)
     (define-key go-mode-map (kbd "C-c C-a") 'my-global-map)
     (define-key go-mode-map (kbd "C-c C-j") 'counsel-recentf)
     (add-hook 'go-mode-hook
               '(lambda ()
                  (define-key go-mode-map (kbd "C-c C-o") 'my-go-switch-test)
                  (c-set-offset 'inextern-lang 0)
                  (setq indent-tabs-mode nil))))



(use 'protobuf-mode
     (add-hook 'protobuf-mode-hook
               '(lambda ()
                  (define-key protobuf-mode-map (kbd "C-c C-a") 'my-global-map)
                  (define-key protobuf-mode-map (kbd "C-c C-k") 'kill-current-buffer))))

(add-hook 'conf-colon-mode-hook
          '(lambda ()
             (define-key conf-mode-map (kbd "C-c C-a") 'my-global-map)))

(add-hook 'conf-mode-hook
          '(lambda ()
             (define-key conf-mode-map (kbd "C-c C-a") 'my-global-map)))

(use 'ivy
     ;; official default small settings
     (ivy-mode 1)
     (setq ivy-use-virtual-buffers t)
     (setq enable-recursive-minibuffers t)
     ;; enable this if you want `swiper' to use it
     ;; (setq search-default-mode #'char-fold-to-regexp)
     (global-set-key "\C-s" 'swiper)
     (global-set-key (kbd "C-c C-r") 'ivy-resume)
     (global-set-key (kbd "<f6>") 'ivy-resume)
     (global-set-key (kbd "M-x") 'counsel-M-x)
     (global-set-key (kbd "C-x C-f") 'counsel-find-file)
     (global-set-key (kbd "<f1> f") 'counsel-describe-function)
     (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
     (global-set-key (kbd "<f1> l") 'counsel-find-library)
     (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
     (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
     (global-set-key (kbd "C-x g") 'counsel-git)
     (global-set-key (kbd "C-x j") 'counsel-git-grep)
     (global-set-key (kbd "C-x k") 'counsel-ag)
     (global-set-key (kbd "C-x l") 'counsel-locate)
     (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
     (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

     ;; my setting
     (global-set-key (kbd "C-c C-j") 'counsel-recentf)

     )

(use 'string-inflection
     (global-set-key (kbd "C-c C-f C-c") 'string-inflection-all-cycle)
     (global-set-key (kbd "C-c C-f C-p") 'string-inflection-camelcase)
     (global-set-key (kbd "C-c C-f C-u") 'string-inflection-upcase)
     )

(use 'vue-html-mode
     (add-to-list 'auto-mode-alist '("\\.vue?\\'" . vue-html-mode))
     (add-hook 'vue-html-mode-hook
               '(lambda ()
                  (define-key vue-html-mode-map (kbd "C-c C-f C-c") 'string-inflection-all-cycle)
                  (define-key vue-html-mode-map (kbd "C-c C-j") 'counsel-recentf)
                  (define-key vue-html-mode-map (kbd "C-c C-a C-f") 'sgml-skip-tag-forward)
                  (define-key vue-html-mode-map (kbd "C-c C-a C-b") 'sgml-skip-tag-backward)))
)
;;
;; should be the last
;;
(use 'my-keys)

