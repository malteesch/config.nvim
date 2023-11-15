local command = require('neo-tree.command')

vim.keymap.set('n', '<leader>fo', function ()
	command.execute({
		action = 'focus',
		position = 'float'
	})
end, { desc = '[F]iletree [o]pen'})

