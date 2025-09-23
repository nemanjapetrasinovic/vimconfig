return {
    {
        'nvim-telescope/telescope.nvim',
        name = 'telescope',
        config = function ()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules" },
                },
            })

            vim.keymap.set('n', '<leader>F', ':Telescope find_files<CR>')
            vim.keymap.set('n', '<leader>L', ':Telescope buffers<CR>')
            vim.keymap.set('n', '<leader>G', ':Telescope git_status<CR>')
            vim.keymap.set('n', '<leader>R', ':Telescope live_grep<CR>')
        end
    }
}

