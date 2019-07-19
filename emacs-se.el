;;; emacs-se --- Sound effect on Emacs

;; Copyright (C) 2019- blue0513

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

;; Author: blue0513
;; Package-Requires: ((sound-wav "1.0.0"))
;; URL: https://github.com/blue0513/emacs-se
;; Version: 0.1.0

;;; Commentary:

;; This package is fully respecting
;; + http://emacs.rubikitch.com/sound-wav/
;; + http://rubikitch.com/f/160817113854.sound-wav.el

;; In init.el, you should write
;; (require 'emacs-se)

;;; Code:

(require 'sound-wav)

(defcustom emacs-se--find-file nil
  "Sound for find-file."
  :type 'string
  :group 'emacs-se)

(defcustom emacs-se--enter nil
  "Sound for Enter."
  :type 'string
  :group 'emacs-se)

(defcustom emacs-se--delete nil
  "Sound for Delete."
  :type 'string
  :group 'emacs-se)

(defcustom emacs-se--type nil
  "Sound for typing."
  :type 'string
  :group 'emacs-se)

(defcustom emacs-se--space nil
  "Sound for Space."
  :type 'string
  :group 'emacs-se)

(defcustom emacs-se--random-time 50
  "Randomness of playing sound."
  :type 'integer
  :group 'emacs-se)

(defun emacs-se--play-sound (sound-path)
  (interactive)
  (ignore-errors
    (if (file-exists-p sound-path)
        (sound-wav-play (expand-file-name sound-path))
      (message "No Sound path found"))))

(defun emacs-se--select-sound ()
  (cl-case last-command-event
    (?\s emacs-se--space)
    ('backspace emacs-se--delete)
    ((?\C-m 'return) emacs-se--enter)
    (t (when (emacs-se--random-play)
         emacs-se--type))))

(defun emacs-se--random-play ()
  (zerop (random emacs-se--random-time)))

(defun emacs-se--find-file-hook--sound ()
  (emacs-se--play-sound
   (expand-file-name emacs-se--find-file)))

(defun emacs-se--post-command-hook--sound ()
  (let* ((sound (emacs-se--select-sound)))
    (emacs-se--play-sound sound)))

(defun toggle-emacs-se ()
  (interactive)
  (if emacs-se-minor-mode
      (emacs-se-minor-mode 0)
    (emacs-se-minor-mode 1)))

(define-minor-mode emacs-se-minor-mode
  :init-value nil
  :global t
  :keymap nil
  :lighter " SE"
  (if emacs-se-minor-mode
      (progn
        (add-hook 'find-file-hook
                  'emacs-se--find-file-hook--sound)
        (add-hook 'post-command-hook
                  'emacs-se--post-command-hook--sound))
    (progn
      (remove-hook 'find-file-hook
                   'emacs-se--find-file-hook--sound)
      (remove-hook 'post-command-hook
                   'emacs-se--post-command-hook--sound))))

;; * provide

(provide 'emacs-se)

;;; emacs-se.el ends here
