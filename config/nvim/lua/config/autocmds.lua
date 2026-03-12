local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Disable auto-comment on newlines
autocmd("FileType", {
  group = augroup("no_auto_comment", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Cursorline only in active window
local cursorline_group = augroup("cursorline", { clear = true })
autocmd("WinLeave",    { group = cursorline_group, callback = function() vim.opt_local.cursorline = false end })
autocmd("WinEnter",    { group = cursorline_group, callback = function() vim.opt_local.cursorline = true end })
autocmd("InsertEnter", { group = cursorline_group, callback = function() vim.opt_local.cursorline = false end })
autocmd("InsertLeave", { group = cursorline_group, callback = function() vim.opt_local.cursorline = true end })

-- Highlight text on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Resize splits when window is resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
