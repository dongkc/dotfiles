(set-buffer-file-coding-system 'unix 't)
(require 'cnfonts)
(cnfonts-enable)
;;(cnfonts-set-spacemacs-fallback-fonts)
;; (setq cnfonts-use-face-font-rescale t)

(setq debug-on-error t)
(setq linum-format "%d ")
(setq c-basic-offset 2)
(setq-default js2-basic-offset 2)

;; org mode setup
(load (concat user-emacs-directory "org-mode.el"))
(setq org-mobile-directory "~/git/dav/test")
;; (setq org-mobile-inbox-for-pull (concat org-directory "/index.org"))
(setq org-mobile-inbox-for-pull "~/git/org/index.org")
(setq org-mobile-use-encryption t)
(setq org-agenda-files (quote ("~/git/org")))

;;treate my right option as control in my macbook
(setq mac-right-option-modifier 'control)
(beacon-mode 1)
;;(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; (set-language-environment "Chinese-GB18030")

;; for sciter tiscript file extension
(add-to-list 'auto-mode-alist '("\\.tis\\'" . js2-mode))

;; for legacy code written with windows keil, which coding system is default chinese-gb18030
;; (add-hook 'c-mode-hook (lambda ()
;;                          (if (string-match-p "edog" buffer-file-name)
;;                              (revert-buffer-with-coding-system 'chinese-gb18030 t))))

(require 'auth-source-pass)
(auth-source-pass-enable)

(load-theme 'sanityinc-tomorrow-eighties t)