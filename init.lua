vim.cmd 'set t_Co=256'
vim.cmd 'set t_ut='
vim.cmd 'set termguicolors'
vim.cmd 'set number'
vim.cmd 'set list'
vim.cmd [[set listchars=tab:▸\ ,eol:¬,trail:·,space:·]]
vim.cmd 'set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab'
vim.cmd 'set expandtab'
vim.cmd 'syntax on'
vim.cmd 'set cursorline'
vim.g.vimspector_base_dir='/Users/nemanja/.local/share/nvim/lazy/vimspector'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'preservim/nerdtree', name = 'nerdtree' },
    { 'Xuyuanp/nerdtree-git-plugin', name = 'nerdtree-git'},
    { 'nvim-lualine/lualine.nvim', name = 'lua-line' },
    { 'kyazdani42/nvim-web-devicons', name = 'nvim-web-devicons' },
    { 'tpope/vim-fugitive', name = 'vim-fugitive' },
    { 'nvim-lua/plenary.nvim', name = 'plenary' },
    { 'nvim-telescope/telescope.nvim', name = 'telescope' },
    { 'tomtom/tcomment_vim', name = 'tcomment' },
    { 'puremourning/vimspector', name = 'vimspector' },
    { 'majutsushi/tagbar', name = 'tagbar' },
    { 'EdenEast/nightfox.nvim', name = 'nightfox' },
    { 'nvim-treesitter/nvim-treesitter', name = 'treesitter', build = ":TSUpdate" },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    },
    {
        'mrcjkb/rustaceanvim', version = '^4', lazy = false
    },
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
                -- Optionally disable cmp source if using virtual text only
                enable_cmp_source = false,
                virtual_text = {
                    enabled = true,

                    -- These are the defaults

                    -- Set to true if you never want completions to be shown automatically.
                    manual = false,
                    -- A mapping of filetype to true or false, to enable virtual text.
                    filetypes = {},
                    -- Whether to enable virtual text of not for filetypes not specifically listed above.
                    default_filetype_enabled = true,
                    -- How long to wait (in ms) before requesting completions after typing stops.
                    idle_delay = 75,
                    -- Priority of the virtual text. This usually ensures that the completions appear on top of
                    -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
                    -- desired.
                    virtual_text_priority = 65535,
                    -- Set to false to disable all key bindings for managing completions.
                    map_keys = true,
                    -- The key to press when hitting the accept keybinding but no completion is showing.
                    -- Defaults to \t normally or <c-n> when a popup is showing. 
                    accept_fallback = nil,
                    -- Key bindings for managing completions in virtual text mode.
                    key_bindings = {
                        -- Accept the current completion.
                        accept = "<Tab>",
                        -- Accept the next word.
                        accept_word = false,
                        -- Accept the next line.
                        accept_line = false,
                        -- Clear the virtual text.
                        clear = false,
                        -- Cycle to the next completion.
                        next = "<M-]>",
                        -- Cycle to the previous completion.
                        prev = "<M-[>",
                    }
                }
            })
        end
    },
})

require('rose-pine').setup({ disable_italics = true, })
vim.cmd 'colorscheme rose-pine-moon'

-- Toggle Nerd Tree
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>')

-- Telescope mapping
vim.keymap.set('n', '<leader>F', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>L', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>G', ':Telescope git_status<CR>')
vim.keymap.set('n', '<leader>R', ':Telescope live_grep<CR>')

-- Ggrep
vim.keymap.set('n', 'gr', ':Ggrep <C-R><C-W><CR>')

-- Tagbar
vim.keymap.set('n', '<C-T>', ':TagbarToggle<CR>', { silent = true})

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "rust", "javascript", "typescript", "vimdoc", "comment" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    }
}

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    }
})

vim.cmd 'set updatetime=300'
vim.cmd 'autocmd CursorHold * lua vim.diagnostic.open_float({focus = false})'

-- Vimspector
vim.cmd([[
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F10> <cmd>call vimspector#StepOver()<cr>")
nmap <F11> <cmd>call vimspector#StepInto()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap "Db" <cmd>call vimspector#ToggleBreakpoint()<cr>")
]])
vim.keymap.set('n', 'Db', ':call vimspector#ToggleBreakpoint()<CR>')
vim.keymap.set('n', 'Dw', ':call vimspector#AddWatch()<CR>')
vim.keymap.set('n', 'De', ':call vimspector#Evaluate()<CR>')

require('codeium.virtual_text').status_string()
-- vim.opt.statusline:append(" %3{%v:lua.require'codeium.virtual_text'.status_string()%}")
require('codeium.virtual_text').set_statusbar_refresh(function()
    require('lualine').refresh()
end)

require'lualine'.setup {
    sections = {
        lualine_c = {
            {
                'filename',
                file_status = true,
                newfile_status = false,
                path = 1,
                shorting_target = 40,
                symbols = {
                    modified = '[+]',
                    readonly = '[-]',
                    unnamed = '[No Name]',
                    newfile = '[New]',
                }
            }
        },
        lualine_x = {
            'encoding', 'fileformat', 'filetype',
            function()
                return require('codeium.virtual_text').status_string()
            end
        },
    }
}
