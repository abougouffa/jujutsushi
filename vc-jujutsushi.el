;; jujutsuhsi-vc.el --- Teach vc about jujutsu projects -*- lexical-binding: t -*-

;; Copyright (©) 2024 Javier Olaechea <pirata@gmail.com>
;; Version: 0.0.1
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary

;; Status Legend:
;; - ✔: Done
;; - DNA does not apply: The decision is that we won't
;; - ?: Not done. It has yet to be decided whether or not it should be implemented
;;
;;  Some of the functions are mandatory (marked with a `*'), others are optional
;; (`-').
;;
;; BACKEND PROPERTIES
;;
;; * revision-granularity: ✔
;; - update-on-retrieve-tag: ✔
;;
;; STATE-QUERYING FUNCTIONS
;;
;; * registered (file)
;; * state (file)
;; - dir-status-files (dir files update-function)
;; - dir-extra-headers (dir)
;; - dir-printer (fileinfo)
;; - status-fileinfo-extra (file)
;; * working-revision (file)
;; * checkout-model (files)
;; - mode-line-string (file)
;;
;; STATE-CHANGING FUNCTIONS
;;
;; * create-repo ()
;; * register (files &optional comment)
;; - responsible-p (file)
;; - receive-file (file rev)
;; - unregister (file)
;; * checkin (files comment &optional rev)
;; - checkin-patch (patch-string comment)
;; * find-revision (file rev buffer)
;; * checkout (file &optional rev)
;; * revert (file &optional contents-done)
;; - merge-file (file &optional rev1 rev2)
;; - merge-branch ()
;; - merge-news (file)
;; - pull (prompt)
;; - steal-lock (file &optional revision)
;; - modify-change-comment (files rev comment)
;; - mark-resolved (files)
;; - find-admin-dir (file)
;;
;; HISTORY FUNCTIONS
;;
;; * print-log (files buffer &optional shortlog start-revision limit)
;; * log-outgoing (buffer remote-location)
;; * log-incoming (buffer remote-location)
;; - log-search (buffer pattern)
;; - log-view-mode ()
;; - show-log-entry (revision)
;; - comment-history (file)
;; - update-changelog (files)
;; * diff (files &optional rev1 rev2 buffer async)
;; - revision-completion-table (files)
;; - annotate-command (file buf &optional rev)
;; - annotate-time ()
;; - annotate-current-time ()
;; - annotate-extract-revision-at-line ()
;; - region-history (file buffer lfrom lto)
;; - region-history-mode ()
;; - mergebase (rev1 &optional rev2)
;; - last-change (file line)
;;
;; TAG/BRANCH SYSTEM
;;
;; - create-tag (dir name branchp)
;; - retrieve-tag (dir name update)
;;
;; MISCELLANEOUS
;;
;; - make-version-backups-p (file)
;; - root (file)
;; - ignore (file &optional directory remove)
;; - ignore-completion-table (directory)
;; - find-ignore-file (file): ✔
;; - previous-revision (file rev)
;; - file-name-changes (rev)
;; - next-revision (file rev)
;; - log-edit-mode ()
;; - check-headers ()
;; - delete-file (file)
;; - rename-file (old new)
;; - find-file-hook ()
;; - extra-menu ()
;; - extra-dir-menu ()
;; - conflicted-files (dir)
;; - repository-url (file-or-dir &optional remote-name)
;; - prepare-patch (rev)
;; - clone (remote directory rev)

;;; Code:

(require 'cl-lib)
(require 'vc)

(defgroup vc-jujutsu nil
  "VC JJ backend."
  :group 'vc)

;; put into
;; vc-handled-backends

(defun vc-jj-revision-granularity () 'repository)
(defun vc-git-checkout-model (_files) 'implicit)
(defun vc-git-update-on-retrieve-tag () nil)

(defun vc-jj-root (file)
  (vc-find-root file ".jj"))

;; jujutsu uses .gitignore
(defun vc-jj-find-ignore-file (file)
  "Return the git ignore file that controls FILE."
  (expand-file-name ".gitignore"
                    (vc-git-root file)))

(defun vc-jj-create-repo ()
  ;; TODO: Implement this. We need to call `jj init default-default-directory'
  ;; (vc-jj-command "init")
  )

(provide 'jujutsushi-vc)
