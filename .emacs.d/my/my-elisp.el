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

(defun my-compile ()
  (interactive)
  (compile
   (format "c++ %s && ./a.out" (current-buffer)) t)
  )


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

(provide 'my-elisp)
