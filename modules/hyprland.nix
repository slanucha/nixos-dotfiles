{ config, pkgs, ... }:

{
  # Enable Hyprland desktop
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
