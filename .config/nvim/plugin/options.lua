local opt = vim.opt

-- Debug
-- vim.opt.debug = "msg"

-- Unicode chars of ambiguous width use twice the width of ASCII characters.
-- conflict with gitsigns
-- opt.ambiwidth = "double"

-- Keep backup file after overwriting a file
opt.backup = true
opt.backupdir = os.getenv("XDG_STATE_HOME") .. "/nvim/backup//"

-- Make line numbers default
opt.number = true

-- Relative line numbers.
opt.relativenumber = true

-- Enable mouse mode.
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line.
opt.showmode = false

-- Enable break indent.
opt.breakindent = true

-- Save undo history.
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default.
opt.signcolumn = "yes"

-- Decrease update time.
opt.updatetime = 250

-- Decrease mapped sequence wait time.
opt.timeoutlen = 300

-- Configure how new splits should be opened.
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live.
opt.inccommand = "split"

-- Show which line your cursor is on.
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 9
