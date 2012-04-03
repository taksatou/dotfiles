;; 強制的に有効にする設定
;;
;; see also. http://d.hatena.ne.jp/rubikitch/20101126/keymap

(define-minor-mode my-overriding-mode
  "force settings"
  :init-value t                         ; デフォルト有効
  :lighter " my"                        ; mode-lineに表示しない
  :keymap `((, (kbd "C-c C-j") . anything))
  )


(provide 'my-overriding-mode)
