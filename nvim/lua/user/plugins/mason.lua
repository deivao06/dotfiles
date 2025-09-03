require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true
})

local lspconfig = require("lspconfig")

-- PHP (Laravel)
lspconfig.intelephense.setup{}

-- JavaScript/TypeScript
lspconfig.ts_ls.setup{}

-- ESLint
-- lspconfig.eslint.setup({
--   root_dir = lspconfig.util.root_pattern(
--     ".eslintrc",
--     ".eslintrc.js",
--     ".eslintrc.cjs",
--     "package.json",
--     ".git"
--   ),
-- })

vim.keymap.set('n', '<Leader>m', ':Mason<CR>')
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
