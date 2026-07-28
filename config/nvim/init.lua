-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Interface
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "88"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.statusline = "[%{mode()}] %f %m %= %l:%c "
vim.opt.cmdheight = 0

-- Open splits on the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keys
vim.g.mapleader = " "

-- Switch between buffers with Tab / S+Tab
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- BufOnly command that closes all buffers except current
vim.api.nvim_create_user_command("BufOnly", function()
    local current = vim.api.nvim_get_current_buf()

    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
         if buffer ~= current and vim.bo[buffer].buflisted then
            vim.api.nvim_buf_delete(buffer, { force = false })
        end
    end
end, {
    desc = "Delete all listed buffers except the current one",
})
vim.keymap.set("n", "<leader>w", "<cmd>BufOnly<CR>", {
    desc = "Close all buffers except current"
})

-- Rebind move between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Code folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.foldenable = true
        vim.opt_local.foldlevel = 99
    end,
})

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "0"

-- Colorscheme
vim.opt.background = "dark"

local colors = {
    -- background
    bg = "None",
    bg_highlight = "#0a0b16",
    bg_bright = "#1a1b33",
    -- text
    fg = "#d0daf5",
    fg_status = "#828BB8",
    fg_inactive = "#323B78",
    muted = "#363f59",
    highlight = "#ff9e64",
    -- code colors
    comment = "#464f69",
    number = "#fab387",
    string = "#94e2d5",
    class = "#fab387",
    keyword = "#cba6f7",
    func = "#89b4fa",
    -- text colors
    h1 = "#5E46FF",
    h2 = "#E500FF",
    h3 = "#442E76",
    -- lualine
    normal = "#7287fd",
}

local function set_style(name, style)
    vim.api.nvim_set_hl(0, name, style)
end

local function apply_custom_colors()
    -- Editor text and background
    set_style("Normal", { fg = colors.fg, bg = colors.bg })

    -- Background of inactive windows
    set_style("NormalNC", { fg = colors.fg, bg = colors.bg })

    set_style("StatusLine", { fg = colors.fg_status, bg = colors.bg_highlight })
    set_style("StatusLineNC", { fg = colors.fg_inactive, bg = colors.bg })

    -- Column configured by vim.opt.colorcolumn
    set_style("ColorColumn", { bg = colors.bg_highlight })

    -- Regular line numbers
    set_style("LineNr", { fg = colors.muted, bg = colors.bg })

    -- Current line number
    set_style("CursorLineNr", { fg = colors.highlight, bg = colors.bg_highlight })

    -- Current line background
    set_style("CursorLine", { bg = colors.bg_highlight })

    -- Keep side columns consistent with the background
    set_style("SignColumn", {  bg = colors.bg })

    set_style("EndOfBuffer", { fg = colors.muted, bg = colors.bg })
    set_style("WinSeparator", { fg = colors.bg_highlight, bg = colors.bg })
    set_style("MsgArea", { fg = colors.fg_status, bg = colors.bg_highlight })

    -- Code highlights
    set_style("Comment", { fg = colors.comment })
    set_style("@comment", { link = "Comment" })

    set_style("@variable", { fg = colors.fg })
    set_style("@variable.member", { link = "@variable" })
    set_style("PreProc", { link = "@variable" })
    set_style("@property", { link = "@variable" })

    set_style("Constant", { fg = colors.number })
    set_style("@number", { link = "Constant" })
    set_style("@boolean", { link = "Constant" })
    set_style("Keyword", { fg = colors.keyword })
    set_style("Statement", { link = "Keyword" })
    set_style("Conditional", { link = "Keyword" })
    set_style("Repeat", { link = "Keyword" })
    set_style("Exception", { link = "Keyword" })
    set_style("Include", { link = "Keyword" })
    set_style("@function", { fg = colors.func })
    set_style("Function", { link = "@function" })
    set_style("Special", { link = "@function" })
    set_style("Type", { fg = colors.class })
    set_style("Typedef", { fg = colors.class })
    set_style("@string", { fg = colors.string })
    -- brackets
    set_style("MatchParen", { fg = colors.highlight, bg = colors.bg })
    -- Markdown
    set_style("Title", { fg = colors.h1, bold = true })
    set_style("@markup.heading.2.markdown", { fg = colors.h2, bold = false })
    set_style("@markup.heading.3.markdown", { fg = colors.string, bold = true })
end

apply_custom_colors()
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_custom_colors })

-- Keep autocmds organized and avoid duplicates when reloading the config
local config_group = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Custom configuration of tabs etc for different filetypes

-- Use real tabs in Makefiles
vim.api.nvim_create_autocmd("FileType", {
    group = config_group,
    pattern = "make",
    callback = function(event)
        vim.bo[event.buf].expandtab = false
    end,
})

-- Use two-space indentation for some filetypes (web, rust, protobuf)
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

