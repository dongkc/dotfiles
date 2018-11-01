(set-buffer-file-coding-system 'unix 't)
;;(require 'cnfonts)
;;(cnfonts-enable)
;;(cnfonts-set-spacemacs-fallback-fonts)

(setq debug-on-error t)
(setq linum-format "%d ")
(setq c-basic-offset 2)

;; org mode setup
(load (concat user-emacs-directory "org-mode.el"))
(setq org-mobile-directory "~/git/nutstore/mobile")
;; (setq org-mobile-inbox-for-pull (concat org-directory "/index.org"))
(setq org-mobile-inbox-for-pull "~/git/org/index.org")

;;treate my right option as control in my macbook
(setq mac-right-option-modifier 'control)
(beacon-mode 1)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(pdf-tools-install)