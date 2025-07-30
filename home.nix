{
  lib,
  pkgs,
  ...
}:

{
  home.username = "slan";
  home.homeDirectory = "/home/slan";
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    # editors
    vscode-with-extensions
    # browsers
    brave
    # mail
    evolution
    # proton
    protonvpn-gui
    protonmail-bridge
    pass
    # multimedia
    vlc
    rhythmbox
    # archives
    zip
    xz
    unzip
    p7zip
    # utils
    ptyxis
    fastfetch
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    # nix related
    nixd
    nix-output-monitor
    nixfmt-rfc-style
    nix-direnv
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    # virtualisation
    distrobox
  ];

  # git configuration
  programs.git = {
    enable = true;
    userName = "Szymon Lanucha";
    userEmail = "slann@protonmail.com";
  };

  # GPG
  programs.gpg = {
    enable = true;
    # Use pinentry-tty or pinentry-curses for TTY environments
    # Or pinentry-gtk2 for GUI
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-tty;  # or "curses" or "gtk2" if using a graphical session
    defaultCacheTtl = 1800;
    enableSshSupport = true; # optional
  };

  programs.password-store.enable = true;

  # Protonmail service
  systemd.user.services.protonmail-bridge = {
    Unit = {
      Description = "ProtonMail Bridge";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
