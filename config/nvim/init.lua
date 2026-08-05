-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- interface
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "88"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.statusline = "[%{mode()}] %f %m %= %l:%c "
vim.opt.cmdheight = 0

-- open splits on the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- keys
vim.g.mapleader = " "

-- switch between buffers with Tab / S+Tab
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- rebind move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- BufOnly command that closes all buffers except current
require("config.bufonly").setup()
vim.keymap.set("n", "<leader>w", "<cmd>BufOnly<CR>", {
    desc = "Close all buffers except current"
})

-- code folding
require("config.codefolding").setup()

-- netrw
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.path:append("**")

-- colorscheme
local theme = require("config.theme")
theme.setup()

-- keep autocmds organized and avoid duplicates when reloading the config
local config_group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- custom configuration of tabs etc for different filetypes

-- use real tabs in Makefiles
vim.api.nvim_create_autocmd("FileType", {
    group = config_group,
    pattern = "make",
    callback = function(event)
        vim.bo[event.buf].expandtab = false
    end,
})

-- use two-space indentation for some filetypes (web, rust, protobuf)
vim.api.nvim_create_autocmd("FileType", {
    group = config_group,
    pattern = {
        "html",
        "proto",
        "javascript",
        "css",
        "typescript",
        "rust",
    },
    callback = function(event)
        vim.bo[event.buf].shiftwidth = 2
        vim.bo[event.buf].softtabstop = 2
        vim.bo[event.buf].expandtab = true
    end,
})

-- plugins

-- preview colors
vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
require("colorizer").setup({
    options = {
        parsers = { names = { enable = false } },
        display = {
            mode = "virtualtext",
            virtualtext = {
                char = "●",
                hl_mode = "foreground",
                position = "after",
            },
        },
    },
})

vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })
require("bufferline").setup()

-- lualine
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = theme.lualine,
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
    disabled_filetypes = { statusline = {}, winbar = {} },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {"filename"},
    lualine_x = {"filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
})

-- lsp config
require("config.lsp").setup()
