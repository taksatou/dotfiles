;; requires auto-complete, company, ac-company
;; see also http://sakito.jp/emacs/emacsobjectivec.html

(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))
;;(add-to-list 'auto-mode-alist '("\\.m?\\'" . objc-mode))
(setq ns-pop-up-frames nil)


(add-hook 'objc-mode-hook
          (lambda()
            (setq c-basic-offset 2)
            (setq tab-width 2)
            (define-key objc-mode-map (kbd "C-c C-o") 'ff-find-other-file)))

(if (eq system-type 'darwin)
    (progn
      (require 'ac-company)
      (ac-company-define-source ac-source-company-xcode company-xcode)

      (require 'flymake)
      (defun flymake-objc-init () (flymake-simple-make-init))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; makefile exsample
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; INCLUDE=./vendor/some_library
;; .PHONY: check-syntax
;; check-syntax:
;; 	clang -I${INCLUDE} -Wall -Wextra -Wno-unused-parameter -fsyntax-only  -miphoneos-version-min=4.3 -xobjective-c -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk *.m
;;;;;;;;;;;;;;;;;;;;;;;;;;;

      (defvar xcode:sdkver "6.0")
      (defvar xcode:sdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer")
      (defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
      (defvar xcode:sdkframeworks (concat xcode:sdk "/System/Library/Frameworks"))
      (setq ffap-c-path (append ffap-c-path `(,xcode:sdkframeworks)))

      ;; TODO
      ;;      (ffap-kpathsea-expand-path `(,(concat xcode:sdkframeworks "//")))
      (defun xcode:buildandrun ()
        (interactive)
        (sleep-for 0 300)               ; ugly work-around. sleep 300msec to avoid key conflict
        (do-applescript
         (format
          (concat
           "tell application \"Xcode\" to activate \r"
           "tell application \"System Events\" \r"
           "     tell process \"Xcode\" \r"
           "          keystroke \"r\" using {command down} \r"
           "    end tell \r"
           "end tell \r"
           "tell application \"Emacs\" to activate \r"
           ))))


      (defun xcode:buildandtest ()
        (interactive)
        (sleep-for 0 300)               ; ugly work-around. sleep 300msec to avoid key conflict
        (do-applescript
         (format
          (concat
           "tell application \"Xcode\" to activate \r"
           "tell application \"System Events\" \r"
           "     tell process \"Xcode\" \r"
           "          keystroke \"u\" using {command down} \r"
           "    end tell \r"
           "end tell \r"
           "tell application \"Emacs\" to activate \r"
           ))))

      (defun xcode:build ()
        (interactive)
        (sleep-for 0 300)               ; ugly work-around. sleep 300msec to avoid key conflict
        (do-applescript
         (format
          (concat
           "tell application \"Xcode\" to activate \r"
           "tell application \"System Events\" \r"
           "     tell process \"Xcode\" \r"
           "          keystroke \"b\" using {command down} \r"
           "    end tell \r"
           "end tell \r"
           "tell application \"Emacs\" to activate \r"
           ))))

      (add-hook 'objc-mode-hook
                (lambda()
                  (define-key objc-mode-map (kbd "C-c r") 'xcode:buildandrun)
                  (define-key objc-mode-map (kbd "C-c b") 'xcode:build)
                  (define-key objc-mode-map (kbd "C-c u") 'xcode:buildandtest)
                  (define-key objc-mode-map (kbd "C-c C-m") 'flymake-display-err-menu-for-current-line)

                  (push 'ac-source-company-xcode ac-sources)

                  (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
                  (push '("\\.mm$" flymake-objc-init) flymake-allowed-file-name-masks)
                  (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)

                  ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
                  (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                      (flymake-mode t))

                  ))
      ))

(setq ac-modes (append ac-modes '(objc-mode)))


(provide 'my-objectivec-mode)
