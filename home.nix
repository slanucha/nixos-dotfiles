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
  home.stateVersion = "26.05";

  # Packages
  home.packages = with pkgs; [
    # editors
    neovide
    libreoffice
    hunspell
    hunspellDicts.pl_PL
    vista-fonts
    
    # graphics
    gimp3-with-plugins
    inkscape-with-extensions
    rawtherapee

    # browsers
    firefox
    google-chrome

    # mail
    thunderbird

    # proton
    proton-vpn
    pass
    
    # multimedia
    ani-cli
    libdvdread
    vlc
    moc
    easytag
    makemkv
    
    # utils
    zip
    xz
    unzip
    p7zip
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
    nixfmt
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
    cdrtools
    
    # virtualisation
    distrobox
    man-pages
    bear
    
    # development
    clang-tools
    rust-analyzer
    ollama-rocm
    claude-code
  ];

  # git configuration
  programs.git = {
    enable = true;
    settings = {
      user.name = "Szymon Lanucha";
      user.email = "slann@protonmail.com";
      core.editor = "emacs -nw";
    };
  };

  # home.file.".config/lvim/config.lua" = {
  #   source = ./home/lunarvim/config.lua;
  #   force = true;
  # };

  # Doom Emacs
  services.emacs.enable = true;
  programs.doom-emacs = {
    enable = true;
    doomDir = ./home/emacs/doom-config;
    doomLocalDir = "${config.xdg.dataHome}/nix-doom"; # required
    provideEmacs = true;
  };

  programs.vivaldi = {
    enable = true;
  };

 }
