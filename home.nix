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
    gapless
    plattenalbum
    
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
    ghostty
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
      core.editor = "nvim";
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
    # commandLineArgs = [
    #   "--password-store=kwallet6"
    # ];
  };

  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      # Font Configuration
      font-size = 12;

      # Window Configuration
      window-decoration = false;
      window-padding-x = 12;
      window-padding-y = 12;
      background-opacity = 0.9;
      background-blur-radius = 32;

      # Cursor Configuration
      cursor-style = "block";
      cursor-style-blink = true;

      # Scrollback
      scrollback-limit = 3023;

      # Terminal features
      mouse-hide-while-typing = true;
      copy-on-select = false;
      confirm-close-surface = false;

      # Disable in-app Ghostty toast notifications
      app-notifications = false;

      # Key bindings
      keybind = [
        "ctrl+shift+n=new_window"
        "ctrl+t=new_tab"
        "ctrl+plus=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
        "shift+enter=text:\\n"
      ];

      # Material 3 UI elements
      unfocused-split-opacity = 0.7;
      unfocused-split-fill = "#44464f";

      # Tab configuration
      gtk-titlebar = false;

      # Shell integration
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title,no-cursor";

      # GTK / System integration
      gtk-single-instance = true;

      # Theme
      theme = "Modus Operandi";
    };
  };
}
