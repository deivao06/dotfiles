require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true
})

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Para snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter confirma
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' }
  })
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- PHP (Laravel)
lspconfig.intelephense.setup({
    capabilities = capabilities,
})

-- JavaScript/TypeScript
lspconfig.ts_ls.setup({
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    },
})

-- ESLint
lspconfig.eslint.setup({
  root_dir = lspconfig.util.root_pattern(
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    "package.json",
    ".git"
  ),
})

-- Vue (Volar)
lspconfig.volar.setup({
    filetypes = { "vue" },
    init_options = {
        typescript = {
            tsdk = vim.fn.stdpath("data") ..
                "/mason/packages/typescript-language-server/node_modules/typescript/lib"
        },
    },
})

vim.keymap.set('n', '<Leader>m', ':Mason<CR>')
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
