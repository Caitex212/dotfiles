return {
	{
		"anurag3301/nvim-platformio.lua",
		dependencies = {
			"akinsho/toggleterm.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"folke/which-key.nvim",
		},
		config = function()
			vim.g.pioConfig = {
				lsp = "clangd",
				clangd_source = "ccls",
				menu_key = "<leader>\\",
			}
			require("platformio").setup(vim.g.pioConfig)
		end,
	},
}
