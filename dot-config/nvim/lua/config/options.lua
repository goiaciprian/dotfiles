local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.wrap = false

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.updatetime = 250
opt.timeoutlen = 300
opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache").."/undo"

opt.termguicolors = true
opt.background = "dark"

-- opt.list = true
-- opt.listchars = { tab = ">> ", trail = ".", nbsp = "␣" }

if vim.fn.has("win32") == 1 then
  -- Setează calea către executabilul PowerShell
  opt.shell = "pwsh.exe"

  -- Configurează argumentele necesare pentru ca PowerShell să ruleze corect în Neovim
end