-- Plugins
vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })
require("colorizer").setup({
    options = {
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
require("bufferline").setup({})

-- Lualine
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
local lualine_theme = {
    normal = {
        a = { fg = colors.normal, bg = colors.bg_bright },
        b = { fg = colors.fg_status, bg = colors.bg },
        c = { fg = colors.fg_status, bg = colors.bg },
    },
    insert = {
        a = { fg = colors.highlight, bg = colors.bg_bright },
        b = { fg = colors.fg_status, bg = colors.bg },
        c = { fg = colors.fg_status, bg = colors.bg },
    },
    visual = {
        a = { fg = colors.h2, bg = colors.bg_bright },
        b = { fg = colors.fg_status, bg = colors.bg },
        c = { fg = colors.fg_status, bg = colors.bg },
    },
    replace = {
        a = { fg = colors.h1, bg = colors.bg_bright },
        b = { fg = colors.fg_status, bg = colors.bg },
        c = { fg = colors.fg_status, bg = colors.bg },
    },
    command = {
        a = { fg = colors.h3, bg = colors.bg_bright },
        b = { fg = colors.fg_status, bg = colors.bg },
        c = { fg = colors.fg_status, bg = colors.bg },
    },
    inactive = {
        a = { fg = colors.fg_status, bg = colors.bg },
        b = { fg = colors.fg_status, bg = colors.bg },
        c = { fg = colors.fg_status, bg = colors.bg },
    },
}
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = lualine_theme,
    component_separators = { left = "", right = ""},
    section_separators = { left = "", right = ""},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
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

-- :Nolsp command

-- This preserves the behavior of the old command: it disables diagnostics,
-- but does not actually stop the LSP client.
vim.api.nvim_create_user_command("Nolsp", function()
    vim.diagnostic.enable(false, { bufnr = 0 })
end, {
    desc = "Disable diagnostics for the current buffer",
})
vim.api.nvim_create_user_command("Lsp", function()
    vim.diagnostic.enable(true, { bufnr = 0 })
end, {
    desc = "Disable diagnostics for the current buffer",
})

vim.lsp.enable({ "ruff", "ty"})

vim.opt.completeopt = {
    "menuone",
    "noselect",
    "popup",
}

local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", {
    clear = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,

    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end


        -- Let ty provide normal Python hover information.
        -- Ruff hover is mainly useful for Ruff rule documentation.
        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end

        -- Enable Neovim's built-in LSP completion for ty.
        if client.name == "ty"

            and client:supports_method("textDocument/completion")
        then
            vim.lsp.completion.enable(
                true,
                client.id,
                event.buf,
                {
                    autotrigger = false,
                }
            )
        end
    end,
})

local function has_words_before()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    if col == 0 then
        return false
    end

    local line = vim.api.nvim_buf_get_lines(
        0,
        row - 1,
        row,
        true
    )[1]

    return line:sub(col, col):match("%s") == nil
end

vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        -- Select the next completion item
        return "<C-n>"
    end

    if has_words_before() then
        -- Open LSP completion manually
        vim.lsp.completion.get()
        return ""
    end

    -- Preserve normal Tab indentation
    return "<Tab>"
end, {
    expr = true,
    silent = true,
    desc = "Trigger or navigate completion",
})

vim.keymap.set("n", "<leader>cf", function()
    vim.lsp.buf.format({
        name = "ruff",
        async = false,
    })
end, {
    desc = "Ruff: format file",
})

vim.keymap.set("n", "<leader>ci", function()
    vim.lsp.buf.code_action({
        context = {
            only = {
                "source.organizeImports.ruff",
            },
        },
        apply = true,
    })

end, {
    desc = "Ruff: organize imports",
})

vim.keymap.set("n", "<leader>cx", function()
    vim.lsp.buf.code_action({
        context = {
            only = {
                "source.fixAll.ruff",
            },
        },
        apply = true,
    })
end, {
    desc = "Ruff: fix all",
})

local format_group = vim.api.nvim_create_augroup("RuffFormatOnSave", {
    clear = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_group,

    pattern = {
        "*.py",
        "*.pyi",
    },

    callback = function(event)
        vim.lsp.buf.format({
            bufnr = event.buf,
            name = "ruff",
            async = false,
            timeout_ms = 2000,
        })
    end,
})
-- show warnings on hover
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            scope = "cursor",
            focus = false,
            border = "rounded",
            source = true,
        })
    end,
})
-- show warning on <leader>e
vim.keymap.set("n", "<leader>?", function()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1

    local diagnostics = vim.diagnostic.get(0, { lnum = line })

    if #diagnostics > 0 then
        vim.diagnostic.open_float({
            scope = "line",
            border = "rounded",
            source = true,
            focusable = true,
        })
    else
        vim.lsp.buf.hover({
            border = "rounded",
        })
    end
end, {
    desc = "Show diagnostics or LSP documentation",
})
