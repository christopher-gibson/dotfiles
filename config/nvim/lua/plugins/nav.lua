return {
  -- Seamless navigation between nvim splits and tmux panes
  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>",  desc = "Navigate left" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>",  desc = "Navigate down" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>",    desc = "Navigate up" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Navigate right" },
    },
    opts = {},
  },

  -- File explorer (edit directories like buffers)
  -- Press `-` to open parent dir, `<leader>e` to open current file's dir
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" },
      { "-",         "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      columns = { "icon", "permissions", "size" },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["g?"]  = "actions.show_help",
        ["<CR>"]= "actions.select",
        ["<C-v>"]= "actions.select_vsplit",
        ["<C-x>"]= "actions.select_split",
        ["<C-t>"]= "actions.select_tab",
        ["-"]   = "actions.parent",
        ["_"]   = "actions.open_cwd",
        ["`"]   = "actions.cd",
        ["~"]   = "actions.tcd",
        ["gs"]  = "actions.change_sort",
        ["gx"]  = "actions.open_external",
        ["g."]  = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["<esc>"] = "actions.close",
      },
      use_default_keymaps = false,
    },
  },
}
