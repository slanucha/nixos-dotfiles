{
  lib,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    shellAliases = {
      update = "nix flake update --flake ~/.dotfiles";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      ls = "eza";
      v = "nvim";
      sv = "sudo nvim";
      em = "emacsclient -nw";
      sem = "sudo emacsclient -nw";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship-gruvbox-rainbow.toml);
  };

  # Easy shell environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
