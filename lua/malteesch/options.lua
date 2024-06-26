local globalOptions = {
    mapleader = ' ',
    maplocalleader = ' ',
}

local windowOptions = {
    relativenumber = true,
    number = true,
}

local options = {
    hlsearch = false,
    mouse = 'a',
    breakindent = true,
    undofile = true,
    -- Case-insensitive searching UNLESS \C or capital in search
    ignorecase = true,
    smartcase = true,
    -- Keep signcolumn on by default
    signcolumn = 'yes',
    -- Decrease update time
    updatetime = 250,
    timeoutlen = 300,
    -- Set completeopt to have a better completion experience
    completeopt = 'menuone,noselect',
    termguicolors = true,
    wrap = false,
    sidescrolloff = 15,
    cursorline = true,
    cursorlineopt = 'both',
    showmode = false,
    tabstop = 4,
    softtabstop = 4,
    expandtab = true,
    shiftwidth = 4,
    shell = '/bin/zsh',
    scrolloff = 10,
    exrc = true,
    foldcolumn = '1',
}

for key, value in pairs(globalOptions) do
    vim.g[key] = value
end

for key, value in pairs(windowOptions) do
    vim.wo[key] = value
end

for key, value in pairs(options) do
    vim.o[key] = value
end

-- consider hyphen part of a word
vim.api.nvim_set_option('iskeyword', vim.api.nvim_get_option 'iskeyword' .. ',-')

vim.filetype.add { extension = { jenkinsfile = 'groovy' } }
