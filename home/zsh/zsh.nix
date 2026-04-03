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

    initContent = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      export NIXPKGS_ALLOW_UNFREE=1
      if ! pgrep -u "$USER" emacs >/dev/null; then
        emacs --daemon
      fi
    '';

    shellAliases = {
      update = "nix flake update --flake ~/.nixos";
      rebuild = "nh os switch ~/.nixos";
      ls = "eza";
      v = "nvim";
      sv = "sudo nvim";
      em = "emacsclient -nw";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./nerd-font-symbols.toml);
  };

  # Easy shell environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
