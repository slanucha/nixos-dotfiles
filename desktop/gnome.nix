{ config, pkgs, ... }:

{
  # Enable GNOME desktop
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-developer-tools.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Enable dconf
  programs.dconf.enable = true;

  # Enable networking in GNOME
  networking.networkmanager.enable = true;

  # GNOME applications and tweaks
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
    gnome-keyring
    adw-gtk3
    # Themes the app titlebars
    qadwaitadecorations
    qadwaitadecorations-qt6
    # Themes the apps
    qgnomeplatform
    qgnomeplatform-qt6
  ];

  environment.gnome.excludePackages = with pkgs; [
    geary
    gnome-terminal
  ];

  home-manager.users.slan.imports = [
    ../home/gnome/gnome.nix
  ];
}
