{ config, pkgs, ... }:

{
  # Enable GNOME desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

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
  ];

  environment.gnome.excludePackages = with pkgs; [
    geary
    gnome-terminal
  ];
}
