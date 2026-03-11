return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]g", function()
          if vim.wo.diff then return "]g" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, "Next hunk")
        map("n", "[g", function()
          if vim.wo.diff then return "[g" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, "Prev hunk")

        -- Actions
        map("n", "<leader>gb", gs.blame_line,          "Git blame line")
        map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "Git blame full")
        map("n", "<leader>gp", gs.preview_hunk,        "Preview hunk")
        map("n", "<leader>gs", gs.stage_hunk,          "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk,          "Reset hunk")
        map("n", "<leader>gS", gs.stage_buffer,        "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer,        "Reset buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk,     "Undo stage hunk")
        map("n", "<leader>gd", gs.diffthis,            "Diff this")
      end,
    },
  },
}
