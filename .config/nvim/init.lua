local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Theme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- LSP Management
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      vim.lsp.config("pyright", {})

      vim.lsp.config("clangd", {
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
      })

      vim.lsp.enable("pyright")
      vim.lsp.enable("clangd")
    end
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter'.setup {
        ensure_installed = {'rust', 'javascript', 'python', 'java', 'cpp'},
        highlight = { enable = true },
      }
    end
  },

  -- Windsurf / Codeium
  {
    "Exafunction/windsurf.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
    config = function()
      require("codeium").setup({
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<Tab>",
            next = "<M-j>",
            prev = "<m-h>",
          }
        }
      })
    end
  },

  -- PlatformIO
  {
    'anurag3301/nvim-platformio.lua',
    dependencies = {
      'akinsho/toggleterm.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'folke/which-key.nvim',
    },
    config = function()
      vim.g.pioConfig = {
        lsp = 'clangd',
        clangd_source = 'ccls',
        menu_key = '<leader>\\',
      }
      require('platformio').setup(vim.g.pioConfig)
    end
  },

  -- UI Elements
  { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons', config = true },
  { 'nvim-lualine/lualine.nvim', opts = {} },
  { 'onsails/lspkind.nvim' },
  { 'lewis6991/gitsigns.nvim', opts = {} },
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")
vim.opt.clipboard = "unnamedplus"

local home = vim.fn.expand("~")  -- gets the user's home directory
local xtensa_path = home .. "/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-*"
vim.lsp.config("clangd", {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/clangd",
    "--query-driver=" .. xtensa_path, -- This is not a good solution and does not even solve the issue completely
  },
})

local cmp = require('cmp')
cmp.setup({
  sources = {{ name = "codeium" }},
  formatting = {
    format = require('lspkind').cmp_format({
      mode = "symbol",
      symbol_map = { Codeium = "" }
    })
  }
})