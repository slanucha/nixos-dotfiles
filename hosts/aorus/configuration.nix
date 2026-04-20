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
  boot.kernelModules = [ "kvm" "kvm-amd" ];
  boot.initrd.systemd.enable = true;
  
  boot.initrd.luks.devices = {
    "luks-a979547a-263e-4e7a-a59c-088458d63533" = {
      device = "/dev/disk/by-uuid/a979547a-263e-4e7a-a59c-088458d63533";
    };
  };

  environment.etc.crypttab.text = ''
    data-dev   UUID=059c4415-f877-4369-a989-9b076e150401 /root/lukskey
    data-space UUID=00026934-712f-4dae-ac09-863df3764e13 /root/lukskey
    data-share /dev/sdb                                  /dev/null tcrypt-veracrypt,tcrypt-keyfile=/root/lukskey
  '';

  fileSystems = {
    "/data/dev" = {
      device = "/dev/mapper/data-dev";
      fsType = "ext4";
      options = [ "defaults" ];
    };

    "/data/space" = {
     device = "/dev/mapper/data-space";
     fsType = "ext4";
     options = [ "defaults" ];
    };

    "/data/share" = {
      device = "/dev/mapper/data-share";
      fsType = "ntfs";
      options = [ "uid=1001" "gid=100" "umask=0022" ];
    };
  };
  
  # Networking
  networking = {
    hostName = "aorus";
    # networkmanager.enable = true;
    interfaces.br0.useDHCP = true;
    interfaces.enp8s0.useDHCP = false;
    bridges.br0.interfaces = [ "enp8s0" ];
  };

  systemd.network.wait-online.anyInterface = true;

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

  # PipeWire setup
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # Keep this ON unless you *really* want pure ALSA apps only
    pulse.enable = true;
    # Optional but recommended
    jack.enable = true;
  };

  # Required for real-time audio
  security.rtkit.enable = true;

  services.pipewire.wireplumber.extraConfig = {
    "disable-sbz-acp" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            { "device.name" = "alsa_card.pci-0000_06_00.0"; }
          ];
          actions = {
            update-props = {
              "api.alsa.use-acp" = false;
            };
          };
        }
      ];
    };
  };

  systemd.services.alsa-restore = {
    wantedBy = [ "multi-user.target" ];
    after = [ "sound.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart =
        "${pkgs.bash}/bin/bash -c 'sleep 1; ${pkgs.alsa-utils}/bin/alsactl restore'";
    };
  };
  
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
      "libvirtd"
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
    libvirtd.enable = true;
    libvirtd.qemu.swtpm.enable = true;
  };
  programs.virt-manager.enable = true;

  # Flatpak
  # services.flatpak.enable = true;

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
    wget
    killall
    alsa-utils
    nh
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Services to enable:

   # SSD Optimization
  services.fstrim.enable = true;
  
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
