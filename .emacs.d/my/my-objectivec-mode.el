
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.m?\\'" . objc-mode))
(setq ns-pop-up-frames nil)

(provide 'my-objetivec-mode)
