{ config, pkgs, ... }:

{
  # Enable KDE Plasma desktop
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "breeze";
    wayland.enable = true;
    enableHidpi = true;
  };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Enable hardware acceleration
  hardware.graphics.enable = true;

  # Networking (Plasma integrates with NetworkManager)
  networking.networkmanager.enable = true;

  # Optional: KDE-specific utilities or apps
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kate
    kdePackages.okular
    kdePackages.breeze-gtk
    kdePackages.plasma-browser-integration
    kdePackages.kaccounts-providers
    kdePackages.kaccounts-integration
    kdePackages.kwallet
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
    kdePackages.signond
    kdePackages.signon-kwallet-extension
    kdePackages.sddm-kcm
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    kdiff3
  ];

  programs.chromium = {
    enable = true;
    enablePlasmaBrowserIntegration = true;
  };

  # Remove unwanted default KDE apps (optional)
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konqueror
  ];
}
