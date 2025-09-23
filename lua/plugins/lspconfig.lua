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

                vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, {
                        -- true: update diagnostics in insert mode
                        update_in_insert = true,
                    }
                )

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

            local lspconfig = require('lspconfig')

            -- Setup gopls
            lspconfig.gopls.setup {
                cmd = {"gopls"},
                filetypes = {"go", "gomod", "gowork", "gotmpl"},
                root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            }

            require('lspconfig').solidity_ls_nomicfoundation.setup{
                -- Optional: customize settings
                settings = {
                    solidity = {
                        includePath = '',
                        remapping = {},
                    }
                },
                -- Optional: specify filetypes if needed
                filetypes = { 'solidity' },
            }

        end
    }
}

