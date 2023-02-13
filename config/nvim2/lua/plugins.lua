local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({ 'Yggdroot/LeaderF', cmd = 'Leaderf', run = ':LeaderfInstallCExtension', event = 'VimEnter' })

  use 'editorconfig/editorconfig-vim'

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'ethanholz/nvim-lastplace',
    config = function() require('nvim-lastplace').setup() end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
      require('config/autopair')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = { "typescript", "javascript", "ruby", "tsx", "css", "json" }
      }
    end
  }

  -- Install and manage LSP, DAP, linters, formatters
  use {
  'williamboman/mason.nvim',
  config = function ()
    require('mason').setup()
  end
}
  use 'williamboman/mason-lspconfig.nvim'

  use {
  'neovim/nvim-lspconfig',
    config = function ()
      require('lspconfig').tsserver.setup {}
    end
  }
  vim.keymap.set('n', '<leader>k', vim.diagnostic.goto_prev, {})
  vim.keymap.set('n', '<leader>j', vim.diagnostic.goto_next, {})

  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      require('null-ls').setup({
          sources = {
            require('null-ls').builtins.formatting.prettier,
            require('null-ls').builtins.diagnostics.eslint,
            require('null-ls').builtins.diagnostics.tsc,
            require('null-ls').builtins.diagnostics.rubocop,
            require('null-ls').builtins.formatting.rubocop,
          },
          -- Format on save
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
        })
    end
  })

  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'neovim/nvim-lspconfig',
      -- "andersevenrud/cmp-tmux",
      "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- "lukas-reineke/cmp-rg",
      -- "onsails/lspkind-nvim",
      -- "petertriho/cmp-git",
      -- "rcarriga/cmp-dap",
    },
    config = function ()
      local cmp = require('cmp')
      local types = require('cmp.types')

      cmp.setup {
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item { behavior = types.cmp.SelectBehavior.Select }
              else
                fallback()
              end
            end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
        })
      }

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
              { name = 'path' }
            }, {
              { name = 'cmdline' }
            })
        })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require('lspconfig').tsserver.setup {
        capabilities = capabilities
      }
    end
  }

  use 'tpope/vim-fugitive'
  use 'christoomey/vim-sort-motion'
  use {'vim-airline/vim-airline-themes', event = 'VimEnter'}
  use {'vim-airline/vim-airline', after = 'vim-airline-themes'}
  use 'christoomey/vim-tmux-navigator'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  -- use 'RRethy/vim-illuminate'

  -- use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use({
    'gbprod/cutlass.nvim',
    config = function()
      require('cutlass').setup({
        cut_key = 'x'
      })
    end
  })

  -- use {
  --   'neoclide/coc.nvim', branch = 'release'
  -- }

  use {
    'ellisonleao/gruvbox.nvim',
    config = function()
      vim.o.background = 'dark'
      vim.cmd([[colorscheme gruvbox]])
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
