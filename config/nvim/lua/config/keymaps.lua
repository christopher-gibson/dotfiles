local map = vim.keymap.set

-- Buffer navigation
map("n", "<leader>l", "<cmd>bnext<cr>",          { desc = "Next buffer" })
map("n", "<leader>h", "<cmd>bprevious<cr>",       { desc = "Prev buffer" })
map("n", "<leader>q", "<cmd>bp <bar> bd #<cr>",   { desc = "Close buffer" })

-- Add new line below without entering insert mode
map("n", "<cr>", "o<esc>", { desc = "New line below" })

-- Move to beginning/end of line
map({ "n", "v" }, "H", "^", { desc = "Beginning of line" })
map({ "n", "v" }, "L", "$", { desc = "End of line" })

-- Keep selection after indent
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlight
map("n", "<leader>c", "<cmd>nohlsearch<cr>", { desc = "Clear search" })

-- Resize windows with arrow keys
map("n", "<right>", "<C-w>10>", { desc = "Resize window right" })
map("n", "<left>",  "<C-w>10<", { desc = "Resize window left" })
map("n", "<up>",    "<C-w>10+", { desc = "Resize window up" })
map("n", "<down>",  "<C-w>10-", { desc = "Resize window down" })

-- Reload config
map("n", "<leader>R", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })

-- Diagnostic navigation (LSP)
map("n", "<leader>j", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
map("n", "<leader>k", vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
