return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
    },
    keys = {
      { "<leader>f",  "<cmd>Telescope find_files<cr>",              desc = "Find files" },
      { "<leader>F",  "<cmd>Telescope live_grep<cr>",               desc = "Live grep" },
      { "<leader>b",  "<cmd>Telescope buffers<cr>",                 desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                desc = "Recent files" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",    desc = "Document symbols" },
      { "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>",   desc = "Workspace symbols" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",             desc = "Diagnostics" },
      { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",             desc = "Git commits" },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      -- Load fzf extension if available
      pcall(telescope.load_extension, "fzf")
    end,
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_cutoff = 0.2,
            preview_height = 0.4,
          },
          height = 0.9,
          width  = 0.9,
        },
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
          i = {
            ["<esc>"] = function(...) return require("telescope.actions").close(...) end,
            ["<C-j>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
            ["<C-k>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
            ["<C-p>"] = function(...) return require("telescope.actions.layout").toggle_preview(...) end,
            ["<C-d>"] = function(...) return require("telescope.actions").delete_buffer(...) end,
          },
          n = {
            ["j"]    = function(...) return require("telescope.actions").move_selection_next(...) end,
            ["k"]    = function(...) return require("telescope.actions").move_selection_previous(...) end,
            ["gg"]   = function(...) return require("telescope.actions").move_to_top(...) end,
            ["G"]    = function(...) return require("telescope.actions").move_to_bottom(...) end,
            ["<C-p>"]= function(...) return require("telescope.actions.layout").toggle_preview(...) end,
          },
        },
      },
    },
  },
}
