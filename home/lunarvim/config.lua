lvim.plugins = {
  { "miikanissi/modus-themes.nvim", priority = 1000 },

  { "tpope/vim-fugitive" },

  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        -- Whether to set default mappings, such as m[a-z], dm[a-z]
        default_mappings = true,
        -- Which builtin marks to show (e.g. '.', '^')
        builtin_marks = { ".", "<", ">", "^" },
        -- Refresh interval in milliseconds
        refresh_interval = 250,
        -- Sign priorities for the gutter
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        bookmark_1 = {
          sign = "", -- You can use any icon here
          virt_text = "Bookmark",
          annotate = false,
        }
      })
    end
  }
}

lvim.colorscheme = "modus_operandi"

lvim.builtin.lualine.style = "default"

vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.shiftwidth = 2
