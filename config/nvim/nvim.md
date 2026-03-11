# nvim cheatsheet

## Plugins

| Task | Command |
|------|---------|
| Open plugin manager | `:Lazy` |
| Update all plugins | `:Lazy update` |
| Install missing plugins | `:Lazy install` |
| Clean unused plugins | `:Lazy clean` |
| Open LSP/tool installer | `:Mason` |
| Update Mason packages | `:MasonUpdate` |
| Update treesitter parsers | `:TSUpdate` |

**Cadence:** Run `:Lazy update` + `:MasonUpdate` weekly. `:TSUpdate` monthly or when parsers feel broken.

---

## LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover docs |
| `<C-s>` | Signature help (insert mode) |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>gf` | Format buffer |
| `<leader>j` | Next diagnostic |
| `<leader>k` | Prev diagnostic |
| `<leader>d` | Diagnostic float |

---

## Completion

| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Next / prev item |
| `<Tab>` / `<S-Tab>` | Next / prev (also jumps snippets) |
| `<CR>` | Confirm (only if explicitly selected) |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort |
| `<C-f>` / `<C-b>` | Scroll docs |

---

## Telescope

| Key | Action |
|-----|--------|
| `<leader>f` | Find files |
| `<leader>F` | Live grep |
| `<leader>b` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>/` | Search in current buffer |
| `<leader>fs` | Document symbols |
| `<leader>fS` | Workspace symbols |
| `<leader>fd` | Diagnostics |
| `<leader>ft` | TODOs |
| `<leader>gc` | Git commits |

**Inside Telescope:** `<C-j>`/`<C-k>` navigate · `<esc>` close · `<C-p>` toggle preview · `<C-d>` delete buffer

---

## File Explorer (oil.nvim)

| Key | Action |
|-----|--------|
| `-` or `<leader>e` | Open parent directory |
| `<CR>` | Open file/dir |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |
| `-` | Go up a directory |
| `g.` | Toggle hidden files |
| `<esc>` | Close |

> Directories are editable buffers — rename/delete/move by editing the text and saving.

---

## Git (gitsigns)

| Key | Action |
|-----|--------|
| `<leader>gb` | Blame current line |
| `<leader>gB` | Blame full (popup) |
| `<leader>gp` | Preview hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage buffer |
| `<leader>gR` | Reset buffer |
| `<leader>gu` | Undo stage hunk |
| `<leader>gd` | Diff this |
| `]g` / `[g` | Next / prev hunk |

---

## Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>xd` | Buffer diagnostics only |
| `<leader>xs` | Symbols panel |
| `<leader>xl` | Location list |
| `<leader>xq` | Quickfix list |

---

## Buffers & Windows

| Key | Action |
|-----|--------|
| `<leader>l` | Next buffer |
| `<leader>h` | Prev buffer |
| `<leader>q` | Close buffer |
| `<C-h/j/k/l>` | Navigate splits / tmux panes |
| `→ ← ↑ ↓` | Resize current split |

---

## Editing

| Key | Action |
|-----|--------|
| `H` / `L` | Beginning / end of line |
| `<CR>` | New line below (normal mode) |
| `<leader>c` | Clear search highlight |
| `gc` / `gcc` | Toggle comment (visual / line) |
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |
| `x` | Cut (no yank) |
| `gs{motion}` | Sort |
| `<` / `>` | Indent (keeps visual selection) |

---

## Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `aa` / `ia` | Outer / inner argument |
| `]f` / `[f` | Next / prev function |
| `]c` / `[c` | Next / prev class |

---

## Misc

| Key | Action |
|-----|--------|
| `<leader>R` | Reload config |
| `<Space>` | Show which-key popup (after 300ms) |
