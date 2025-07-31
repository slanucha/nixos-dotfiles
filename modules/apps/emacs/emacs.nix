{ config, pkgs, ... }:

let
  myEmacs = pkgs.emacsWithPackagesFromUsePackage {
    config = ./init.el;
    defaultInitFile = true;
    package = pkgs.emacs-unstable-pgtk;

    extraEmacsPackages = epkgs: with epkgs; [
      use-package
      gruvbox-theme
      drag-stuff
      magit
      flycheck
      rustic
      lsp-ui
      lsp-mode
      rust-mode
      nix-mode
      company
      tree-sitter
      treesit-grammars.with-all-grammars
    ];
  };
in
{
  programs.emacs = {
    enable = true;
    package = myEmacs;
  };
  services.emacs.enable = true;
}
