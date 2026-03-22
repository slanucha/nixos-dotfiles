{ config, lib, pkgs, ... }:

{
  programs.wezterm.enable = true;

  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'

    return {
      enable_wayland = true,

      font = wezterm.font("0xProto Nerd Font Mono"),
      font_size = 12.0,

      color_scheme = "Gruvbox dark, medium (base16)",

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

      keys = {
        { key = "-", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
        { key = "_", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
        { key = "=", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
        { key = "+", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
        { key = "0", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
        { key = "-", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
        { key = "_", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
        { key = "=", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
        { key = "+", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
        { key = "0", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
        { key = "+", mods = "CTRL|ALT|SHIFT", action = wezterm.action.IncreaseFontSize },
        { key = "_", mods = "CTRL|ALT|SHIFT", action = wezterm.action.DecreaseFontSize },
        { key = ")", mods = "CTRL|ALT|SHIFT", action = wezterm.action.ResetFontSize },
      },
    }
  '';
}
