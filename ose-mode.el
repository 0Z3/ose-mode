(defvar ose-mode-hook nil)

(defun newline-and-slash ()
  (interactive)
  (newline 1)
  (insert "/"))
    
(defvar ose-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-slash)
    map)
  "Keymap for ose major mode")

(add-to-list 'auto-mode-alist '("\\.ose\\'" . ose-mode))

(defconst ose-pfx-face '(:foreground "#FFFFFF" :weight 'bold))

(defconst ose-font-lock-keywords
  (list
   ;; string literal: /s/
   '("^/\\(s\\|'\\)/\\(.*\\)" .
     '((1 ose-pfx-face)
       (2 font-lock-string-face)))
   ;; numeric literal: /i/ /f/ /b/
   '("^/\\(i\\|f\\|b\\)/\\(.*\\)" .
     '((1 ose-pfx-face)))
   ;; lookup: /$/
   '("^/\\(\\$\\)/\\(.*\\)" .
     '((1 ose-pfx-face)
       (2 font-lock-variable-name-face)))
   ;; assign: /@/
   '("^/\\(\\@\\)/\\(.*\\)" .
     '((1 ose-pfx-face)
       (2 '(:foreground "#CCCC00"))))
   ;; apply/funcall: /!/
   '("^/\\(!\\)/\\(.*\\)" .
     '((1 ose-pfx-face)
       (2 font-lock-function-name-face)))
   ;; copy/move: />/ /</ /<</ /-
   '("^/\\(>\\|<+\\|-\\)/\\(.*\\)" .
     '((1 ose-pfx-face)
       (2 font-lock-builtin-face)))
   ;; comment: /#/
   '("^/\\(#\\)/\\(.*\\)" .
     '((1 font-lock-comment-delimiter-face)
       (2 font-lock-comment-face))))
  "Highlight built in addresses")


(define-derived-mode ose-mode nil "Ose"
  "Major mode for editing Ose files."
  (setq-local font-lock-defaults '(ose-font-lock-keywords))
  (setq-local comment-start "/#/")
  )

(run-hooks 'ose-mode-hook)
(provide 'ose-mode)
