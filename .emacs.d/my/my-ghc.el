;; 
;; http://projects.haskell.org/haskellmode-emacs/
;; 
(add-to-list 'load-path "~/lib/emacs/haskell-mode")
(add-to-list 'load-path "~/.cabal/share/ghc-mod-0.6.2")
(load "~/lib/emacs/haskell-mode/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'font-lock-mode)



;;
;; http://www.mew.org/~kazu/proj/ghc-mod/en/
;; 
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

(provide 'my-ghc)
