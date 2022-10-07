return {
    packer = {
        "kyazdani42/nvim-tree.lua",
    },
    api = {
        "kyazdani42/nvim-web-devicons",
    },
    data = function()
        return require("nvim-tree")
    end,
    exec = function(root)
        vim.o.visualbell = false -- Remove some annoying sounds when typing.
        vim.o.autochdir = true -- Set directory to the current file's directory automatically.
        vim.opt.path:append({ "**" }) -- Search files down into subfolders as well.
        vim.opt.wildignore:append({
            "*/node_modules/*",
            "*/target/release/*",
            "*/target/debug/*",
            "*/.git/*",
            "*/.gradle/*",
        })
        vim.g.loaded = 1
        vim.g.loaded_netrwPlugin = 1
        root.setup({
            view = {
                side = "left",
            },
            filters = {
                custom = { "^.git$" },
            },
        })
    end,
}