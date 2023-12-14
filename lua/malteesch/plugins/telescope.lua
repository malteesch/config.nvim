return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' }
  },
  config = function (_, opts)
    local t = require('telescope')
    opts.extensions = vim.tbl_extend("force", vim.F.if_nil(opts.extensions, {}), {
      ["ui-select"] = {
        require('telescope.themes').get_dropdown { }
      }
    })
    t.setup(opts)
    pcall(t.load_extension, 'fzf')
    pcall(t.load_extension, 'ui-select')
  end,
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
    pickers = {
      find_files = {
        theme = 'dropdown'
      }
    }
  },
  keys = {
    {'<leader>gf', function() require('telescope.builtin').git_files() end,  desc = 'Search [G]it [F]iles' },
    {'<leader>sf', function() require('telescope.builtin').find_files() end,  desc = '[S]earch [F]iles' },
    {'<leader>sh', function() require('telescope.builtin').help_tags() end,  desc = '[S]earch [H]elp' },
    {'<leader>sw', function() require('telescope.builtin').grep_string() end,  desc = '[S]earch current [W]ord' },
    {'<leader>sg', function() require('telescope.builtin').live_grep() end,  desc = '[S]earch by [G]rep' },
    {'<leader>sd', function() require('telescope.builtin').diagnostics() end,  desc = '[S]earch [D]iagnostics' },
    {'<leader>sr', function() require('telescope.builtin').resume() end,  desc = '[S]earch [R]esume' },
    {'<leader>?', function() require('telescope.builtin').oldfiles() end, desc = '[?] Find recently opened files' },
    {'<leader><space>', function() require('telescope.builtin').buffers() end, desc = '[ ] Find existing buffers' },
    {'<leader>/', function ()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend= 10,
        previewer = false,
      })
    end, desc = '[/] Fuzzily search in current buffer'}
  }
}

