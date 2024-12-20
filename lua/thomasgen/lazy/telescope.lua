return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.6",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({
			pickers = {
				find_files = { hidden = true },
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>t", ":Telescope<CR>", {})
		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find [F]iles" })
		vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Find [G]it Files" })
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)

		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)

		-- Project search
		vim.keymap.set("n", "<leader>ps", function()
			-- builtin.live_grep()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "[P]roject [S]earch" })

		-- Project search (live grep)
		vim.keymap.set("n", "<leader>plg", function()
			builtin.live_grep()
		end, { desc = "[P]roject [L]ive [G]rep" })

		-- Project search with regex
		vim.keymap.set("n", "<leader>pR", function()
			builtin.grep_string({ search = vim.fn.input("Grep > "), use_regex = true })
		end, { desc = "Project [R]egex Search" })

		-- Local search
		vim.keymap.set("n", "<leader>ls", function()
			builtin.grep_string({ search = vim.fn.input("Grep > "), search_dirs = { vim.fn.expand("%:p") } })
		end, { desc = "[L]ocal [S]earch" })

		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		-- Resume
		vim.keymap.set("n", "<leader>pr", builtin.resume, {})

		vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "[C]ommand [H]istory" })
		vim.keymap.set("n", "<leader>cc", builtin.commands, { desc = "[C]ommands" })
	end,
}
