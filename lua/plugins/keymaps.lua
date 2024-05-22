-- Telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- Nvim Tree
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<cr>")

-- Bufferline
vim.keymap.set("n", "<leader><tab>", ":bn<cr>")
vim.keymap.set("n", "<leader><S-tab>", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bx<cr>")

-- Nvim Comment
vim.keymap.set({ "n", "v" }, "<leader>/", ":CommentToggle<cr>")
