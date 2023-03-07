set t_Co=256
set t_ut=
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

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'tpope/vim-fugitive'

"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kien/rainbow_parentheses.vim'

Plug 'tomtom/tcomment_vim'

Plug 'puremourning/vimspector'
Plug 'EdenEast/nightfox.nvim'
call plug#end()

"Toggle Nerd Tree
nnoremap <C-n> :NERDTreeToggle<CR>

colorscheme nordfox
let g:airline_theme='onehalfdark'
let g:airline#extensions#tabline#enabled = 1

"nnoremap <leader>F :Files<CR>
nnoremap <leader>F <cmd>Telescope find_files<CR>
nnoremap <leader>L <cmd>Telescope buffers<CR>
nnoremap <leader>G <cmd>Telescope git_files<CR>

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

nnoremap gr :Ggrep <C-R><C-W><CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>R :Rg <C-R><C-W><CR>

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
