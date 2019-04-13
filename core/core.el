
(defvar doom-emacs-dir (file-truename user-emacs-directory))
(defvar doom-core-dir (concat doom-emacs-dir "core/"))
(defvar doom-modules-dir (concat doom-emacs-dir "modules/"))
(defvar doom-local-dir (concat doom-emacs-dir ".local/"))

(load (concat doom-core-dir "core-packages") nil t)

(provide 'core)
;;; core.el ends here
