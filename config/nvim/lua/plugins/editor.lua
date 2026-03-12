return {
  -- Surround text objects (replaces tpope/vim-surround + tpope/vim-repeat)
  -- Usage: ys{motion}{char}, ds{char}, cs{old}{new}, visual S{char}
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-close brackets with smart spacing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true, -- Use treesitter for smarter pairing
      })

      -- Add space padding inside brackets: ( text )
      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules({
        Rule(" ", " ")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2],
            }, pair)
          end),
      })
      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(function() return false end)
            :with_move(function(opts)
              return opts.prev_char:match(".%" .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2]),
        })
      end
    end,
  },

  -- Line commenting (gc / gcc)
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup({
        options = {
          -- Use treesitter to determine comment string for embedded languages
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring()
              or vim.bo.commentstring
          end,
        },
      })
    end,
  },

  -- Smart comment string for embedded languages (e.g. JS in HTML templates)
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = { enable_autocmd = false },
  },

  -- Highlight all occurrences of word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = { providers = { "lsp" } },
      })
    end,
  },

  -- Sort with motion (gs to sort)
  "christoomey/vim-sort-motion",

  -- Cut without polluting yank register (x key cuts cleanly)
  {
    "gbprod/cutlass.nvim",
    opts = { cut_key = "x" },
  },

  -- Auto-restore last cursor position in file
  {
    "ethanholz/nvim-lastplace",
    opts = {},
  },
}
