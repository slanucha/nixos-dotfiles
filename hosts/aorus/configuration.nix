# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.edk2-uefi-shell.enable = true;

  boot.loader.systemd-boot.windows = {
    "win11" = {
      title = "Windows Boot Manager";
      efiDeviceHandle = "HD2b";
      sortKey = "z_windows";
    };
  };
  
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices = {
    "luks-a979547a-263e-4e7a-a59c-088458d63533" = {
      device = "/dev/disk/by-uuid/a979547a-263e-4e7a-a59c-088458d63533";
    };
  };

  environment.etc.crypttab.text = ''secure-store UUID=00026934-712f-4dae-ac09-863df3764e13 /root/lukskey'';

  fileSystems = {
    "/mnt/CodeStore" = {
      device = "/dev/disk/by-uuid/faed103c-f676-4b4a-873d-1f56af5c4800";
      fsType = "btrfs";
      options = [ "defaults" ];
    };

    "/mnt/SharedStore" = {
      device = "/dev/disk/by-uuid/6274B09274B06A85";
      fsType = "ntfs";
      options = [ "uid=1001" "gid=100" "umask=0022" ];
    };

    "/mnt/SecureStore" = {
      device = "/dev/mapper/secure-store";
      fsType = "btrfs";
      options = [ "defaults" ];
    };
  };
  
  # Networking
  networking.hostName = "aorus";
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
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };
  
  # Sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.alsa.enablePersistence = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  
  # Touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # ZSH
  programs.zsh.enable = true;
  
  # User account
  users.users.slan = {
    isNormalUser = true;
    description = "Szymon Łanucha";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "vboxusers"
      "dialout"
      "plugdev"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtualisation
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Flatpak
  services.flatpak.enable = true;

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts._0xproto
      inter
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
    alsa-utils
    nh
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Services to enable:

  # OpenSSH daemon.
  services.openssh.enable = true;

  services.udev.extraRules = ''
    # ST-Link/V1
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3744", MODE="0666", GROUP="plugdev"

    # ST-Link/V2
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev"

    # ST-Link/V2.1
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666", GROUP="plugdev"

    # ST-Link/V3
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374d", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374e", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374f", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3752", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3753", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3754", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3755", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3757", MODE="0666", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3758", MODE="0666", GROUP="plugdev"
  '';

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
  # networking.firewall.enable = fals

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
