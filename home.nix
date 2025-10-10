{
  lib,
  pkgs,
  config,
  ...
}:

{
  home.username = "slan";
  home.homeDirectory = "/home/slan";
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    # editors
    # libreoffice
    libreoffice
    hunspell
    hunspellDicts.pl_PL
    vista-fonts
    # graphics
    gimp3-with-plugins
    inkscape-with-extensions
    rawtherapee
    # browsers
    brave
    # mail
    evolution
    # proton
    protonvpn-gui
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
    moserial
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
    # remote
    realvnc-vnc-viewer
    # Nix Search TV
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];

  # git configuration
  programs.git = {
    enable = true;
    userName = "Szymon Lanucha";
    userEmail = "slann@protonmail.com";
  };
}
