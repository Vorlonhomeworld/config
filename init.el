;; Cosmetic stuff -  transparency


;; set the wallpaper
(defun efs/set-wallpaper ()
  (interactive)
  (start-process-shell-command
   "feh" nil "feh --bg-scale /home/phoenix/Pictures/Ghost_live.jpeg"))

;; try to get EXWM to run something in the background
(defun efs/run-in-background (command)
  (let ((command-parts (split-string command "[ ]+")))
    (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

(defun efs/exwm-init-hook()
  ;; Make workspace 1 be the one we land at start up
  (exwm-workspace-switch-create 1)

;; now call it for nm-applet
(efs/run-in-background "nm-applet"))


;; set time mode correctly
(setq display-time-and-day t)
(display-time-mode 1)

;; parameter WAS 90 . 90
(set-frame-parameter (selected-frame) 'alpha '(85 .85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))


(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(use-package exwm
  :config
  ;; Set the default number of workspaces
  (setq exwm-workspace-number 5)

;; When the window "class" updates, use it to set the buffer name
(add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

  ;; When window "class" updates, use it to set the buffer name
  (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

  ;; Rebind CapsLock to Ctrl
  ;;start-process-shell-command "xmodmap" nil "xmodmap ~/.emacs.d/exwm/Xmodmap")

  ;; Set the screen resolution (update this to be the correct resolution for your screen!)
 ;; (require 'exwm-randr)
 ;; (exwm-randr-enable)
  ;; (start-process-shell-command "xrandr" nil "xrandr --output Virtual-1 --primary --mode 2048x1152 --pos 0x0 --rotate normal")

;; Run the wallpaper command  
  (efs/set-wallpaper)

;; run the wifi command  
;;  (run-wifi)

;; run emacs as a deamon, use "emacslient <filename>" to seamlessly edit files from the terminal directly in the exwm instance  
(server-start)
  
  ;; Load the system tray before exwm-init
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)

  ;; These keys should always pass through to Emacs
  (setq exwm-input-prefix-keys
    '(?\C-x
      ?\C-u
      ?\C-h
      ?\M-x
      ?\M-`
      ?\M-&
      ?\M-:
      ?\C-\M-j  ;; Buffer list
      ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([s-left] . windmove-left)
          ([s-right] . windmove-right)
          ([s-up] . windmove-up)
	  ([s-down] . windmove-down)

	  ;; Split  horizontally or vertically  - added this on my own
	  ([s-H] . split-window-horizontally)
	  ([s-V] . split-window-vertically)

         	  
	  
          ;; Launch applications via shell command
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
		       (start-process-shell-command command nil command)))


	  

	  ;; Switch workspace
          ([?\s-w] . exwm-workspace-switch)
          ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))

          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))

  
  (exwm-enable))
