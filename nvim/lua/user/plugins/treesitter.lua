require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "json",
        "php",
        "html",
        "css",
        "scss",
        "vue",
    },
    highlight = { enable = true }
})
