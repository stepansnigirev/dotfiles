-- Colorscheme
local M = {}

local colors = {
    -- background
    bg           = "None",
    bg_highlight = "#0a0b16",
    bg_bright    = "#1a1b33",
    -- text
    fg           = "#d0daf5",
    fg_status    = "#828BB8",
    fg_inactive  = "#323B78",
    muted        = "#363f59",
    highlight    = "#ff966c",
    -- code colors
    comment      = "#464f69",
    number       = "#fab387",
    string       = "#c3e88d",
    class        = "#fab387",
    keyword      = "#cba6f7",
    func         = "#89b4fa",
    -- text colors
    h1           = "#5E46FF",
    h2           = "#E500FF",
    h3           = "#442E76",
    -- lualine
    normal       = "#7287fd",
}
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
    set_style("@lsp.type.decorator.python", { fg = colors.keyword })
    set_style("pythonDecorator", { fg = colors.keyword })
    set_style("Operator", { fg = colors.keyword })
    set_style("Statement", { link = "Keyword" })
    set_style("Conditional", { link = "Keyword" })
    set_style("Repeat", { link = "Keyword" })
    set_style("Exception", { link = "Keyword" })
    set_style("Include", { link = "Keyword" })
    set_style("@function", { fg = colors.func })
    set_style("@lsp.type.property.python", { fg = colors.func })
    set_style("Function", { link = "@function" })
    set_style("Special", { link = "@function" })
    set_style("Type", { fg = colors.class })
    set_style("Typedef", { fg = colors.class })
    set_style("@string", { fg = colors.string })
    -- brackets
    set_style("MatchParen", { fg = colors.highlight, bg = colors.bg })
    -- Markdown
    -- set_style("Title", { bg = colors.h1, fg = colors.fg, bold = true })
    set_style("Title", { fg = colors.h1, bold = true })
    set_style("@markup.heading.2.markdown", { fg = colors.h2, bold = false })
    set_style("@markup.heading.3.markdown", { fg = colors.string, bold = true })
end

function M.setup()
    vim.opt.background = "dark"
    apply_custom_colors()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_custom_colors })
end

function M.lualine()
    return lualine_theme
end

return M
