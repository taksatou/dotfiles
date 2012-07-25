;; requires auto-complete, company, ac-company
;; see also http://sakito.jp/emacs/emacsobjectivec.html

(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))
;;(add-to-list 'auto-mode-alist '("\\.m?\\'" . objc-mode))
(setq ns-pop-up-frames nil)


(add-hook 'objc-mode-hook
          (lambda()
            (define-key objc-mode-map (kbd "C-c C-o") 'ff-find-other-file)))

(if (eq system-type 'darwin)
    (progn
      (require 'ac-company)
      (ac-company-define-source ac-source-company-xcode company-xcode)

      (require 'flymake)
      (defvar xcode:gccver "4.2.1")
      (defvar xcode:sdkver "5.1")
      (defvar xcode:sdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer")
      (defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
      (defvar xcode:sdkframeworks (concat xcode:sdk "/System/Library/Frameworks"))
      (defvar flymake-objc-compiler "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc")
      (defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
      (defvar flymake-last-position nil)
      (defvar flymake-objc-compile-options '("-I."))
      (defun flymake-objc-init ()
        (let* ((temp-file (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
               (local-file (file-relative-name
                            temp-file
                            (file-name-directory buffer-file-name))))
          (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

      (setq ffap-c-path (append ffap-c-path `(,xcode:sdkframeworks)))

      ;; TODO
      ;;      (ffap-kpathsea-expand-path `(,(concat xcode:sdkframeworks "//")))

      (add-hook 'objc-mode-hook
                (lambda()
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
