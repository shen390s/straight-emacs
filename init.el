;; -*- lexical-binding: t -*-

;; This file wraps the primary Radian configuration (which lives in
;; radian.el) so that we don't have to wrap the entire file in various
;; `let' forms, etc. We put as much as possible in radian.el.

;; This allows us to instead load a different Emacs configuration by
;; exporting USER_EMACS_DIRECTORY to another .emacs.d directory.

(defvar radian-minimum-emacs-version "26.1"
  "Radian Emacs does not support any Emacs version below this.")

(defvar radian-local-init-file
  (expand-file-name "init.local.el" user-emacs-directory)
  "File for local customizations of Radian.")

;; Prevent package.el from modifying this file.
(setq package-enable-at-startup nil)

;; Prevent Custom from modifying this file.
(setq custom-file (expand-file-name
                   (format "custom-%d-%d.el" (emacs-pid) (random))
                   temporary-file-directory))

;; Make sure we are running a modern enough Emacs, otherwise abort
;; init.
(if (version< emacs-version radian-minimum-emacs-version)
    (error (concat "Radian Emacs requires at least Emacs %s, "
                   "but you are running Emacs %s")
           radian-minimum-emacs-version emacs-version)

  (defvar radian-lib-file (expand-file-name
                           "radian.el"
                           user-emacs-directory)
          "File containing main Radian configuration.
This file is loaded by init.el.")

  (unless (file-exists-p radian-lib-file)
    (error "Library file %S does not exist" radian-lib-file))

  (defvar radian--finalize-init-hook nil
    "Hook run unconditionally after init, even if it fails.
Unlike `after-init-hook', this hook is run every time the
init-file is loaded, not just once.")

  (unwind-protect
      ;; Load the main Radian configuration code.
      (load radian-lib-file nil 'nomessage)
    (run-hooks 'radian--finalize-init-hook)))
