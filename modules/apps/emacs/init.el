;; Disable ELPA auto setup
(setq package-enable-at-startup nil)

;; use-package provided by Nix
(eval-when-compile (require 'use-package))

;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-display-line-numbers-mode)

(use-package drag-stuff
  :ensure t
  :config
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

;; Theme
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-medium t))

;; company mode
(use-package company
  :hook (after-init . global-company-mode))

;; flycheck
(use-package flycheck
  :hook (after-init . global-flycheck-mode))

;; lsp-mode for Nix, C/C++, Rust
(use-package lsp-mode
  :commands lsp
  :hook ((nix-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         (rust-mode . lsp)
         ;; tree-sitter variants
         (c-ts-mode . lsp)
         (c++-ts-mode . lsp)
         (rust-ts-mode . lsp))
  :init
  (setq lsp-prefer-flymake nil))
  (use-package lsp-ui
  :commands lsp-ui-mode)

;; Nix
(use-package nix-mode :mode "\\.nix\\'")

;; Rust
(use-package rustic
  :mode "\\.rs\\'"
  :config
  (setq rustic-lsp-client 'lsp))

;; C/C++ tree-sitter remapping (Emacs 29+)
(when (boundp 'major-mode-remap-alist)
  (dolist (pair '((c-mode . c-ts-mode)
                  (c++-mode . c++-ts-mode)))
    (add-to-list 'major-mode-remap-alist pair)))

;; Log files
(use-package logview
  :mode "\\.log\\'")
