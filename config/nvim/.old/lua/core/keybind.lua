--     __ __         __   _         ___
--    / //_/__ __ __/ /  (_)__  ___/ (_)__  ___ ____
--   / ,< / -_) // / _ \/ / _ \/ _  / / _ \/ _ `(_-<
--  /_/|_|\__/\_, /_.__/_/_//_/\_,_/_/_//_/\_, /___/
--           /___/                        /___/

local map = require("util.map")

-- Sugar
----------------------------------------------------------------------------------
-- Keybindings usually made to be similar to other text editors and to be simpler.

vim.g.mapleader = "," -- Set the global leader key.

map.set("n", "<C-s>", map.cmd("update!")) -- Save the current file by using the Ctrl+S.
map.set("v", "<C-s>", map.cmd("update!"))
map.set("i", "<C-s>", map.cmd("update!"))
map.set("i", "<S-Tab>", "<C-d>")
map.set("v", "<Tab>", ">gv")
map.set("v", "<S-Tab>", "<gv")
map.set("v", "<C-_>", "gcc")
map.set("n", "<C-_>", "gcc")
map.set("i", "<C-_>", "<Esc>gcc")

-- Barbar
----------------------------------------------------------------------------------
-- Keybindings related to the tabline plugin.

map.set("n", "<A-,>", map.cmd("BufferPrevious")) -- Switch to the previous tab.
map.set("n", "<A-.>", map.cmd("BufferNext")) -- Switch to the next tab.
for tab = 1, 9 do
    map.set("n", "<A-" .. tab .. ">", map.cmd("BufferGoto " .. tab)) -- Switch to the tab at index n.
end
map.set("n", "<A-0>", map.cmd("BufferLast")) -- Switch to the last tab.
map.set("n", "<C-x>", map.cmd("BufferClose")) -- Quit the current file by using the Ctrl+X.

-- Telescope
----------------------------------------------------------------------------------
-- Keybindings related to the telescope plugin.

map.set("n", "<C-o>", map.cmd("Telescope file_browser")) -- Open a file browser window.
map.set("n", "<C-p>", map.cmd("Telescope find_files")) -- Open a file finding window.
map.set("n", "<leader>fg", map.cmd("Telescope live_grep")) -- Open a live grep window.
map.set("n", "<C-S-p>", map.cmd("Telescope buffers")) -- Open a buffers window.

-- nvim-tree.lua
----------------------------------------------------------------------------------
-- Keybindings related to the file tree.

map.set("n", "<leader>t", map.cmd("NvimTreeToggle")) -- Toggle the file tree.
map.set("n", "<S-Tab>", map.cmd("wincmd p")) -- Change the focus to the file tree.

-- LSP
----------------------------------------------------------------------------------
-- Keybindings related to the LSP or completion stuff.

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<C-b>", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "<C-S-b>", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<C-S-f>", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<C-S-i>", vim.lsp.buf.formatting, bufopts)
end

return {
    on_attach = on_attach,
}