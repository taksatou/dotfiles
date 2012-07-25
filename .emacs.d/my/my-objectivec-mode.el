;; requires auto-complete, company, ac-company

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
      (add-hook 'objc-mode-hook
                (lambda()
                  (push 'ac-source-company-xcode ac-sources)))
      ))

(setq ac-modes (append ac-modes '(objc-mode)))

(ac-set-trigger-key "C-M-i")
(provide 'my-objectivec-mode)
