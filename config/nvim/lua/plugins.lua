local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- load packer
vim.cmd("packadd packer.nvim")

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" })

  use 'editorconfig/editorconfig-vim'

  use {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end
  }

  use "lukas-reineke/indent-blankline.nvim"

  use {
    'ethanholz/nvim-lastplace',
    config = function() require'nvim-lastplace'.setup {} end
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require'nvim-autopairs'.setup {} end
  }

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons', -- optional, for file icon
  --   },
  --   config = function() require'nvim-tree'.setup {} end
  -- }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'christoomey/vim-sort-motion'
  use 'vim-airline/vim-airline'
  use 'christoomey/vim-tmux-navigator'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'w0rp/ale'
  use 'terryma/vim-multiple-cursors'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  -- use 'valloric/matchtagalways'
  use 'svermeulen/vim-easyclip'
  use 'ryanoasis/vim-devicons'

  use {
    'neoclide/coc.nvim', branch = 'release'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
