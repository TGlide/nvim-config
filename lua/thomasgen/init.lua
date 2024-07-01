require("thomasgen.set")
require("thomasgen.remap")
require("thomasgen.lazy_init")

local augroup = vim.api.nvim_create_augroup
local ThomasgenGroup = augroup('Thomasgen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = 'templ',
	}
})

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 100,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = ThomasgenGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
	group = ThomasgenGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		--        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		-- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		-- Rename with command window
		vim.keymap.set("n", "<leader>vrn", function()
			vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
				callback = function()
					local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
					vim.api.nvim_feedkeys(key, "c", false)
					vim.api.nvim_feedkeys("0", "n", false)
					return true
				end,
			})
			vim.lsp.buf.rename()
		end, opts)
		--        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	end
})

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
