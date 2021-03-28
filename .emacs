
;; emacs customization file




;; the add-to list
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "/.emacs.d/elpa/auctex-12.2.4")
(add-to-list 'load-path "/.emacs.d/elpa/emms-5.4.2")
(setq tron-legacy-theme-vivid-cursor t)


(add-to-list 'load-path "/home/phoenix/slime")
(require 'slime-autoloads)
;; add ivy (newer ivy)
(add-to-list 'load-path "/home/phoenix/swiper/")
(require 'ivy)


;; adding emms
(require 'emms-setup)
(emms-all)
(emms-default-players)


;; adding MEPLA
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; display time and date
(setq display-time-day-and-date t)
(display-time)

;; shutting down the dividers between the windows
(scroll-bar-mode -1)
(window-divider-mode 0)

(set-face-foreground 'vertical-border "#000000")
(setq window-divider-default-right-width -1)
(window-divider-mode -1)

;; show buffers as tabs
(frame-tabs-mode t)

;; Setup ivy for autocompletion
(ivy-mode 1)


;;;; Custom shortcut keys setup here

;; Ansi term shortcut , click Ctrl - C a for ansi-term using bash
(global-set-key (kbd "C-c a") '(lambda () (interactive (ansi-term "/bin/bash"))))

;; click Ctrl-C s for spell check
(global-set-key (kbd "C-c s") 'ispell)

;; autoload init file
(global-set-key (kbd "C-c r") (lambda () (interactive) (load "/home/phoenix/.emacs")))


;;;;;;;;;;;;;;;  Individual packages are added after this point


;; auctex

(load "~/.emacs.d/elpa/auctex-12.2.4/auctex.el" nil t t)
(load "~/.emacs.d/elpa/auctex-12.2.4/preview.el" nil t t)
	
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; setting auctex to use atril for it's previewer

(setq TeX-PDF-mode t)

(defun pdfevince ()
   (add-to-list 'TeX-output-view-style
                 '("^pdf$" "." "evince %o %(outpage)")))

(defun pdfatril ()
   (add-to-list 'TeX-output-view-style
                 '("^pdf$" "." "atril %o %(outpage)")))

;(add-hook  'LaTeX-mode-hook  'pdfevince  t) ; AUCTeX LaTeX mode
(add-hook  'LaTeX-mode-hook  'pdfatril  t) ; AUCTeX LaTeX mode

;; SLIME ONLY -- SLY CRRASHES WAY TOO MUCH!!!

;; slime repl is automatic
(slime-setup '(slime-repl))


;; make slime connect if Lisp is open

(defun cliki:start-slime ()
  (unless (slime-connected-p)
    (save-excursion (slime))))

(add-hook 'slime-mode-hook 'cliki:start-slime)

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; get swank to load automatically
;(setq slime-lisp-implementations
;'((sbcl ("sbcl " "--core" "sbcl.core-with-swank")
	     ; :init (lambda (port-file _)
	;	      (format "(swank:start-server %S)\n" port-file)))))


;;(require 'slime-autoloads)
;; Setup IVY

;; Don't keep message buffers around
(setq message-kill-buffers-on-exit t)

;; Ivy runs automatically
(ivy-mode 1)

;; Make Ivy look good
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ") 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Atril")
     (output-html "xdg-open")))
 '(custom-enabled-themes '(tron-legacy))
 '(custom-safe-themes
   '("0b2e94037dbb1ff45cc3cd89a07901eeed93849524b574fa8daa79901b2bfdcf" "748d024b0d016cc0e7a4326577ce12c6bc918b273acecd355548d7477ad2fc5c" "7de0917b4064219c0580397495d47b89a5f93d76724504d0ea8d2eea83542167" "2f26d251e2b0d11e0a5f16b21785ab42192374259cfe41eed67262869c1b387f" "e01d36b3ca7991d21fba7f2708f0bfb587b61654898bf3dd92fb11c9fbf5a649" "11a14e6c993c262f8c55891258c67bde2c2d67a14779ce770caed8d03604c6ff" "6b234feec8db588ad5ec2a9d9d7b935f7a155104b25ccfb94d921c45a2ff7d22" "286b585a893a5acef4588fc5a5771cd4f7ac443dd5ce4bc4f1e5e45b1a0a63c3" "27b97024320d223cbe0eb73104f2be8fcc55bd2c299723fc61d20057f313b51c" default))
 '(fringe-mode 10 nil (fringe))
 '(linum-format " %6d ")
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(package-selected-packages
   '(tron-legacy-theme skewer-mode w32-browser undersea-theme macrostep frame-tabs emms counsel clues-theme chess auctex airline-themes ahungry-theme abyss-theme))
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(red "#ffffff"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
