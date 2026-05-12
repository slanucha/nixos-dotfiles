{ lib,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
    ];
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
