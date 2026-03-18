--- Gitignored + dotfiles (.cursor, etc.). Toggle with <M-i> while picker is open.
local ignore_state = {
  find = false,
  grep = false,
}

local function grep_deep_args()
  return ignore_state.grep and { "--no-ignore", "--hidden" } or {}
end

local function attach_find_toggle(prompt_bufnr, map)
  map({ "i", "n" }, "<M-i>", function()
    ignore_state.find = not ignore_state.find
    require("telescope.actions").close(prompt_bufnr)
    vim.schedule(function()
      require("telescope.builtin").find_files({
        no_ignore = ignore_state.find,
        hidden = ignore_state.find,
        attach_mappings = attach_find_toggle,
      })
    end)
  end)
  return true
end

local function open_find_files(opts)
  opts = opts or {}
  if opts.reset then
    ignore_state.find = false
  end
  if opts.with_ignored then
    ignore_state.find = true
  end
  require("telescope.builtin").find_files({
    no_ignore = ignore_state.find,
    hidden = ignore_state.find,
    attach_mappings = attach_find_toggle,
  })
end

local function attach_grep_toggle(prompt_bufnr, map)
  map({ "i", "n" }, "<M-i>", function()
    ignore_state.grep = not ignore_state.grep
    require("telescope.actions").close(prompt_bufnr)
    vim.schedule(function()
      require("telescope.builtin").live_grep({
        additional_args = grep_deep_args(),
        attach_mappings = attach_grep_toggle,
      })
    end)
  end)
  return true
end

local function open_live_grep(opts)
  opts = opts or {}
  if opts.reset then
    ignore_state.grep = false
  end
  if opts.with_ignored then
    ignore_state.grep = true
  end
  require("telescope.builtin").live_grep({
    additional_args = grep_deep_args(),
    attach_mappings = attach_grep_toggle,
  })
end

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
      {
        "<leader>f",
        function()
          open_find_files({ reset = true })
        end,
        desc = "Find files",
      },
      {
        "<leader>fi",
        function()
          open_find_files({ with_ignored = true })
        end,
        desc = "Find files (+ gitignored & dotfiles)",
      },
      {
        "<leader>F",
        function()
          open_live_grep({ reset = true })
        end,
        desc = "Live grep",
      },
      {
        "<leader>fI",
        function()
          open_live_grep({ with_ignored = true })
        end,
        desc = "Live grep (+ gitignored & dotfiles)",
      },
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
