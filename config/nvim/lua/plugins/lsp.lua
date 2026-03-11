-- LSP, completion, formatting stack
-- mason.nvim installs servers → mason-lspconfig bridges to lspconfig → nvim-cmp provides completion

local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Navigation
  map("n", "gd", vim.lsp.buf.definition,                         "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration,                        "Go to declaration")
  map("n", "gr", "<cmd>Telescope lsp_references<cr>",            "Go to references")
  map("n", "gi", "<cmd>Telescope lsp_implementations<cr>",       "Go to implementation")
  map("n", "gy", vim.lsp.buf.type_definition,                    "Go to type definition")

  -- Documentation
  map("n", "K",  vim.lsp.buf.hover,                              "Hover docs")
  map("n", "<C-s>", vim.lsp.buf.signature_help,                  "Signature help")

  -- Refactoring
  map("n", "<leader>rn", vim.lsp.buf.rename,                     "Rename symbol")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,       "Code action")

  -- Formatting (conform.nvim handles format-on-save, this is manual)
  map("n", "<leader>gf", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end, "Format buffer")

  -- Workspace
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,       "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,    "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
end

return {
  -- Install and manage LSP servers, formatters, linters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })

      -- Ensure non-LSP tools are installed
      local registry = require("mason-registry")
      local ensure = { "prettier", "stylua" }
      for _, tool in ipairs(ensure) do
        local ok, pkg = pcall(registry.get_package, tool)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },

  -- Bridge mason ↔ lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",      -- TypeScript / JavaScript
        "eslint",     -- ESLint (lint + code actions)
        "lua_ls",     -- Lua (for editing this config)
        "solargraph", -- Ruby
        "cssls",      -- CSS
        "html",       -- HTML
        "jsonls",     -- JSON
      },
      automatic_installation = true,
    },
  },

  -- Native LSP client configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Per-server settings
      local servers = {
        ts_ls = {},
        eslint = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            -- Auto-fix on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },
        cssls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              diagnostics = { globals = { "vim" } },
              telemetry = { enable = false },
            },
          },
        },
        solargraph = {
          settings = {
            solargraph = {
              diagnostics = true,
              formatting = false, -- Let conform handle formatting
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        if not config.on_attach then
          config.on_attach = on_attach
        end
        lspconfig[server].setup(config)
      end

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })

      -- Diagnostic signs with icons
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },

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
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
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
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, item)
            local source_labels = {
              nvim_lsp = "[LSP]",
              luasnip  = "[Snip]",
              buffer   = "[Buf]",
              path     = "[Path]",
            }
            item.menu = source_labels[entry.source.name] or entry.source.name
            return item
          end,
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Integrate with nvim-autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Formatter (format-on-save)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>gf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer" },
    },
    opts = {
      formatters_by_ft = {
        lua              = { "stylua" },
        javascript       = { "prettier" },
        javascriptreact  = { "prettier" },
        typescript       = { "prettier" },
        typescriptreact  = { "prettier" },
        css              = { "prettier" },
        html             = { "prettier" },
        json             = { "prettier" },
        markdown         = { "prettier" },
        yaml             = { "prettier" },
      },
      format_on_save = {
        timeout_ms   = 2000,
        lsp_fallback = true,
      },
    },
  },
}
