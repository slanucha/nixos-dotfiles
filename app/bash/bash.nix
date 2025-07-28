{
  lib,
  pkgs,
  ...
}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
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
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship-gruvbox-rainbow.toml);
  };
}
