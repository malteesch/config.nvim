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
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.keymap.set('n', '<leader>gp', function ()
	vim.cmd('Git pull')
end, { desc = "git pull"})
vim.keymap.set('n', '<leader>gb', function ()
	vim.cmd('Gitsigns blame_line')
end, { desc = 'git blame line' })

vim.keymap.set('n', '<leader>gl', function()
	local cwd = vim.fn.getcwd()
	local prj = cwd:gsub('/home/malteesch/projects/digibss/', '')
	if cwd:match '^/home/malteesch/projects/digibss/' then
		vim.fn.system({'xdg-open', 'https://gitlab.devops.telekom.de/' .. prj})
	end
end, { desc = 'Open project in GitLab'})
