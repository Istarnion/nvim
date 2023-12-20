-- Help command that opens man pages in vertical splits
vim.api.nvim_create_user_command('Help', 'vertical Man <args>', {
    bang = true,
    bar = true,
    addr = 'other',
    nargs = '*',
    complete = function(...) return require('man').man_complete(...) end,
})

-- Install packer if not allready done
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Package manager
    use('wbthomason/packer.nvim')

    use({ -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        }
    })

    use({ -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            -- Completions from the LSP
            'hrsh7th/cmp-nvim-lsp',

            -- Completions from the buffer
            'hrsh7th/cmp-buffer',

            -- Completions from the snippets
            'SirVer/ultisnips',
            'quangnguyen30192/cmp-nvim-ultisnips'
        }
    })

    use({ -- Treesitter: Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    })

    use({ -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    })

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    })

    use('flazz/vim-colorschemes')   -- Make tons of colorschemes available
    use('tpope/vim-surround')       -- Commands to add/remove/change surrounding stuff
    use('tpope/vim-fugitive')       -- git CLI wrapper

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end


-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
        command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
        group = packer_group,
        pattern = vim.fn.expand '$MYVIMRC',
    })

vim.cmd([[
    " UltiSnips config
    inoremap <silent><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
]])

vim.cmd([[
    " Settings for airline statusline
    let g:airline_powerline_fonts=1
    let g:airline_section_x='%r%{getcwd()}%h'
    let g:airline_section_z='%l/%L : %c'
]])

vim.o.completeopt = 'menuone,noselect'

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim', 'glsl' },

    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- Diagnostic keymaps
-- TODO(istarnion): Find good keybindings for these! Seems useful!
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},

    clangd = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
}

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup({
    completion = {
        autocomplete = false,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete({ reason = cmp.ContextReason.Auto })
            end
        end, { 'i' }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
    }),
    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end
    }
})

-- lualine setup
require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'ayu_mirage',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = false,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

