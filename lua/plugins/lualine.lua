return {
    {
        'nvim-lualine/lualine.nvim',
        name = 'lua-line',
        config = function ()
            require'lualine'.setup {
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            newfile_status = false,
                            path = 1,
                            shorting_target = 40,
                            symbols = {
                                modified = '[+]',
                                readonly = '[-]',
                                unnamed = '[No Name]',
                                newfile = '[New]',
                            }
                        }
                    }
                }
            }
        end
    }
}
