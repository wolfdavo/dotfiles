-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = vim.fn.argc(-1) == 0,
    cmd = { 'TSInstall', 'TSUpdate', 'TSUpdateSync' },
    init = function()
      -- Register additional file extensions
      vim.filetype.add { extension = { tf = 'terraform' } }
      vim.filetype.add { extension = { tfvars = 'terraform' } }
    end,
    config = function()
      -- Install parsers
      require('nvim-treesitter').setup {
        ensure_installed = {
          'lua',
          'python',
          'javascript',
          'typescript',
          'vimdoc',
          'vim',
          'regex',
          'terraform',
          'sql',
          'dockerfile',
          'toml',
          'json',
          'java',
          'go',
          'gitignore',
          'graphql',
          'yaml',
          'make',
          'cmake',
          'markdown',
          'markdown_inline',
          'bash',
          'tsx',
          'css',
          'html',
        },
        auto_install = true,
      }

      -- Enable highlight and indent via vim.treesitter
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Incremental selection keymaps
      vim.keymap.set('n', '<c-space>', function()
        require('nvim-treesitter.incremental_selection').init_selection()
      end, { desc = 'Start incremental selection' })
      vim.keymap.set('x', '<c-space>', function()
        require('nvim-treesitter.incremental_selection').node_incremental()
      end, { desc = 'Increment selection' })
      vim.keymap.set('x', '<c-s>', function()
        require('nvim-treesitter.incremental_selection').scope_incremental()
      end, { desc = 'Increment scope' })
      vim.keymap.set('x', '<M-space>', function()
        require('nvim-treesitter.incremental_selection').node_decremental()
      end, { desc = 'Decrement selection' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'
      local select = require 'nvim-treesitter-textobjects.select'
      local swap = require 'nvim-treesitter-textobjects.swap'

      -- Textobject selection
      local select_keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
      for keymap, query in pairs(select_keymaps) do
        vim.keymap.set({ 'x', 'o' }, keymap, function()
          select.select_textobject(query, 'textobjects', nil, { lookahead = true })
        end)
      end

      -- Movement keymaps
      vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
        ts_repeat_move.repeat_last_move_next()
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
        ts_repeat_move.repeat_last_move_previous()
      end)

      -- Goto next/prev function
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
      end, { desc = 'Next function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
      end, { desc = 'Previous function end' })

      -- Goto next/prev class
      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
      end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
      end, { desc = 'Previous class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
      end, { desc = 'Next class end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
      end, { desc = 'Previous class end' })

      -- Swap parameters
      vim.keymap.set('n', '<leader>a', function()
        swap.swap_next('@parameter.inner', 'textobjects')
      end, { desc = 'Swap next parameter' })
      vim.keymap.set('n', '<leader>A', function()
        swap.swap_previous('@parameter.inner', 'textobjects')
      end, { desc = 'Swap previous parameter' })
    end,
  },
}
