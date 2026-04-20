{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
    };

    colorschemes.modus = {
      enable = true;
    };

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      web-devicons.enable = true;
      fugitive.enable = true;
      
      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          clangd.enable = true;
        };
      };

      cmp.enable = true;
      gitsigns.enable = true;
      neo-tree.enable = true;
    };
  };
}
