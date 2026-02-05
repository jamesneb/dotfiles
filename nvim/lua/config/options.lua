-- Neovim Options
-- Core editor settings loaded before plugins

local opt = vim.opt

-- Disable netrw file explorer (using oil.nvim instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line numbers: relative with current line showing absolute number
opt.number = true
opt.relativenumber = true

-- Indentation: 2 spaces, auto-indent new lines
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Display: no line wrapping, highlight current line
opt.wrap = false
opt.cursorline = true

-- Search: case-insensitive unless uppercase used, highlight matches
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Colors: 24-bit color support
opt.termguicolors = true
opt.background = "dark"

-- UI: always show sign column to prevent layout shift
opt.signcolumn = "yes"

-- Editing: allow backspace over everything
opt.backspace = "indent,eol,start"

-- Clipboard: use system clipboard
opt.clipboard:append("unnamedplus")

-- Splits: open new splits to right and below
opt.splitright = true
opt.splitbelow = true

-- Files: no swap files, persistent undo history
opt.swapfile = false
opt.undofile = true

-- Performance: faster update time for CursorHold events
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion: show menu even for single match, no auto-select
opt.completeopt = "menuone,noselect"

-- Mouse: enable in all modes
opt.mouse = "a"

-- Scrolling: keep cursor away from screen edges
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Command line: enhanced completion
opt.wildmode = "longest:full,full"

-- Display: show matching brackets
opt.showmatch = true

-- Encoding: UTF-8 everywhere
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Folding: use treesitter for fold detection, start unfolded
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- PATH: include Go binaries
local go_bin = vim.fn.expand("~/go/bin")
if vim.fn.isdirectory(go_bin) == 1 then
  vim.env.PATH = go_bin .. ":" .. vim.env.PATH
end
