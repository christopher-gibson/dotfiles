-- Experimental plugins — may be removed or promoted to permanent config
return {

  -- EXPERIMENT: Cursor tab completion via running Cursor instance
  -- Set CURSOR_PORT env var or update cursor_endpoint below
  -- See: https://github.com/BenGu3/cursor-tab.nvim
  {
    "BenGu3/cursor-tab.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

}
