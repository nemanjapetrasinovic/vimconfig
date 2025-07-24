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

vim.keymap.set('n', 'gr', ':Ggrep <C-R><C-W><CR>')

vim.lsp.enable({'clangd', 'luals'})

vim.cmd 'set updatetime=300'
vim.cmd 'autocmd CursorHold * lua vim.diagnostic.open_float({focus = false, close_events = { "BufLeave", "CursorMoved", "InsertEnter" }})'

require("config.lazy")
