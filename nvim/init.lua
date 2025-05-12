require 'core.options'
require 'core.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- pull from the environment your shell spawned Neovim with
local key = os.getenv 'OPENAI_API_KEY' or vim.fn.getenv 'OPENAI_API_KEY'

if not key or key == '' then
  -- warn you early if you forgot to `export` it in zsh
  vim.notify('⚠️  OPENAI_API_KEY is not set in your shell environment!', vim.log.levels.WARN)
else
  -- make sure any plugin or LSP that reads vim.env sees it
  vim.env.OPENAI_API_KEY = key
end

-- vim.notify('OPENAI_API_KEY: ' .. tostring(vim.env.OPENAI_API_KEY), vim.log.levels.WARN)

-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  require 'plugins.colortheme',
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.autoformatting',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.misc',
  require 'plugins.avante',
}
