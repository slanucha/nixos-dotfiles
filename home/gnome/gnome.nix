{
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # GNOME Shell Extensions
    gnome-shell-extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.eye-on-cursor
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.logo-widget
    gnomeExtensions.caffeine

    amberol
    gapless
    transmission_4-gtk
    gparted
    gedit
  ];

  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      # Font Configuration
      font-size = 12;
      font-family = "0xProto Nerd Font Mono";

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

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "caffeine@patapon.info"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "eye-on-cursor@djinnalexio.github.io"
        "blur-my-shell@aunetx"
      ];

      disabled-extensions = [ ];

      favorite-apps = [
        "org.gnome.Nautilus.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      monospace-font-name = "0xProto Nerd Font Mono 12";
    };

    "org/gnome/desktop/default-applications/terminal" = {
      exec = "ghostty";
      exec-arg = "";
    };

    "org/gnome/settings-daemon/plugins/xsettings" = {
      antialiasing = "rgba";
      hinting = "slight";
    };

    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };

    "org/gnome/desktop/interface" = {
      scaling-factor = 1;
      text-scaling-factor = 1;
    };
  };
}
