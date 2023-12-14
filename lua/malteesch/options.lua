local globalOptions = {
  mapleader = ' ',
  maplocalleader = ' '
}

local windowOptions = {
  relativenumber = true,
  number = true
}

local options = {
  hlsearch = false,
  mouse = 'a',
  clipboard = 'unnamedplus',
  breakindent = true,
  undofile = true,
  -- Case-insensitive searching UNLESS \C or capital in search
  ignorecase = true,
  smartcase = true,
  -- Keep signcolumn on by default
  signcolumn = 'yes',
  -- Decrease update time
  updatetime = 250,
  timeoutlen = 250,
  -- Set completeopt to have a better completion experience
  completeopt = 'menuone,noselect',
  termguicolors = true,
  wrap = false,
  sidescroll = 10,
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
