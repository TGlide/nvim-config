vim.g.mapleader = " "
-- Project view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")

-- Keep cursor in center throughout some operations
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever - paste without putting in register
-- Not needed in latest neovim, just use Shift P
-- vim.keymap.set("x", "<leader>p", "\"_dP")

-- Paste from system clipboard
vim.keymap.set("n", "<leader>pc", "\"+p")

-- next greatest remap ever : asbjornHaland
-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

--- Paste from system clipboard when on insert mode
vim.keymap.set("i", "<C-v>", "<Esc>\"+pa")

-- Delete without going into register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable quitting with Q
vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Formatting
vim.keymap.set("n", "<leader>f", function()
	-- vim.lsp.buf.format()
	vim.cmd("Format")
end)

vim.keymap.set("n", "<leader>l", function()
	local lint = require("lint")
	lint.try_lint()
end)

vim.keymap.set("n", "<leader>esf", function()
	vim.cmd("EslintFixAll")
end)

--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word
vim.keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
--vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<leader>ws", "<C-w>s")
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wq", "<C-w>q")

-- Safe file
vim.keymap.set("n", "<leader>sf", ":w<CR>")
