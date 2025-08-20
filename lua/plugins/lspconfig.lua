return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Minimal on_attach function for keymaps
            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end
                    vim.api.nvim_buf_set_keymap(bufnr, "n", keys, "", {callback = func, desc = desc, noremap = true, silent = true})
                end

                -- Minimal keymaps
                nmap("gd", vim.lsp.buf.definition, "Go to Definition")
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                nmap("gr", vim.lsp.buf.references, "References")
                nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
            end

            -- Setup ts_ls
            lspconfig.ts_ls.setup({
                on_attach = on_attach,
            })
            -- Setup luals
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = {"vim"},
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end
    }
}

