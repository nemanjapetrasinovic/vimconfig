return {
    {
        'preservim/nerdtree',
        name = 'nerdtree',
        config = function ()
            vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>')
        end
    },
    { 'Xuyuanp/nerdtree-git-plugin', name = 'nerdtree-git'},
}
