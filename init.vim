set t_Co=256
set t_ut=
set number
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set expandtab
syntax on

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'neovim/nvim-lspconfig'

Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'kien/rainbow_parentheses.vim'
call plug#end()

"Toggle Nerd Tree
nnoremap <C-n> :NERDTreeToggle<CR>

colorscheme onehalfdark
let g:airline_theme='onehalfdark'
let g:airline#extensions#tabline#enabled = 1

nnoremap <leader>F :Files<CR>
nnoremap <leader>L :Buffers<CR>
nnoremap <leader>G :GFiles?<CR>

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

nnoremap gr :Rg <cword><CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>R :Rg <cword><CR>

lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF
