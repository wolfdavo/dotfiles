-- Core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.o.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.o.showtabline = 2 -- always show tabs
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.iskeyword:append '-' -- hyphenated words recognized by searches
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- separate vim plugins from neovim in case vim still in use
vim.opt.laststatus = 3 -- views can only be fully collapsed with the global statusline
