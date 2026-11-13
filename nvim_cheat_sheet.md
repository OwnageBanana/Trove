tags: #vim #nvim #programming #editing #cheatsheet
Keymaps and settings from my own config (`~/.config/nvim/init.lua` + `after/plugin/*.lua`).
For general vim motions see [[Cheat Sheet]].

**Leader = `Space`**  ·  Plugin manager: Packer  ·  Theme: kanagawa-wave

---
## Files & Navigation

| Keys                | Mode | Action                                      |
| ------------------- | ---- | ------------------------------------------- |
| `<leader>pv`        | n    | Open netrw file explorer (`:Ex`)            |
| `<C-p>`             | n    | Telescope: git files                        |
| `<leader>sf`        | n    | Telescope: find files                       |
| `<leader>?`         | n    | Telescope: recently opened files            |
| `<leader><space>`   | n    | Telescope: open buffers                     |
| `<leader>u`         | n    | Toggle Undotree                             |

### `<C-p>` vs `<leader>sf`

| | `<C-p>` (git files) | `<leader>sf` (find files) |
| --- | --- | --- |
| How | `git ls-files` | `rg --files` |
| Skips `node_modules` / `.gitignore`d stuff | ✅ | ✅ (when inside a git repo) |
| Shows new files not yet `git add`ed | ❌ | ✅ |
| Works outside a git repo | ❌ errors | ✅ |
| Searches from | Repo root | Current folder |
| Committed dotfiles (`.github/`, `.eslintrc`) | ✅ | ❌ hidden files skipped |
| Speed | Fastest (git already knows the list) | Fast |

**Rule of thumb:** `<C-p>` in a repo for the cleanest list. `<leader>sf` when the file is brand new or you're not in a repo.

## Searching (Telescope)

Telescope = fuzzy-finder popup. Type part of a name, the list narrows live, `Enter` opens it. Preview pane on the side. All `<leader>s…` keys = **s**earch.

| Keys         | Mode | Action                                  |
| ------------ | ---- | --------------------------------------- |
| `<leader>/`  | n    | Fuzzy search in current buffer          |
| `<leader>sg` | n    | Live grep across project (needs `ripgrep`) |
| `<leader>sw` | n    | Grep word under cursor                  |
| `<leader>sh` | n    | Search help tags                        |
| `<leader>sd` | n    | Search diagnostics                      |
| `gr`         | n    | LSP references to symbol under cursor   |

**Inside the Telescope popup**

| Keys                  | Action                          |
| --------------------- | ------------------------------- |
| *type*                | Fuzzy filter (`ilua` → `init.lua`) |
| `<C-n>` / `<C-p>` / arrows | Move down / up             |
| `Enter`               | Open                            |
| `<C-x>`               | Open in horizontal split        |
| `<C-v>`               | Open in vertical split          |
| `<Esc>` `<Esc>`       | Close (first exits insert mode) |

> `<C-u>` / `<C-d>` are disabled in the prompt (so they act as normal insert-mode keys).

## Editing

