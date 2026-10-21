local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-a>", "ggVG")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("x", "p", "P", opts)

vim.keymap.set("n", "<C-c>", ":nohlsearch<CR>")

vim.keymap.set("n", "<C-e>", function()
	vim.diagnostic.jump({
		count = 1,
		on_jump = function()
			vim.diagnostic.open_float()
		end,
	})
end, opts)

vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", "<cmd>Undotree<cr>")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
