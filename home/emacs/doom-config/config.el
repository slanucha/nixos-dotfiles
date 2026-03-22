;; UI cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Line numbers
(setq display-line-numbers-type t)

;; Theme
(setq doom-theme 'gruvbox-dark-medium)

;; treemacs
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c C-t") 'treemacs-select-window)

;; drag-stuff
(use-package! drag-stuff
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

;; Backups
(setq backup-directory-alist
      `(("." . ,(concat doom-user-dir "backup/"))))

;; LSP
(use-package! lsp-mode
  :commands lsp
  :init
  (setq lsp-clients-clangd-executable "/etc/profiles/per-user/slan/bin/clangd")
  (setq lsp-clients-clangd-args
        '("--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=never")))

(after! lsp-mode
  (setq lsp-prefer-flymake nil))

(use-package! lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode))

;; Rustic config
(after! rustic
  (setq rustic-lsp-client 'lsp))

;; Log files
(use-package! logview
  :mode "\\.log\\'")

;; Make ESC quit (classic Emacs style)
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)

;; Show function name in modeline
(which-function-mode 1)

;; Highlight TODO / FIXME
(global-hl-todo-mode 1)

;; Better compilation window behavior
(setq compilation-scroll-output t)

;; Clang
(after! cc-mode
  ;; 4-space indentation
  (setq c-default-style "linux"
        c-basic-offset 4)

  ;; Use clang-format automatically
  (setq clang-format-style "file"))

