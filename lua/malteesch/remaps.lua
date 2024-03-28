-- NAVIGATION
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- WINDOW
vim.keymap.set('n', '<A-c>', '<C-w>c', { desc = "[C]lose window" })
vim.keymap.set('n', "<A-->", '<C-w>s<C-w>j', { desc = "Split window horizontally" })
vim.keymap.set('n', '<A-\\>', '<C-w>v<C-w>l', { desc = "Split window vertically" })

-- TAB
vim.keymap.set('n', '<C-A-n>', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<C-A-l>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<C-A-h>', '<cmd>tabprevious<CR>')
vim.keymap.set('n', '<C-A-c>', '<cmd>tabclose<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>w', '<cmd>silent w<CR>', { desc = '[W]rite current buffer' })
vim.keymap.set('n', '<leader>wa', '<cmd>silent wa<CR>', { desc = '[W]rite [a]ll buffers' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('t', '<C-n>', '<C-\\><C-n>', { noremap = true })

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- clipboard stuff
vim.keymap.set({ 'n', 'v' }, '<leader>p', '\"+p', { noremap = true })
vim.keymap.set('n', '<leader>P', '\"+P', { noremap = true })
vim.keymap.set('n', '<leader>y', '\"+y', { noremap = true })
