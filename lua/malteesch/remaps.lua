-- GLOBAL
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- WINDOW
-- 	jump between windows
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('n', '<leader>c', '<C-w>q') -- close window
vim.keymap.set('n', '<leader>s', '<C-w>s') -- split window
vim.keymap.set('n', '<leader>v', '<C-w>v') -- split window vertically

