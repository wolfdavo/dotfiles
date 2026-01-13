-- Claude Code IDE integration
-- Uses WebSocket to communicate with Claude Code CLI (works with external terminals like tmux)
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {},
  },
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      require('claudecode').setup({
        -- Use "none" provider since we run Claude in external tmux pane
        -- This starts the WebSocket server but doesn't create embedded terminal
        terminal = {
          provider = 'none',
        },
        -- Auto-start the WebSocket server when NeoVim opens
        auto_start = true,
        -- Log level for debugging (change to "debug" if troubleshooting)
        log_level = 'warn',
        -- Diff view settings
        diff = {
          auto_close_on_accept = true,
          vertical_split = true,
        },
      })

      -- Keymaps for Claude Code integration
      local wk = require('which-key')
      wk.add({
        { '<leader>cc', group = 'Claude Code' },
        { '<leader>cca', ':ClaudeCodeAdd<CR>', desc = 'Add current file to context' },
        { '<leader>ccs', ':ClaudeCodeSend<CR>', desc = 'Send selection to Claude', mode = 'v' },
        { '<leader>ccd', ':ClaudeCodeDiffAccept<CR>', desc = 'Accept diff' },
        { '<leader>ccD', ':ClaudeCodeDiffDeny<CR>', desc = 'Deny diff' },
      })
    end,
  },
}
