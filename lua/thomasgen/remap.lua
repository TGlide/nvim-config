local map = function(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { desc = desc })
end

vim.g.mapleader = " "

-- Project view
map("<leader>pv", ":Oil<CR>", "Open Oil file explorer")

-- Move lines around
map("J", ":m '>+1<CR>gv=gv", "Move line down", "v")
map("<S-Down>", ":m '>+1<CR>gv=gv", "Move line down", "v")
map("K", ":m '<-2<CR>gv=gv", "Move line up", "v")
map("<S-Up>", ":m '<-2<CR>gv=gv", "Move line up", "v")

-- Keep cursor in center throughout operations
map("J", "mzJ`z", "Join lines and keep cursor")
map("<C-d>", "<C-d>zz", "Scroll down and center")
map("<C-u>", "<C-u>zz", "Scroll up and center")
map("n", "nzzzv", "Next search result and center")
map("N", "Nzzzv", "Previous search result and center")

-- Clipboard operations
map("<leader>p", '"_dP', "Paste without updating register", "x")
map("<leader>pc", '"+p', "Paste from system clipboard")
map("<leader>y", '"+y', "Yank to system clipboard")
map("<leader>y", '"+y', "Yank to system clipboard", "v")
map("<leader>Y", '"+Y', "Yank line to system clipboard")
map("<C-v>", '<Esc>"+pa', "Paste from system clipboard", "i")

-- Delete without register
map("<leader>d", '"_d', "Delete without updating register")
map("<leader>d", '"_d', "Delete without updating register", "v")

-- Disable Q
map("Q", "<nop>", "Disable Q")

-- Formatting
map("<leader>f", function()
	vim.cmd("Format")
	vim.notify("Formatted file", vim.log.levels.INFO, { title = "Formatting" })
end, "Format file")
map("<leader>ef", function()
	vim.cmd("FormatEnable")
	vim.notify("Enabled auto-format", vim.log.levels.INFO, { title = "Formatting" })
end, "Enable auto-format")
map("<leader>df", function()
	vim.cmd("FormatDisable")
	vim.notify("Disabled auto-format", vim.log.levels.INFO, { title = "Formatting" })
end, "Disable auto-format")

-- map("<leader>l", function()
-- 	local lint = require("lint")
-- 	lint.try_lint()
-- end, "Lint file")

map("<leader>esf", function()
	vim.cmd("EslintFixAll")
end, "Fix ESLint issues")

-- Window management
map("<leader>ws", "<C-w>s", "Split window horizontally")
map("<leader>wv", "<C-w>v", "Split window vertically")
map("<leader>wh", "<C-w>h", "Move to left window")
map("<leader>w<Left>", "<C-w>h", "Move to left window")
map("<leader>wj", "<C-w>j", "Move to bottom window")
map("<leader>w<Down>", "<C-w>j", "Move to bottom window")
map("<leader>wk", "<C-w>k", "Move to top window")
map("<leader>w<Up>", "<C-w>k", "Move to top window")
map("<leader>wl", "<C-w>l", "Move to right window")
map("<leader>w<Right>", "<C-w>l", "Move to right window")
map("<leader>wq", "<C-w>q", "Close window")
map("<leader>wf", "<C-w>f <C-w>L", "Open file under cursor in new window")

-- Buffer operations
map("<leader>rf", ":e<CR>", "Refresh buffer")
map("<leader>sf", ":w<CR>", "Save file")

-- Terminal
map("<Esc>", [[<C-\><C-n>]], "Exit terminal insert mode", "t")

-- Close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})
