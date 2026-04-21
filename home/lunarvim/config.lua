-- [[ Core Settings ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- [[ Plugins ]]
lvim.plugins = {
  { "miikanissi/modus-themes.nvim" },
  -- Fugitive is not built into lvim, so we add it manually
  { "tpope/vim-fugitive" },
}

-- [[ Visuals ]]
lvim.colorscheme = "modus_vivendi"
