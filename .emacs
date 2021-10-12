
;; Trying out the TRON theme
;; per instructions on code.google.com/archive/p/tron-theme-emacs

;(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))


;; Emacs config file

;;

(require 'package)
(setq package-archives
	     '(("melpa"  .   "http://melpa.org/packages/")
	     ("nongnu" . "http://orgmode.org/elpa/")))



;; Setuup Custom Desktop
;; Based on code from https://www.reddit.com/r/emacs/comments/c4e5ey/custom_dashboard_emacs/
(require 'use-package)
(use-package page-break-lines)
 (require 'font-lock)
(require 'font-lock+)
(use-package all-the-icons)

;; dired


(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Or if you use use-package
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-set-heading-icons t)
(dashboard-setup-startup-hook)

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))



(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
(setq dashboard-startup-banner "C:/users/micha/images/ICU.png")
;(setq dashboard-startup-banner 'official)

;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.png" which displays whatever image you would prefer


;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts t)

(defun dashboard-insert-agenda (&rest _)
  "Insert a copy of org-agenda buffer."
  (insert (save-window-excursion
            (org-agenda-list)
            (prog1 (buffer-string)
              (kill-buffer)))))

;(add-to-list 'dashboard-items '(agenda) t)

;; reworking the dashboard items - will comment them out before running

(setq dashboard-items '((agenda . 5)
		        ;(bookmarks . 4)	
		          (projects . 4)))


;(setq dashboard-items '((recents  . 5)
;                        (bookmarks . 4)
;                        (projects . 5)
;                        (agenda . 5)
	               ;(registers . 2)
;                        


(defun dashboard-insert-custom (list-size))
;;  (insert "The End"))
(add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
(add-to-list 'dashboard-items '(custom) t)

(setq dashboard-set-navigator t)


;; Adding in fortune and tip of  the day from https://github.com/rgd/emacs.d/blob/master/emacs.dashboard.el

;; I have to comment all of this out - Windows 10 doesn't have fortune !!!!


;	(defun dashboard-insert-fortune (list-size)
;		  (insert
;		   (format 
;			"** FORTUNE **\n(use C-c f to edit fortunes)\n\n %s\n" 
;			(replace-regexp-in-string 
;			 "\n$" ""    ; remove trailing linebreak
;			 (shell-command-to-string (concat "powershell -file " fortune-script-path)))
;			))
;		  )
;		(add-to-list 'dashboard-item-generators  '(fortune . dashboard-insert-fortune))
;		(add-to-list 'dashboard-items '(fortune . 1))

;; Commented out - Windows 10 doesn't have tip of the day either

		;; TIP OF THE DAY WIDGET
;		(defun dashboard-insert-totd (list-size)
;		  (totd))
;		(add-to-list 'dashboard-item-generators  '(totd . dashboard-insert-totd))
;		(add-to-list 'dashboard-items '(totd . 1) t)




;;(provide 'init-startup)



					;(add-to-list  'pdflatex
;(add-to-list 'load-path "C:/texlive/texmf/tex/latex/beamer/2020/bin/win32/")
;(require 'pdflatex)

;; Add auctex

(package-initialize)
;(unless (package-installed-p   'use-package)
 ; (package-refresh-contents)
  ;(package-install   'use-package))


;; add eaf
(add-to-list 'load-path "C:/Users/micha/AppData/Roaming/.emacs.d/site-lisp/emacs-application-framework/")
(require 'eaf)

; quick-keys for eaf


(global-set-key (kbd "C-1") 'eaf-open-browser)

;Frame tabs up first

(frame-tabs-mode t)


;; ivy mode as well

(ivy-mode t)


;; set up org mode scheduler / to do list itself
;; courtesy of www.pragmaticemacs.com

;; Elfeed
(setq elfeed-feeds '("planetemacslife.com/atom.xml"
		     "planet.list.org/rss20.xml"
		     "planet.sbcl.org/rss20.xml"
		     "latesthackingnews.com/feed"))
      



(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/todo.org" "Tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")))



;; set key for agenda
(global-set-key (kbd "C-c a") 'org-agenda)
;file  to save todo items
(setq org-agenda-files (quote ("/Users/micha/todo.org")))

;;set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?A)

;;set colours for priorities
(setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

;;open agenda in current window
(setq org-agenda-window-setup (quote current-window))

;;capture todo items using C-c c t
(define-key global-map (kbd "C-c c") 'org-capture)
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "/Users/micha/todo.org" "Tasks")
         "* TODO [#A] %?")))


;; set up Org mode scheduler / to-do list options
;; courtesy of www.pragmaticemacs.com

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode agenda options                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;open agenda in current window
(setq org-agenda-window-setup (quote current-window))
;;warn me of any deadlines in next 7 days
(setq org-deadline-warning-days 7)
;;show me tasks scheduled or due in next fortnight
(setq org-agenda-span (quote fortnight))
;;don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
;;don't give awarning colour to tasks with impending deadlines
;;if they are scheduled to be done
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
;;don't show tasks that are scheduled or have deadlines in the
;;normal todo list
(setq org-agenda-todo-ignore-deadlines (quote all))
(setq org-agenda-todo-ignore-scheduled (quote all))
;;sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
  (quote
   ((agenda deadline-up priority-down)
    (todo priority-down category-keep)
    (tags priority-down category-keep)
    (search category-keep))))


;; Projects

(setq projectile-project-search-path '("C:/Users/micha/Documents/Org_Mode/projects/"))



;; SLIME

(load (expand-file-name "C:/Users/micha/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
(add-to-list  'load-path "C:/slime-master/slime-master")
(add-to-list 'load-path "C:/slime-master/slime-master/contrib")
(require  'slime)
(require 'slime-autoloads)
(slime-setup)

;; Weather

(require 'sunshine)
(setq sunshine-location "33912,USA")
(setq sunshine-api "2e94acbd3ab5c308d2448cc9c66115cd")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(custom-enabled-themes '(gruvbox))
 '(custom-safe-themes
   '("d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "3a78cae35163bb71df460ebcfdebf811fd7bc74eaa15428c7e0bccfd4f858d30" "57e3f215bef8784157991c4957965aa31bac935aca011b29d7d8e113a652b693" "1fbd63256477789327fe429bd318fb90a8a42e5f2756dd1a94805fc810ae1b62" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "c7eb06356fd16a1f552cfc40d900fe7326ae17ae7578f0ef5ba1edd4fdd09e58" "bf10bd6d21928bf87bc3032b498c62cb9d48c54c06d217c8b00bef8090e539f7" "3d4df186126c347e002c8366d32016948068d2e9198c496093a96775cc3b3eaa" "0bc405f268e19f4d724b8c3e0e8941b5b792939d730c91fc764e5fe2e10d201d" "1e20d081d83576513906fe1ae1c562607865ed4e33b1ae619ed1257f733b33fe" "1e460024a54a8839f2bc7ece50dc287b541ccdfac03d322fb58bac99c97c204d" "410e6276e49e14f4b364c6fa22c79c1f3c3a91923d04d42826568441ed83abea" "d0aa1464d7e55d18ca1e0381627fac40229b9a24bca2a3c1db8446482ce8185e" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "9e188afd497ef53ba592485a1781503de0ac62b6a57badf3b57530f0df5c2a9e" "f51f988edbf23c794edac4d0937579f33f140e1e4e2c0e3151caaea9e2e3e0e7" "fb486143c9307b6a8b18e0bc30b1099c71c616281100d76b3405b13952949f22" "27b97024320d223cbe0eb73104f2be8fcc55bd2c299723fc61d20057f313b51c" default))
 '(default
    ((t
      (:background "#0033cc" :foreground "#0099cc" :slant normal :weight normal :height 130 :width normal :foundry "xos4" :family "OCR A"))))
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(elfeed-feeds
   '("planet.gnu.org/rss20.xml" "\"latesthackingnews.com/feed\"" "latesthackingnews.com/feed") t)
 '(emms-mode-line-icon-color "#1fb3b3")
 '(fancy-splash-image
   "C:\\Users\\Micha\\AppData\\Roaming\\.emacs.d\\themes\\emac-tron-logo-600.png")
 '(fci-rule-color "#14151E")
 '(fringe-mode 6 nil (fringe))
 '(gnus-logo-colors '("#2fdbde" "#c0c0c0") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };") t)
 '(linum-format 'dynamic)
 '(org-agenda-files '("/Users/micha/Documents/Work_Related/agenda.org"))
 '(package-selected-packages
   '(ranger all-the-icons-dired gruvbox-theme dream-theme cherry-blossom-theme challenger-deep-theme boron-theme bliss-theme arjen-grey-theme arc-dark-theme ample-zen-theme ample-theme alect-themes afternoon-theme abyss-theme nord-theme npm markdown-mode sunshine use-package tron-legacy-theme s projectile pdf-tools page-break-lines org-plus-contrib org-bullets org multishell ivy-explorer frame-tabs epc elfeed dashboard auctex all-the-icons ahungry-theme))
 '(red "#ffffff")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(all-the-icons-dired-dir-face ((t (:foreground "white")))))
