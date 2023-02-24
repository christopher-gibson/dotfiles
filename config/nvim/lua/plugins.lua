local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  -- Used my multiple plugins
  "nvim-lua/plenary.nvim",
  -- Required for bufferline and lualine
  "nvim-tree/nvim-web-devicons",

  -- Theme
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  { "nvim-lualine/lualine.nvim", config = true },

  {
    "kdheepak/tabline.nvim",
    config = function()
      require("tabline").setup {
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          section_separators = {'', ''},
          component_separators = {'', ''},
          max_bufferline_percent = 90, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
          show_devicons = true, -- this shows devicons in buffer section
          show_bufnr = false, -- this appends [bufnr] to buffer section,
          show_filename_only = true, -- shows base filename only instead of relative path in filename
          modified_icon = "+ ", -- change the default modified icon
          modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
          show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
        }
      }
      vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "ellisonleao/gruvbox.nvim",
    },
  },

  "editorconfig/editorconfig-vim",
  "rrethy/vim-illuminate",
  "christoomey/vim-sort-motion",
  "tpope/vim-repeat",
  "tpope/vim-surround",

  {
    "rhysd/git-messenger.vim",
    keys = {
      { "<leader>gb", "<cmd>GitMessenger<cr>", desc = "Git blame" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup({
        cut_key = "x",
      })
    end
  },

  -- Show popup of keybindings
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      wk.setup()

      wk.register {
        ["<leader>l"] = { "Buffer next" },
        ["<leader>h"] = { "Buffer previous" },
        ["H"] = { "Move to beginning of line" },
        ["L"] = { "Move to end of line" },
        ["<leader>c"] = { "Clear search" },
      }
    end,
  },

  -- Line commenting
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup()
    end,
  },
  -- Handle embedded languages comments
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Highlight current indented scope
  {
  "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup{}

      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules {
        Rule(" ", " ")
          :with_pair(function (opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
                brackets[1][1]..brackets[1][2],
                brackets[2][1]..brackets[2][2],
                brackets[3][1]..brackets[3][2],
              }, pair)
          end)
      }
      for _,bracket in pairs(brackets) do
        npairs.add_rules {
          Rule(bracket[1].." ", " "..bracket[2])
            :with_pair(function() return false end)
            :with_move(function(opts)
              return opts.prev_char:match(".%"..bracket[2]) ~= nil
            end)
              :use_key(bracket[2])
          }
      end
    end
  },

  -- Remember last file position
  {
    "ethanholz/nvim-lastplace",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  },

  -- "windwp/nvim-spectre",

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    config = true,
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find file" },
      { "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    },
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_cutoff = 0.2,
            preview_height = 0.4,
          },
          height = 0.9,
          width = 0.9,
        },
        mappings = {
          i = {
            ["<esc>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["j"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["gg"] = function(...)
              return require("telescope.actions").move_to_top(...)
            end,
            ["G"] = function(...)
              return require("telescope.actions").move_to_bottom(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
        },
      },
    },
  },

  { "neoclide/coc.nvim", branch = "release" },

  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>",  desc = "Navigate left" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>",  desc = "Navigate down" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>",    desc = "Navigate up" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Navigate right" },
    },
    config = function()
      require("nvim-tmux-navigation").setup({})
    end,
  },
})
