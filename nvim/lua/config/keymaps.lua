-- Keymaps
-- Custom keybindings for editor operations
-- Plugin-specific keymaps are defined in their respective plugin files

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Exit insert mode with jk or kj
keymap.set("i", "jk", "<ESC>", opts)
keymap.set("i", "kj", "<ESC>", opts)

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- Delete character without copying to register
keymap.set("n", "x", '"_x', opts)

-- Increment/decrement numbers (backup if dial.nvim not working)
keymap.set("n", "<leader>=", "<C-a>", opts)
keymap.set("n", "<leader>_", "<C-x>", opts)

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", opts)       -- split vertical
keymap.set("n", "<leader>sh", "<C-w>s", opts)       -- split horizontal
keymap.set("n", "<leader>se", "<C-w>=", opts)       -- equalize splits
keymap.set("n", "<leader>sx", ":close<CR>", opts)   -- close split

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", opts)  -- new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close tab
keymap.set("n", "<leader>tn", ":tabn<CR>", opts)    -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", opts)    -- previous tab

-- Move text up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Stay in visual mode when indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Keep cursor centered when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Paste without overwriting register in visual mode
keymap.set("v", "p", '"_dP', opts)

-- Resize splits with arrow keys
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Save and quit shortcuts
keymap.set("n", "<leader>w", ":w<CR>", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
keymap.set("n", "<leader>wq", ":wq<CR>", opts)

-- Transpose characters
keymap.set("n", "<C-t>", "xp", opts)            -- swap current with next
keymap.set("n", "<leader>t", "Xp", opts)        -- swap current with previous
keymap.set("i", "<C-t>", "<Esc>xpi", opts)      -- swap in insert mode

-- Line duplication
keymap.set("n", "<leader>ld", ":t.<CR>", opts)  -- duplicate line down
keymap.set("n", "<leader>lu", ":t-1<CR>", opts) -- duplicate line up
keymap.set("v", "<leader>ld", ":t'><CR>", opts) -- duplicate selection down

-- Join lines while keeping cursor position
keymap.set("n", "J", "mzJ`z", opts)
keymap.set("n", "<leader>J", "mzvipJ`z", opts)  -- join paragraph

-- Insert empty lines
keymap.set("n", "<leader>lo", "o<Esc>", opts)   -- below
keymap.set("n", "<leader>lO", "O<Esc>", opts)   -- above
keymap.set("n", "<leader>lx", "dd", opts)       -- delete line
keymap.set("n", "<leader>lc", "0C", opts)       -- clear line content

-- Select entire buffer
keymap.set("n", "<leader>sa", "ggVG", opts)

-- Paste with proper indent
keymap.set("n", "<leader>p", "]p", opts)
keymap.set("n", "<leader>P", "]P", opts)

-- Search and replace word under cursor
keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- Toggle case
keymap.set("n", "<leader>tc", "~", opts)        -- character
keymap.set("v", "<leader>tc", "~", opts)        -- selection
keymap.set("n", "<leader>tu", "gUU", opts)      -- uppercase line
keymap.set("n", "<leader>tl", "guu", opts)      -- lowercase line
keymap.set("v", "<leader>tu", "gU", opts)       -- uppercase selection
keymap.set("v", "<leader>tl", "gu", opts)       -- lowercase selection

-- Toggle between single window and vertical split with alternate buffer
keymap.set("n", "<leader>st", function()
  if vim.fn.winnr("$") == 1 then
    vim.cmd("vsplit | b#")
  else
    vim.cmd("only")
  end
end, { desc = "Toggle split view" })

-- Move current buffer to other split
keymap.set("n", "<leader>sm", function()
  local buf_to_move = vim.api.nvim_get_current_buf()
  local alt_buf = vim.fn.bufnr("#")
  vim.cmd("wincmd w")
  vim.cmd("buffer " .. buf_to_move)
  vim.cmd("wincmd p")
  if alt_buf ~= -1 and alt_buf ~= buf_to_move then
    vim.cmd("buffer " .. alt_buf)
  else
    vim.cmd("bnext")
  end
end, { desc = "Move buffer to other split" })
