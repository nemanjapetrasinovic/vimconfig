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

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'neovim/nvim-lspconfig'

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

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

let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

lua << EOF
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.vuels.setup{}
require'lspconfig'.eslint.setup{}
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
autocmd CursorHold * lua vim.diagnostic.open_float()

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
  ensure_installed = { "c", "lua", "rust", "javascript", "typescript" },

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
