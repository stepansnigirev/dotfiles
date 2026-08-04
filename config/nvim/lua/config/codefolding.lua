-- Code folding
local M = {}

function M.setup()
    -- zc - close, zo - open, za - toggle, zM - close all, zR - open all
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
end

return M
