;;; ewth-mode.el --- Display weather info in mode-line -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Free Software Foundation, Inc.
;; License: GPL-3.0-or-later

;; Author: ISouthRain
;; Version: 0.1
;; Package-Requires: ((emacs "26.1") (request "0.3.0"))
;; Keywords: convenience, weather, mode-line
;; URL: https://github.com/ISouthRain/ewth.el

;;; Commentary:

;; ewth is a global minor mode that displays current weather information
;; in the mode-line using data from wttr.in.
;;
;; Usage:
;; (require 'ewth-mode)
;; (setq ewth-url "http://wttr.in/london?format=2&M")
;; (setq ewth-update-interval 300) ;; in seconds
;; (ewth-mode 1)

;;; Code:

(require 'request)

(defgroup ewth nil
  "Weather display in mode-line."
  :group 'convenience
  :prefix "ewth-")

(defcustom ewth-url "http://wttr.in/London?format=2&M"
  "Full URL to fetch weather data from wttr.in.
Reference URL: https://github.com/chubin/wttr.in?tab=readme-ov-file#one-line-output"
  :type 'string
  :group 'ewth)

(defcustom ewth-update-interval 1800
  "Interval in seconds between weather updates."
  :type 'integer
  :group 'ewth)

(defvar ewth--weather ""
  "Current weather string for mode-line display.")

(defvar ewth--timer nil
  "Timer object for periodic weather updates.")

(defun ewth--clean-string (data)
  "Remove non-visible whitespace characters from DATA, preserving only meaningful symbols."
  (replace-regexp-in-string "[ \t\n\r]+" "" (string-trim data)))

(defun ewth--update ()
  "Fetch and update weather information."
  (let ((url ewth-url))
    (request
     url
     :headers '(("User-Agent" . "curl"))
     :parser 'buffer-string
     :success (cl-function
               (lambda (&key data &allow-other-keys)
                 (setq ewth--weather (ewth--clean-string data))
                 (force-mode-line-update)
                 (message "[ewth] Weather updated: %s" ewth--weather)))
     :error (cl-function
             (lambda (&key error-thrown &allow-other-keys)
               (message "[ewth] Weather update error: %S" error-thrown))))))

(defun ewth--start-timer ()
  "Start or restart the weather update timer."
  (when ewth--timer
    (cancel-timer ewth--timer))
  (setq ewth--timer (run-at-time nil ewth-update-interval #'ewth--update)))

(defun ewth--enable ()
  "Enable ewth-mode: insert mode-line string and start timer."
  (ewth--insert-modeline)
  (ewth--start-timer)
  (ewth--update))

(defun ewth--disable ()
  "Disable ewth-mode: remove mode-line string and stop timer."
  (ewth--remove-modeline)
  (when ewth--timer
    (cancel-timer ewth--timer)
    (setq ewth--timer nil))
  (force-mode-line-update))

(defun ewth--insert-modeline ()
  "Insert ewth string into `global-mode-string` if not already present."
  (setq global-mode-string (remove '(:eval (ewth--modeline-string)) global-mode-string))
  (add-to-list 'global-mode-string '(:eval (ewth--modeline-string)) t))

(defun ewth--remove-modeline ()
  "Remove ewth string from `global-mode-string`."
  (setq global-mode-string
        (remove '(:eval (ewth--modeline-string)) global-mode-string)))

(defun ewth--modeline-string ()
  "Return mode-line string for weather info."
  (when (stringp ewth--weather)
    (concat " " ewth--weather)))

;;;###autoload
(define-minor-mode ewth-mode
  "Toggle weather display in the mode-line."
  :global t
  :lighter nil
  (if ewth-mode
      (ewth--enable)
    (ewth--disable)))

(provide 'ewth)

;;; ewth.el ends here
