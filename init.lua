vim.cmd 'set t_Co=256'
vim.cmd 'set t_ut='
vim.cmd 'set termguicolors'
vim.cmd 'set number'
vim.cmd 'set list'
vim.cmd [[set listchars=tab:▸\ ,eol:¬,trail:·]]
vim.cmd 'set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab'
vim.cmd 'set expandtab'
vim.cmd 'syntax on'
vim.cmd 'set cursorline'
vim.cmd 'set mouse='

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
  }
})

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

require'lualine'.setup()

vim.cmd 'set updatetime=300'
vim.cmd 'autocmd CursorHold * lua vim.diagnostic.open_float({focus = false})'
