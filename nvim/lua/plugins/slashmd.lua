-- SlashMD: Notion-style block-based Markdown editing
-- Local development version pointing to the monorepo

return {
  dir = '/Users/davidwolfenden/Dev/SlashMD/packages/neovim-plugin',
  name = 'slashmd',
  ft = { 'markdown', 'markdown.mdx' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('slashmd').setup {
      auto_enable = true,
      features = {
        slash_menu = true,
        block_navigation = true,
        conceal = true,
        icons = true,
        images = 'none',
        auto_pairs = true,
        diagnostics = true,
        smart_enter = true,
      },
    }
  end,
}
