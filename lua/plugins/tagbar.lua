return {
    {
        'majutsushi/tagbar',
        name = 'tagbar',
        config = function ()
            vim.keymap.set('n', '<C-T>', ':TagbarToggle<CR>', { silent = true})
        end
    },
}
