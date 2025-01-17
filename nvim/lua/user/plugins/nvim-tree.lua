require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  view = {
    width = 50
  },
  renderer = {
    group_empty = false,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  filters = {
    dotfiles = false,
  }
})

vim.keymap.set('n', '<Leader>e', ':NvimTreeFindFileToggle<CR>')
