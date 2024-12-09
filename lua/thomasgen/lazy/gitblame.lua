return {
	"f-person/git-blame.nvim",
	enabled = false,
	config = function()
		require("gitblame").setup({ enabled = false })
		vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", {
			desc = "Toggle git blame",
		})
	end,
}
