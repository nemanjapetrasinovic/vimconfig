return {
    { 'mrcjkb/rustaceanvim', version = '^6', lazy = false },
    { 'tpope/vim-fugitive', name = 'vim-fugitive' },
    { 'tomtom/tcomment_vim', name = 'tcomment' },
    { 'nvim-treesitter/nvim-treesitter', name = 'treesitter', build = ":TSUpdate" },
    { "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
}
