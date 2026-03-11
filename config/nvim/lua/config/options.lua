local opt = vim.opt

-- Editor
opt.encoding = "utf-8"
opt.hidden = true          -- Hide buffers instead of closing
opt.autoread = true        -- Auto-reload files changed outside nvim
opt.updatetime = 250       -- Faster CursorHold events (used by gitsigns, etc.)
opt.timeoutlen = 300       -- Faster which-key popup
opt.ttimeoutlen = 0
opt.shortmess:append("aAIsT")
opt.clipboard = "unnamed"
opt.history = 100

-- Display
opt.termguicolors = true
opt.background = "dark"
opt.colorcolumn = "80"
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.signcolumn = "yes"     -- Always show (prevents layout shift from diagnostics)
opt.showmode = false       -- Already shown in statusline

-- Mouse
opt.mouse = "a"
opt.mousehide = true

-- Scrolling
opt.scrolloff = 5
opt.sidescroll = 1
opt.sidescrolloff = 5

-- Wildmenu
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Wrapping
opt.wrap = false
opt.whichwrap = "b,s,h,l,<,>,[,]"
opt.backspace = "indent,eol,start"

-- Indentation
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.autoindent = true
opt.smartindent = true

-- Misc
opt.joinspaces = false
opt.foldenable = false
opt.splitbelow = true
opt.splitright = true

-- Show whitespace
opt.list = true
opt.listchars = { tab = ">·", trail = "·", nbsp = "¬" }

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undodir = vim.fn.expand("~/.vim/undo")
opt.undofile = true
opt.undolevels = 1000

-- Completion
opt.completeopt = "menu,menuone,noselect"
