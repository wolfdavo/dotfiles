
-- ~/.config/nvim/init.lua
-- Super minimal Lazy.nvim-based Neovim config

-- Set leader to space early
vim.g.mapleader = " "

-- Core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- Keymaps
local keymap = vim.keymap.set
keymap("n", "<Esc><Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    priority = 1000,
    config = function()
      require("onedark").setup {
        style = "darker"
      }
      require("onedark").load()

    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic"
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
        lspconfig.tsserver = nil  -- kill the deprecated alias
        lspconfig.ts_ls.setup({})
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
    end
  }
})

-- Smooth faster scrolling with j/k
local neoscroll = require("neoscroll")

keymap("n", "<C-j>", function()
  neoscroll.scroll(10, { move_cursor = true, duration = 100, easing = "quadratic" })  -- scroll 5 lines down over 100ms
end, { desc = "Smooth scroll down" })

keymap("n", "<C-k>", function()
  neoscroll.scroll(-10, { move_cursor = true, duration = 100, easing = "quadratic" })  -- scroll 5 lines up over 100ms
end, { desc = "Smooth scroll up" })
