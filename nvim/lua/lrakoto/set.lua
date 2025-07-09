vim.cmd.colorscheme("tokyonight-day")

vim.opt.clipboard = 'unnamedplus' -- use system keyboard for yank

vim.opt.nu = true                 -- set line numbers -- set line numbers
vim.opt.relativenumber = true     -- use relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.conceallevel = 1

vim.opt.list = true
vim.opt.listchars = {eol='¬',tab='>~',trail='~',extends='>',precedes='<',space='␣' }

vim.opt.wrap = false

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true
vim.opt.cursorline = true


vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:4"  -- Indent wrapped lines by 4 spaces
vim.opt.showbreak = "    "  -- Space before wrapped lines

vim.cmd([[
  highlight CursorLine cterm=NONE ctermbg=DarkGray guibg=#9fb0b5
]])

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]])
