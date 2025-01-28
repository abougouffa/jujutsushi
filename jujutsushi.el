;; jujutsuhsi.el --- Bring jj into your domain expansion -*- lexical-binding: t -*-

;; Copyright (©) 2024 Javier Olaechea <pirata@gmail.com>
;; Version: 0.0.1
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:

;;; Code:

(require 'cl-lib)
(require 'project)
(require 'with-editor)

(defgroup jujutsushi nil
  "Emacs interface to jujutsu version control system."
  :group 'tools)

;;;###autoload
(defun jj-describe ()
  "Open a buffer to describe the current revision."
  ;; TODO: Allow passing the revision to describe as a parameter.
  ;; TODO: Default revision-at-point, default to @ if there is no revision
  (interactive)
  (with-editor-async-shell-command
   (mapconcat #'shell-quote-argument
              (list "jj" "describe" "-r" "@") " ")
   ;; Set JJ_EDITOR so that we override the ui.editor setting.
   nil nil "JJ_EDITOR"))

;; TODO: Add the project name to the buffer name.
(defconst jj--dashboard-buffer "*jj-dashboard*"
  "Name of the buffer used to display `jj-dashboard' output.")


;; TODO: Use magit-section to delimit output
;; TODO: Annotate change-id's with an overlay
;;;###autoload
(defun jj-dashboard ()
  "Opens and refreshes the project's jj dashboard.

The dashboard shows the combined output of jj status, jj log and jj bookmark list."
  (interactive)
  (with-current-buffer (get-buffer-create jj--dashboard-buffer)
    (erase-buffer)
    (insert "jj status\n")
    (insert (shell-command-to-string "jj status"))
    (insert "\n\njj bookmark list\n")
    (insert (shell-command-to-string "jj bookmark list"))
    (insert "\n\njj log\n")
    (insert (shell-command-to-string "jj log"))
    (goto-char (point-min))
    (display-buffer (current-buffer))))


(provide 'jujutsushi)
