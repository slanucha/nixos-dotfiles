{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

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

    extraConfigLua = ''
      if vim.g.neovide then
        vim.o.background = "light"
      end
    '';

    plugins = {
      lualine.enable = true;
      bufferline.enable = true;
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

    keymaps = [
      {
        mode = "i";
        key = "<C-h>";
        action = "<Left>";
      }
      {
        mode = "i";
        key = "<C-l>";
        action = "<Right>";
      }
      {
        mode = "i";
        key = "<C-j>";
        action = "<Down>";
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<Up>";
      }
    ];
  };
}
