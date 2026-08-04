-- lsp config
local M = {}

local function has_words_before()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    if col == 0 then
        return false
    end

    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

    return line:sub(col, col):match("%s") == nil
end

function M.setup()
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

    vim.opt.completeopt = { "menuone", "noselect", "popup" }

    local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

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
                    true, client.id, event.buf, { autotrigger = false }
                )
            end
        end,
    })

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

    local format_group = vim.api.nvim_create_augroup("RuffFormatOnSave", { clear = true })

    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = format_group,
    --
    --     pattern = { "*.py", "*.pyi" },
    --
    --     callback = function(event)
    --         vim.lsp.buf.format({
    --             bufnr = event.buf,
    --             name = "ruff",
    --             async = false,
    --             timeout_ms = 2000,
    --         })
    --     end,
    -- })
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
    -- show warning on <leader>?
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
            vim.lsp.buf.hover({ border = "rounded" })
        end
    end, {
        desc = "Show diagnostics or LSP documentation",
    })
end

return M
