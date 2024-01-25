local servers = {
    -- clangd = {},
    gopls = {},
    pyright = {},
    rust_analyzer = {},
    -- tsserver = {},
    html = {
        filetypes = { 'html', 'templ' },
    },

    yamlls = {
        yaml = {
            schemas = {
                ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '/pipeline-support/*.yml',
            },
        },
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
                globals = { 'P' }
            }
        },
    },
    jdtls = {},
    groovyls = {},
    tsserver = {},
    eslint = {},
    templ = {},
    tailwindcss = {
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } }
    },
    htmx = {
        filetypes = { 'html', 'templ' },
    }
}

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>n', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<A-CR>', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-p>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP', buffer = bufnr })
    vim.keymap.set('x', '<leader>v', function()
        require('refactoring').refactor 'Extract Variable'
    end, { desc = 'Extract variable', buffer = bufnr })
    vim.keymap.set({ 'n', 'x' }, '<leader>i', function()
        require('refactoring').refactor 'Inline Variable'
    end)
end

return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = {
                { 'williamboman/mason.nvim', opts = {} },
            },
            opts = {},
        },

        'j-hui/fidget.nvim',

        -- Additional lua configuration, makes nvim stuff amazing!
        { 'folke/neodev.nvim', opts = {} },
        'hrsh7th/cmp-nvim-lsp',
        'refactoring',
    },
    init = function()
        vim.filetype.add { extension = { templ = 'templ' } }
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                    init_options = (servers[server_name] or {}).init_options,
                }
            end,
            jdtls = function(server_name)
                require('lspconfig')[server_name].setup {
                    autostart = false,
                }
            end,
        }
    end,
}
