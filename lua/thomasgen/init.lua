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

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
