return {
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { noremap = true })
			vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<cr>", { noremap = true })
		end,
	},
	{
		"tpope/vim-fugitive",
	},
}
