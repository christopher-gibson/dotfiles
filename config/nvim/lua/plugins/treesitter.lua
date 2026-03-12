return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "css", "html", "javascript", "json", "lua",
          "markdown", "markdown_inline", "ruby", "tsx", "typescript",
          "vim", "vimdoc", "yaml",
        },
        auto_install = true,
        highlight = {
          enable = true,
          -- Disable for large files
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then return true end
          end,
        },
        indent = { enable = true },
        -- Text objects powered by treesitter
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Outer function" },
              ["if"] = { query = "@function.inner", desc = "Inner function" },
              ["ac"] = { query = "@class.outer",    desc = "Outer class" },
              ["ic"] = { query = "@class.inner",    desc = "Inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "Outer argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Inner argument" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]c"] = { query = "@class.outer",    desc = "Next class start" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]C"] = { query = "@class.outer",    desc = "Next class end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Prev function start" },
              ["[c"] = { query = "@class.outer",    desc = "Prev class start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Prev function end" },
              ["[C"] = { query = "@class.outer",    desc = "Prev class end" },
            },
          },
          swap = {
            enable = true,
            swap_next     = { ["<leader>sp"] = "@parameter.inner" },
            swap_previous = { ["<leader>sP"] = "@parameter.inner" },
          },
        },
      })
    end,
  },
}
