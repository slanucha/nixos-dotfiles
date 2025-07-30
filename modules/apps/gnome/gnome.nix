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
  ];

  # home.sessionVariables = {
  #   GTK_THEME = "Adwaita:dark";
  # };

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
        "brave-browser.desktop"
        "evolution.desktop"
        "org.gnome.Ptyxis.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      monospace-font-name = "0xProto Nerd Font Mono 12";
    };

    "org/gnome/desktop/default-applications/terminal" = {
      exec = "ptyxis";
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
      scaling-factor = 1.25;
    };
  };
}
