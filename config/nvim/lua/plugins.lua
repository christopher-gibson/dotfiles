local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- load packer
vim.cmd("packadd packer.nvim")

-- auto
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    autocmd BufWritePost plugins.lua source <afile> | PackerClean
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])

return require('packer').startup(function(use)
  use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension", event = "VimEnter" })

  use 'editorconfig/editorconfig-vim'

  use "lukas-reineke/indent-blankline.nvim"

  use {
    'ethanholz/nvim-lastplace',
    config = function() require('nvim-lastplace').setup() end
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
      require("config/autopair")
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'tpope/vim-fugitive'
  use 'sheerun/vim-polyglot'
  use 'christoomey/vim-sort-motion'
  use {'vim-airline/vim-airline-themes', event = 'VimEnter'}
  use {'vim-airline/vim-airline', after = 'vim-airline-themes'}
  use 'christoomey/vim-tmux-navigator'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'w0rp/ale'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'valloric/matchtagalways'
  use 'ryanoasis/vim-devicons'
  use({"tpope/vim-commentary", event = "VimEnter"})

  use({
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup({
        cut_key = "x"
      })
    end
  })

  use {
    'neoclide/coc.nvim', branch = 'release'
  }

  use {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
