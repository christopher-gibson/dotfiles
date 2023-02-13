local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
    {
        "editorconfig/editorconfig-vim",
        event = "VeryLazy",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "jose-elias-alvarez/typescript.nvim",
            init = function()
              require("lazyvim.util").on_attach(function(_, buffer)
                -- stylua: ignore
                vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports",
                    { buffer = buffer, desc = "Organize Imports" })
                vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
              end)
            end,
        },
        ---@class PluginLspOpts
        opts = {
            servers = {
                -- tsserver will be automatically installed with mason and loaded with lspconfig
                tsserver = {},
                solargraph = {},
                sorbet = {},
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- example to setup with typescript.nvim
                tsserver = function(_, opts)
                  require("typescript").setup({ server = opts })
                  return true
                end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
    },

    { import = "lazyvim.plugins.extras.lang.typescript" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          -- add tsx and treesitter
          vim.list_extend(opts.ensure_installed, {
              "tsx",
              "typescript",
              "ruby",
          })
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
          local null_ls = require("null-ls")
          return {
              sources = {
                  null_ls.builtins.diagnostics.eslint,
                  null_ls.builtins.formatting.prettier,
                  null_ls.builtins.diagnostics.rubocop,
                  null_ls.builtins.formatting.rubocop,
              },
              on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                  vim.api.nvim_create_autocmd("BufWritePre", {
                      group = augroup,
                      buffer = bufnr,
                      callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                      end,
                  })
                end
              end,
          }
        end,
    },

    -- Use <tab> for completion and snippets (supertab)
    -- first: disable default <tab> and <s-tab> behavior in LuaSnip
    {
        "L3MON4D3/LuaSnip",
        keys = function()
          return {}
        end,
    },
    -- then: setup supertab in cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-emoji",
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
          local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0
                and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
          end

          local luasnip = require("luasnip")
          local cmp = require("cmp")

          opts.mapping = vim.tbl_extend("force", opts.mapping, {
                  ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                      cmp.select_next_item()
                      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                      -- they way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                      luasnip.expand_or_jump()
                    elseif has_words_before() then
                      cmp.complete()
                    else
                      fallback()
                    end
                  end, { "i", "s" }),
                  ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                      cmp.select_prev_item()
                    elseif luasnip.jumpable( -1) then
                      luasnip.jump( -1)
                    else
                      fallback()
                    end
                  end, { "i", "s" }),
              })
        end,
    },
}
