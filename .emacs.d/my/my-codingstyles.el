;; default setting
(setq tab-width 4)
(setq c-basic-offset 4)
(setq indent-tabs-mode nil)
(c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
;;(c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない

;;;;;;;;;;;;;;;;;;;;
;; php
(c-add-style "php/symfony"
             '((c-basic-offset . 2)
               (c-offsets-alist . (
                                   (defun-open            . 0)
                                   (defun-close           . 0)
                                   (defun-block-intro     . +)
                                   (topmost-intro         . 0)
                                   (topmost-intro-cont    . c-lineup-topmost-intro-cont)
                                   (block-open            . 0)
                                   (block-close           . 0)
                                   (statement             . 0)
                                   (statement-cont        . +)
                                   (statement-block-intro . +)
                                   (statement-case-intro  . +)
                                   (statement-case-open   . 0)
                                   (substatement          . +)
                                   (substatement-open     . 0)
                                   (case-label            . +)
                                   (comment-intro         . (c-lineup-knr-region-comment c-lineup-comment))
                                   (arglist-intro         . +)
                                   (arglist-cont          . (c-lineup-gcc-asm-reg 0))
                                   (arglist-cont-nonempty . +)
                                   (arglist-close         . 0)
                                   ))))

(c-add-style "php/zend"
             '((c-basic-offset . 4)
               (c-offsets-alist . (
                                   (defun-open            . 0)
                                   (defun-close           . 0)
                                   (defun-block-intro     . +)
                                   (topmost-intro         . 0)
                                   (topmost-intro-cont    . c-lineup-topmost-intro-cont)
                                   (block-open            . 0)
                                   (block-close           . 0)
                                   (statement             . 0)
                                   (statement-cont        . +)
                                   (statement-block-intro . +)
                                   (statement-case-intro  . +)
                                   (statement-case-open   . +)
                                   (substatement          . +)
                                   (substatement-open     . 0)
                                   (case-label            . +)
                                   (arglist-intro         . +)
                                   (arglist-cont          . (c-lineup-gcc-asm-reg 0))
                                   (arglist-cont-nonempty . +)
                                   (arglist-close         . 0)
                                   ))))

(provide 'my-codingstyles)
