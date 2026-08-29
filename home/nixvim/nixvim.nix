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

          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            settings = {
              cargo = {
                buildScripts.enable = true;
              };
            };
          };

        };
      };

      which-key = {
        enable = true;

        settings = {
          delay = 300;
          preset = "modern";
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
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>write<CR>";
        options.desc = "Write file";
      }

      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>quit<CR>";
        options.desc = "Quit";
      }

      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
        options.desc = "Next buffer";
      }

      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
        options.desc = "Previous buffer";
      }

      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete buffer";
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Buffers";
      }
    ];
  };
}
