-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>h", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>BufferLineCycleNext<cr>")
vim.keymap.set({ 'n', 'v', 's', 'o' }, "H", "^")
vim.keymap.set({ 'n', 'v', 's', 'o' }, "L", "$")
