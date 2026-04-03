{ config, lib, pkgs, ... }:

{
  programs.wezterm.enable = true;

  xdg.configFile."wezterm/wezterm.lua".text = ''
    local wezterm = require 'wezterm'

    return {
      enable_wayland = true,

      font = wezterm.font("0xProto Nerd Font Mono"),
      font_size = 13.0,

      color_scheme = "Github Light (Gogh)",

      enable_tab_bar = true,
      use_fancy_tab_bar = false,
      tab_bar_at_bottom = false,

      colors = {
        background = "#ffffff",
        tab_bar = {
          background = "#dee0e2",
          active_tab = {
            bg_color = "#ffffff",
            fg_color = "#24292f",
            intensity = "Bold",
          },

          inactive_tab = {
            bg_color = "#f6f8fa",
            fg_color = "#57606a",
          },

          inactive_tab_hover = {
            bg_color = "#eaeef2",
            fg_color = "#24292f",
            italic = false,
          },

          new_tab = {
            bg_color = "#f6f8fa",
            fg_color = "#57606a",
          },

          new_tab_hover = {
            bg_color = "#eaeef2",
            fg_color = "#24292f",
            italic = false,
          },
        },
      },

      window_background_opacity = 1.0,

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
