(defun previous-line-and-recenter ()
  (interactive)
  (previous-line)
  (recenter))

(defun next-line-and-recenter ()
  (interactive)
  (next-line)
  (recenter))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
	(let ((name (buffer-file-name)))
	  (or (equal ?. (string-to-char (file-name-nondirectory name)))
	      (let ((mode (file-modes name)))
		(set-file-modes name (logior mode (logand (/ mode 4) 73)))
		(message (concat "Wrote " name " (+x)"))))))))

(defun install-elpa ()
  (interactive)
  (let ((buffer (url-retrieve-synchronously
                 "http://tromey.com/elpa/package-install.el")))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))
      (kill-buffer (current-buffer))))
  )

(defun template-blog (title)
  "generate blog template"
  (interactive "stitle: ")
  (let ((now (format-time-string "%Y-%m-%d")))
    (find-file (if (> 1 (length title))
		   (format "%s.txt" now)
		 (format "%s_%s.txt" now title)
		 ))))

(defun count-words-buffer ()
  (interactive)
  (message (format "words: %d" (length (split-string (buffer-string) " ")))))

(defun apply-ansi-color ()
  (interactive)
  (ansi-color-apply-on-region 0 (buffer-size)))

(defun reload-file-as-compile-log ()
  (interactive)
  (find-alternate-file (buffer-name))
  (ansi-color-apply-on-region 0 (buffer-size))
  (compilation-mode))

(defun shell-command-with-color (cmd)
  (interactive "sShell command: ")
  (let ((buf (get-buffer-create "*Shell Command Output (ansi-color)*")))
    (switch-to-buffer buf)
    (shell-command cmd buf buf)
    (help-mode-setup)                   ; help-mode-setup is contained in temp-buffer-setup-hook
    (ansi-color-apply-on-region 0 (buffer-size))))

(defun execute-alc (cmd)
  (interactive "sQuery: ")
  (let ((buf (get-buffer-create "*Dic (ansi-color)*")))
    (switch-to-buffer buf)
    (shell-command (concat "alc " cmd) buf buf)
    (help-mode-setup)                   ; help-mode-setup is contained in temp-buffer-setup-hook
    (ansi-color-apply-on-region 0 (buffer-size))))

(defun execute-make ()
  (interactive)
  (compile "make"))

(defun execute-make-clean ()
  (interactive)
  (compile "make clean"))

(defun execute-current-file ()
  (interactive)
  (cond ((eq major-mode 'c++-mode)
         (compile (format "clang++ -g -std=c++0x %s && ./a.out" (buffer-file-name))))
        ((eq major-mode 'c-mode)
         (compile (format "clang -g %s && ./a.out" (buffer-file-name))))
        ((eq major-mode 'malabar-mode)
         (compile (format "javac %s && java -cp ./ %s" (buffer-file-name) (string-inflection-camelize-function (file-name-base (buffer-file-name))))))
        ((eq major-mode 'ruby-mode)
         (compile (format "ruby %s" (buffer-file-name))))
        ((eq major-mode 'php-mode)
         (compile (format "php %s" (buffer-file-name))))
        ((eq major-mode 'python-mode)
         (compile (format "python %s" (buffer-file-name))))
        ((eq major-mode 'malabar-mode)
         (compile (format "javac -J-Dfile.encoding=UTF8 %s && java %s" (buffer-file-name) (capitalize (file-name-base (buffer-file-name))))))
        ((eq major-mode 'go-mode)
         (compile (format "go run %s" (buffer-file-name))))
        ((eq major-mode 'scala-mode)
         (compile (format "scala %s" (buffer-file-name))))
        (t
         (message (format "not implemented for %s" major-mode)))))

;; http://www.bookshelf.jp/soft/meadow_30.html#SEC404
(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )

    (switch-to-buffer-other-window other-buf)
    (other-window -1)))

(defun my-toggle-fullscreen ()
  (interactive)
  (cond
   (t
    (if (eq system-type 'darwin)
        (progn
          (if (and (>= emacs-major-version 24)
                   (>= emacs-minor-version 3))
              (toggle-frame-fullscreen)
            (ns-toggle-fullscreen)))
      (progn
        (let ((fullscreen (frame-parameter (selected-frame) 'fullscreen)))
          (cond
           ((null fullscreen)
            (set-frame-parameter (selected-frame) 'fullscreen 'fullboth))
           (t
            (set-frame-parameter (selected-frame) 'fullscreen 'nil))))))
    (redisplay))))

(defun write-to-temp-file ()
  (interactive)
  (let ((file-name (concat "/tmp/"
                           (replace-in-string (buffer-name) "/" "-")
                           "."
                           (md5 (current-time-string))
                           ".backup")))
    (write-region (point-min) (point-max) file-name)))

(defun reset-tab-width (w)
  (interactive "nwidth: ")
  (setq tab-width w))


(defun execute-five-app-lookup (key)
  (interactive "sKey: ")
  (let ((buf (get-buffer-create "*five*")))
    (shell-command (concat "fivelookup app " key) buf buf)))

(defun execute-five-campaign-lookup (key)
  (interactive "sKey: ")
  (let ((buf (get-buffer-create "*five*")))
    (shell-command (concat "fivelookup campaign " key) buf buf)))

(defun execute-five-creative-lookup (key)
  (interactive "sKey: ")
  (let ((buf (get-buffer-create "*five*")))
    (shell-command (concat "fivelookup creative " key) buf buf)))

;; evernote support
(setq mail-host-address "emacs@mojavy.ddo.jp")
(defun my-evernote-submit-current-buffer ()
    (interactive)
    (compose-mail "taksatou.24b0f@m.evernote.com"))

(provide 'my-elisp)

