local home = os.getenv 'HOME'
local jdtls = require 'jdtls'
local mason_registry = require 'mason-registry'
local jdtls_package = mason_registry.get_package 'jdtls'
local java_debug_adapter_package = mason_registry.get_package 'java-debug-adapter'

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

-- Helper function for creating keymaps
local function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set('n', rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Regular Neovim LSP client keymappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('gD', vim.lsp.buf.declaration, bufopts, 'Go to declaration')
    nnoremap('gd', vim.lsp.buf.definition, bufopts, 'Go to definition')
    nnoremap('gi', function()
        require('trouble').open 'lsp_implementations'
    end, bufopts, 'Go to implementation')
    nnoremap('gr', function()
        require('trouble').open 'lsp_references'
    end, bufopts, 'Go to references')
    nnoremap('<leader>ds', require('telescope.builtin').lsp_document_symbols, bufopts, '[D]ocument [S]ymbols')
    nnoremap('K', vim.lsp.buf.hover, bufopts, 'Hover text')
    vim.keymap.set({ 'i', 'n' }, '<C-p>', vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = bufnr, desc = 'Show signature' })
    -- nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
    -- nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
    -- nnoremap('<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts, "List workspace folders")
    nnoremap('<leader>D', vim.lsp.buf.type_definition, bufopts, 'Go to type definition')
    nnoremap('<leader>n', vim.lsp.buf.rename, bufopts, 'Rename')
    nnoremap('<A-CR>', vim.lsp.buf.code_action, bufopts, 'Code actions')
    vim.keymap.set('v', '<A-CR>', '<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>', { noremap = true, silent = true, buffer = bufnr, desc = 'Code actions' })
    nnoremap('<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, bufopts, 'Format file')

    -- Java extensions provided by jdtls
    nnoremap('<leader>o', jdtls.organize_imports, bufopts, 'Organize imports')
    nnoremap('<leader>v', jdtls.extract_variable, bufopts, 'Extract variable')
    nnoremap('<leader>i', function()
        require('refactoring').refactor 'Inline Variable'
    end, bufopts, 'Inline variable')
    nnoremap('<leader>ec', jdtls.extract_constant, bufopts, 'Extract constant')
    vim.keymap.set(
        'v',
        '<leader>em',
        [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
        { noremap = true, silent = true, buffer = bufnr, desc = 'Extract method' }
    )
    -- TODO  move this to a more suitable location
    local function attach_to_debug()
        local dap = require 'dap'
        dap.configurations.java = {
            {
                type = 'java',
                request = 'attach',
                name = 'Attach to the process',
                hostName = 'localhost',
                port = '5005',
            },
        }
        dap.continue()
    end

    nnoremap('<leader>da', attach_to_debug, bufopts, 'Debug attach')
end

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    root_dir = root_dir, -- Set the root directory to our found root_marker
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            -- format = {
            --   settings = {
            --     -- Use Google Java style guidelines for formatting
            --     -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
            --     -- and place it in the ~/.local/share/eclipse directory
            --     url = "/.local/share/eclipse/eclipse-java-google-style.xml",
            --     profile = "GoogleStyle",
            --   },
            -- },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    'org.hamcrest.MatcherAssert.assertThat',
                    'org.hamcrest.Matchers.*',
                    'org.hamcrest.CoreMatchers.*',
                    'org.junit.jupiter.api.Assertions.*',
                    'java.util.Objects.requireNonNull',
                    'java.util.Objects.requireNonNullElse',
                    'org.mockito.Mockito.*',
                },
                filteredTypes = {
                    'com.sun.*',
                    'io.micrometer.shaded.*',
                    'java.awt.*',
                    'jdk.*',
                    'sun.*',
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-17',
                        path = home .. '/.sdkman/candidates/java/17.0.9-graal',
                    },
                },
            },
        },
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        home .. '/.sdkman/candidates/java/17.0.9-graal/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        -- -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
        -- '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',

        -- The jar file is located where jdtls was installed. This will need to be updated
        -- to the location where you installed jdtls
        '-jar',
        vim.fn.glob(jdtls_package:get_install_path() .. '/plugins/org.eclipse.equinox.launcher_*.jar'),

        -- The configuration for jdtls is also placed where jdtls was installed. This will
        -- need to be updated depending on your environment
        '-configuration',
        jdtls_package:get_install_path() .. '/config_linux',

        -- Use the workspace_folder defined above to store data for this project
        '-data',
        workspace_folder,
    },
    init_options = {
        bundles = {
            vim.fn.glob(java_debug_adapter_package:get_install_path() .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
        },
    },
}

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)
