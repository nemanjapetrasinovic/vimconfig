-- return {
--     {
--         'preservim/nerdtree',
--         name = 'nerdtree',
--         config = function ()
--             vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>')
--         end
--     },
--     { 'Xuyuanp/nerdtree-git-plugin', name = 'nerdtree-git'},
-- }

-- lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
  config = function()
    require("nvim-tree").setup({
      git = {
        enable = true,
        ignore = false, -- show files even if in .gitignore
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      view = {
        width = 35,
        side = "left",
      },
    })

    -- vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>')
    -- Keymaps (adjust to your liking)
    vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
  end,
}

