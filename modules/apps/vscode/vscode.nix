{ lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
    ];
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
