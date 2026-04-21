{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  home.username = "slan";
  home.homeDirectory = "/home/slan";
  home.stateVersion = "25.11";

  # Packages
  home.packages = with pkgs; [
    # editors
    lunarvim
    libreoffice-qt
    hunspell
    hunspellDicts.pl_PL
    vista-fonts
    # graphics
    krita
    gimp3-with-plugins
    inkscape-with-extensions
    rawtherapee
    # browsers
    firefox
    google-chrome
    thunderbird
    # mail
    evolution
    # proton
    protonvpn-gui
    pass
    # multimedia
    ani-cli
    libdvdread
    vlc
    amarok
    fooyin
    moc
    # (fooyin.overrideAttrs (old: {
    #   patches = (old.patches or []) ++ [
    #     ./home/fooyin/qt610-align.patch
    #   ];
    # }))
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
    devenv
    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    unrar
    # nix related
    nixd
    nix-output-monitor
    nixfmt-rfc-style
    nix-direnv
    nix-index
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
    minicom
    rpi-imager
    veracrypt
    # virtualisation
    distrobox
    man-pages
    # remote
    realvnc-vnc-viewer
    # Nix Search TV
    # (pkgs.writeShellApplication {
    #   name = "ns";
    #   runtimeInputs = with pkgs; [
    #     fzf
    #     nix-search-tv
    #   ];
    #   text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    # })
    bear
    clang-tools
  ];

  # git configuration
  programs.git = {
    enable = true;
    settings = {
      user.name = "Szymon Lanucha";
      user.email = "slann@protonmail.com";
      core.editor = "emacsclient -nw";
    };
  };

  # Doom Emacs
  services.emacs.enable = true;
  programs.doom-emacs = {
    enable = true;
    doomDir = ./home/emacs/doom-config;
    doomLocalDir = "${config.xdg.dataHome}/nix-doom"; # required
    provideEmacs = true;
  };
}
