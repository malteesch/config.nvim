--- @type LazyPluginSpec
return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'telescope', 'mfussenegger/nvim-dap-python' },
  opts = {
    path = vim.fn.getcwd(),
    name = { '.venv', 'venv' }
  },
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  init = function()
    local venv_augroup = vim.api.nvim_create_augroup("VenvSelector", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        pattern = '*.py',
        callback = function() vim.cmd('VenvSelectCached') end,
        group = venv_augroup
    })
  end
}
