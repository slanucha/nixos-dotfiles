{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  boot.initrd.luks.devices."luks-39cc0dc5-bfd3-45de-8dbf-910490d73c89".device =
    "/dev/disk/by-uuid/39cc0dc5-bfd3-45de-8dbf-910490d73c89";

  # Networking
  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Europe/Warsaw";

  # Internationalisation properties
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Console keymap
  console.keyMap = "pl2";

  # CUPS
  services.printing.enable = true;

  # Sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # User account
  users.users.slan = {
    isNormalUser = true;
    description = "Szymon Łanucha";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "vboxusers"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtualisation
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts._0xproto
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    neovim
    wget
    killall
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  # Services to enable:

  # OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Emacs daemon.
  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  # Cleanup
  nix.gc = {
    persistent = true;
    automatic = true;
    dates = "20:00";
    options = "--delete-older-than 3d";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
