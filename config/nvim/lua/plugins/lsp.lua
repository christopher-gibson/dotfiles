-- LSP stack using nvim 0.11 native API (vim.lsp.config / vim.lsp.enable)
-- mason installs servers → mason-lspconfig triggers setup → vim.lsp.* configures them

local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition,                   "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration,                  "Go to declaration")
  map("n", "gr", "<cmd>Telescope lsp_references<cr>",      "Go to references")
  map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", "Go to implementation")
  map("n", "gy", vim.lsp.buf.type_definition,              "Go to type definition")
  map("n", "K",  vim.lsp.buf.hover,                        "Hover docs")
  map("n", "<C-s>", vim.lsp.buf.signature_help,            "Signature help")
  map("n", "<leader>rn", vim.lsp.buf.rename,               "Rename symbol")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>gf", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, "Format buffer")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,    "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
end

-- Per-server config overrides (merged on top of lspconfig defaults)
local server_configs = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
        diagnostics = { globals = { "vim" } },
        telemetry = { enable = false },
      },
    },
  },
  solargraph = {
    settings = { solargraph = { diagnostics = true, formatting = false } },
  },
  eslint = {
    settings = { eslint = { autoFixOnSave = true } },
  },
}

return {
  -- Install and manage LSP servers + formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })
      -- Auto-install non-LSP tools
      local registry = require("mason-registry")
      for _, tool in ipairs({ "prettier", "stylua" }) do
        local ok, pkg = pcall(registry.get_package, tool)
        if ok and not pkg:is_installed() then pkg:install() end
      end
    end,
  },

  -- Bridge: mason installs → vim.lsp.config enables
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- vim.lsp.config (0.11 native API) does NOT support on_attach;
      -- use the LspAttach autocmd instead.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          on_attach(client, args.buf)

          if client and client.name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.code_action({
                  context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
                  apply = true,
                })
              end,
            })
          end
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", "eslint", "lua_ls", "solargraph", "cssls", "html", "jsonls",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            local cfg = vim.tbl_deep_extend("force", {
              capabilities = capabilities,
            }, server_configs[server_name] or {})
            vim.lsp.config(server_name, cfg)
            vim.lsp.enable(server_name)
          end,
        },
      })

      vim.diagnostic.config({
        virtual_text     = { prefix = "●" },
        signs            = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰠠 ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
        float            = { border = "rounded", source = true },
      })
    end,
  },

  -- Provides default cmd/filetypes/root_markers for 200+ servers
  { "neovim/nvim-lspconfig", lazy = true },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        completion = { completeopt = "menu,menuone,noinsert" },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources(
          { { name = "nvim_lsp" }, { name = "luasnip" } },
          { { name = "buffer" },   { name = "path" } }
        ),
        formatting = {
          format = function(entry, item)
            item.menu = ({ nvim_lsp = "[LSP]", luasnip = "[Snip]", buffer = "[Buf]", path = "[Path]" })[entry.source.name]
            return item
          end,
        },
        experimental = { ghost_text = true },
      })

      -- Autopairs integration
      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },

  -- Format-on-save
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    keys  = {
      { "<leader>gf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer" },
    },
    opts = {
      formatters_by_ft = {
        lua             = { "stylua" },
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        css             = { "prettier" },
        html            = { "prettier" },
        json            = { "prettier" },
        markdown        = { "prettier" },
        yaml            = { "prettier" },
      },
      format_on_save = { timeout_ms = 2000, lsp_fallback = true },
    },
  },
}
