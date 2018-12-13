(set-buffer-file-coding-system 'unix 't)
;; (require 'cnfonts)
;; (cnfonts-enable)
;;(cnfonts-set-spacemacs-fallback-fonts)
;; (setq cnfonts-use-face-font-rescale t)

(setq debug-on-error t)
(setq linum-format "%d ")
(setq c-basic-offset 2)

;; org mode setup
(load (concat user-emacs-directory "org-mode.el"))
(setq org-mobile-directory "~/git/dav/test")
;; (setq org-mobile-inbox-for-pull (concat org-directory "/index.org"))
(setq org-mobile-inbox-for-pull "~/git/org/index.org")
(setq org-mobile-use-encryption t)
(setq org-mobile-encryption-password "dongkai")
(setq org-agenda-files (quote ("~/git/org")))

;;treate my right option as control in my macbook
(setq mac-right-option-modifier 'control)
(beacon-mode 1)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(pdf-tools-install)