| Keys         | Mode   | Action                                                       |
| ------------ | ------ | ------------------------------------------------------------ |
| `J` / `K`    | v      | Move selected lines down / up (and re-indent)                |
| `<leader>p`  | x      | Paste over selection **without** losing the yank register   |
| `<leader>y`  | n, v   | Yank to system clipboard                                     |
| `<leader>Y`  | n      | Yank line to system clipboard                                |
| `<leader>sr` | n      | Substitute word under cursor — **current line** (was `<leader>s`; renamed so Neovim doesn't pause waiting for a Telescope key) |
| `<leader>S`  | n      | Substitute word under cursor — **whole file**                |
| `<BS>`       | n      | Delete char before cursor (`X`)                              |
| `<leader>X`  | n      | `chmod +x` the current file                                  |
| `gc` / `gcc` | n, v   | Toggle comment (motion / line) — Comment.nvim                |
| `gb` / `gbc` | n, v   | Toggle block comment — Comment.nvim                          |
| `<leader>a`  | n      | Swap parameter with the next one (treesitter)                |
| `<leader>A`  | n      | Swap parameter with the previous one (treesitter)            |

## Scrolling & Search Centering

| Keys            | Mode | Action                                   |
| --------------- | ---- | ---------------------------------------- |
| `<C-d>`/`<C-u>` | n    | Half-page down / up, cursor centered     |
| `n` / `N`       | n    | Next / prev search match, centered       |
| `j` / `k`       | n    | Move by *display* line when no count given (wrap-friendly) |

## Command-line Helpers

| Keys            | Mode | Action                                          |
| --------------- | ---- | ----------------------------------------------- |
| `<C-f>`         | n    | Open command-line window (`q:`) in insert mode  |
| `Q`             | n    | Disabled (no Ex mode)                           |
| `:Q` `:Wq` `:WQ`| n    | Typo-forgiving → `:q` / `:wq`                   |

## Treesitter Text Objects & Motions

Use with operators, e.g. `daf` = delete function, `vic` = select inside class, `cia` = change argument.

| Object      | Meaning              |
| ----------- | -------------------- |
| `af` / `if` | function outer/inner |
| `ac` / `ic` | class outer/inner    |
| `aa` / `ia` | parameter outer/inner|

| Keys        | Action                         |
| ----------- | ------------------------------ |
| `]m` / `[m` | Next / prev function **start** |
| `]M` / `[M` | Next / prev function **end**   |
| `]]` / `[[` | Next / prev class **start**    |
| `][` / `[]` | Next / prev class **end**      |

**Incremental selection**

| Keys            | Action                      |
| --------------- | --------------------------- |
| `<C-space>`     | Start / expand to next node |
| `<C-s>`         | Expand to scope             |
| `<C-backspace>` | Shrink selection            |

## Diagnostics

| Keys        | Action                              |
| ----------- | ----------------------------------- |
| `[d` / `]d` | Previous / next diagnostic          |
| `<leader>e` | Show diagnostic in floating window  |
| `<leader>q` | Send diagnostics to location list   |

## LSP (buffer-local, when a server attaches)

| Keys          | Action                          |
| ------------- | ------------------------------- |
| `gd`          | Go to definition                |
| `gD`          | Go to declaration               |
| `gr`          | References (Telescope)          |
| `gi`          | Go to implementation            |
| `gt`          | Go to type definition           |
| `K` / `<C-.>` | Hover docs                      |
| `<C-k>` (normal + insert) | Signature help      |
| `<leader>rn`  | Rename symbol                   |
| `<leader>ca` / `<leader>af` | Code action       |
| `<leader>ds`  | Document symbols (Telescope)    |
| `<leader>ws`  | Workspace symbols (Telescope)   |
| `<leader>wa` / `wr` / `wl` | Workspace folder add / remove / list |
| `:Format`     | Format buffer with LSP          |

Servers: clangd, gopls, lua_ls (via Mason), rust-analyzer (via rustup), plus anything else installed in Mason (bash, css, html, json, eslint, golangci-lint…).

## Completion (nvim-cmp, insert mode)

| Keys          | Action                                            |
| ------------- | ------------------------------------------------- |
| `<C-Space>`   | Trigger completion menu                           |
| `<CR>`        | Confirm selection                                 |
| `<Tab>`       | Next item / expand or jump forward in snippet     |
| `<S-Tab>`     | Prev item / jump back in snippet                  |

Sources: LSP, LuaSnip.

## Git

| Keys / Cmd   | Action                          |
| ------------ | ------------------------------- |
| `<leader>gs` | Open Fugitive status (`:Git`)   |
| `:GBrowse`   | Open file on GitHub (rhubarb)   |
| Gutter signs | `+` add · `~` change · `_` delete (gitsigns) |

---
## Notable Settings

- Relative + absolute line numbers, sign column always on
- Tabs = 4 spaces (`vim-sleuth` auto-detects per file)
- `scrolloff = 8`, colour column at 80
- Persistent undo in `~/.cache/nvim/undodir`
- Search: no highlight, incremental, smart-case
- Yanked text briefly highlights
- Saving `init.lua` auto-runs `:PackerCompile`

## Plugins

packer · nvim-lspconfig · mason · mason-lspconfig · fidget · neodev · nvim-cmp · LuaSnip · treesitter (+ textobjects, playground) · undotree · fugitive · rhubarb · gitsigns · gruvbox · kanagawa · lualine · indent-blankline · Comment.nvim · vim-sleuth · telescope (+ fzf-native)

---
