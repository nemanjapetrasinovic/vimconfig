set t_Co=256
set t_ut=
set termguicolors
set number
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set expandtab
syntax on
set cursorline
set mouse=

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'neovim/nvim-lspconfig'

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

" LSP Support
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim',          " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional

" Autocompletion
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'L3MON4D3/LuaSnip'     " Required

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'tomtom/tcomment_vim'

Plug 'puremourning/vimspector'
Plug 'EdenEast/nightfox.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'majutsushi/tagbar'
call plug#end()

"Toggle Nerd Tree
nnoremap <C-n> :NERDTreeToggle<CR>

"nnoremap <leader>F :Files<CR>
nnoremap <leader>F <cmd>Telescope find_files<CR>
nnoremap <leader>L <cmd>Telescope buffers<CR>
nnoremap <leader>G <cmd>Telescope git_status<CR>
nnoremap <leader>R <cmd>Telescope live_grep<cr>

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

nnoremap gr :Ggrep <C-R><C-W><CR>
"nnoremap <leader>r :Rg<CR>
"nnoremap <leader>R :Rg <C-R><C-W><CR>

lua <<EOF
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
  }
})
EOF

lua << END
require'lualine'.setup {
    options = { theme = 'nordfox' }
}
END

lua << END
require'nightfox'.setup{palettes = {nordfox = { bg3 = "#39404f" }}}
END

set updatetime=500
autocmd CursorHold * lua vim.diagnostic.open_float({focus = false})

" system clipboard usage in vim (default '+' register)
set clipboard=unnamed
set clipboard=unnamedplus

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Debug
"
nnoremap <silent> D    :call vimspector#Launch()<CR>
nnoremap <silent> db   :call vimspector#ToggleBreakpoint()<CR>
nnoremap <F5>          :call vimspector#Continue()<CR>
nnoremap <F10>         :call vimspector#StepOver()<CR>
nnoremap <F11>         :call vimspector#StepInto()<CR>
nnoremap Č  :

colorscheme nordfox

lua << END
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
}
END
