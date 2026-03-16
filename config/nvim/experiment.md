# Experiment: Tab accepts ghost text / top completion item

**File:** `config/nvim/lua/plugins/lsp.lua` around line 165

## What changed

`<Tab>` now calls `cmp.confirm({ select = true })` instead of `cmp.select_next_item()`.

- **Before:** Tab navigated down through the menu; you had to hit `<CR>` to confirm.
- **After:** Tab immediately accepts the top (or currently highlighted) item — one keystroke to accept the ghost text suggestion.

`<C-n>` / `<C-p>` still navigate the menu if you want to pick a different item before confirming.

## To revert

In `config/nvim/lua/plugins/lsp.lua`, change:

```lua
if cmp.visible() then cmp.confirm({ select = true })
```

back to:

```lua
if cmp.visible() then cmp.select_next_item()
```

---

# Experiment: Cursor tab completion

**File:** `config/nvim/lua/plugins/experiments.lua`

## What changed

Added `BenGu3/cursor-tab.nvim` which proxies tab completion through a running Cursor instance.

## Setup required

Cursor must be installed at `/Applications/Cursor.app` and you must be logged in. The plugin reads credentials from Cursor's local SQLite database automatically. Toggle with `:CursorTab toggle`.

## To revert

Remove or comment out the `BenGu3/cursor-tab.nvim` block in `config/nvim/lua/plugins/experiments.lua`.
