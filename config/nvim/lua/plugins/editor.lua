return {
    {
        "gbprod/cutlass.nvim",
        config = function()
          require("cutlass").setup({
              cut_key = "x"
          })
        end
    },

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

    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "gruvbox",
        },
    },

    {
        "nvim-telescope/telescope.nvim",
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
}
