-- MASON
require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

-- CMP
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- CAPABILITIES
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-----------------------------------------------------------------------
-- NOVO SISTEMA DO LSP (Neovim 0.11+)
-- Agora usamos vim.lsp.config.<server> = { ... }
-- E iniciamos via vim.lsp.start(...)
-----------------------------------------------------------------------

-- PHP (Intelephense)
vim.lsp.config["intelephense"] = {
  capabilities = capabilities,
}

-- TypeScript / JavaScript (tsserver novo nome: ts_ls)
vim.lsp.config["ts_ls"] = {
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
}

-- ESLint
vim.lsp.config["eslint"] = {
  capabilities = capabilities,
  root_dir = function(fname)
    return vim.fs.root(fname, {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      "package.json",
      ".git",
    })
  end,
}

-- Vue (Volar)
vim.lsp.config["volar"] = {
  capabilities = capabilities,
  filetypes = { "vue" },
  init_options = {
    typescript = {
      tsdk = vim.fn.stdpath("data")
        .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
}

-----------------------------------------------------------------------
-- AUTOSTART (iniciar LSP automaticamente para o buffer atual)
-----------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    local config = vim.lsp.config[vim.bo.filetype]
    if config then
      vim.lsp.start(config)
    end
  end,
})

-----------------------------------------------------------------------
-- DIAGNOSTICS
-----------------------------------------------------------------------

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-----------------------------------------------------------------------
-- KEYMAPS (globais, independentes de bufnr)
-----------------------------------------------------------------------

vim.keymap.set("n", "<Leader>m", ":Mason<CR>")
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)
