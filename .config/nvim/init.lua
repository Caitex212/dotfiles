vim.opt.termguicolors = true
require("config.pckr")

require("pckr").add{

  -- Theme
  { "catppuccin/nvim", as = "catppuccin" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

  -- Telescope
  { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } },

  -- Git
  "lewis6991/gitsigns.nvim",
}

vim.cmd.colorscheme("catppuccin")

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "javascript" },
  highlight = { enable = true },
})

require("telescope").setup({})

require("gitsigns").setup()
