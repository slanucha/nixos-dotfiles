{ config, lib, pkgs, ... }:

{
  programs.wezterm.enable = true;

  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'

    return {
      enable_wayland = true,

      font = wezterm.font("0xProto Nerd Font Mono"),
      font_size = 12.0,

      color_scheme = "Gruvbox Dark",

      enable_tab_bar = true,
      use_fancy_tab_bar = false,

      window_background_opacity = 0.95,

      scrollback_lines = 10000,

      window_padding = {
        left = 6,
        right = 6,
        top = 6,
        bottom = 6,
      },
    }
  '';
}
