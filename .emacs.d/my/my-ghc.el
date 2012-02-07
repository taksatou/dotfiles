;; 
;; http://projects.haskell.org/haskellmode-emacs/
;; 
(when (file-exists-p "~/share/emacs/haskell-mode/haskell-site-file.el")
  (add-to-list 'load-path "~/share/emacs/haskell-mode")
  (add-to-list 'load-path "~/.cabal/share/ghc-mod-1.0.6")
  (load "~/share/emacs/haskell-mode/haskell-site-file")

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
)
(provide 'my-ghc)
