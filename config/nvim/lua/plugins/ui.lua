return {
  -- Required by many plugins
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- Color scheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Buffer tabs (replaces kdheepak/tabline.nvim)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " " }
          local ret = (diag.error and icons.error .. diag.error .. " " or "")
            .. (diag.warning and icons.warning .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          { filetype = "oil", text = "File Explorer", highlight = "Directory", text_align = "left" },
        },
      },
    },
  },

  -- Indent guides (v3 API)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = false }, -- mini.indentscope handles scope highlight
    },
  },

  -- Animated indent scope highlight
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      -- Disable for certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "dashboard", "lazy", "mason", "trouble", "oil" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = { window = { winblend = 0 } },
    },
  },

  -- Diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix list" },
    },
    opts = {},
  },

  -- Highlight TODO/FIXME/HACK/NOTE/etc in comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    },
  },

  -- Keymap popup (v3 API)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { delay = 300 },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>h",  desc = "Prev buffer" },
        { "<leader>l",  desc = "Next buffer" },
        { "<leader>q",  desc = "Close buffer" },
        { "<leader>c",  desc = "Clear search" },
        { "<leader>d",  desc = "Diagnostic float" },
        { "<leader>j",  desc = "Next diagnostic" },
        { "<leader>k",  desc = "Prev diagnostic" },
        { "<leader>R",  desc = "Reload config" },
        { "<leader>f",  desc = "Find files" },
        { "<leader>F",  desc = "Live grep" },
        { "<leader>gb", desc = "Git blame" },
        { "<leader>rn", desc = "Rename symbol" },
        { "<leader>ca", desc = "Code action" },
        { "<leader>x",  group = "Trouble / diagnostics" },
        { "<leader>ft", desc = "Find TODOs" },
        { "H",          desc = "Beginning of line" },
        { "L",          desc = "End of line" },
        { "gd",         desc = "Go to definition" },
        { "gD",         desc = "Go to declaration" },
        { "gr",         desc = "Go to references" },
        { "gi",         desc = "Go to implementation" },
        { "gy",         desc = "Go to type definition" },
        { "K",          desc = "Hover docs" },
      })
    end,
  },
}
