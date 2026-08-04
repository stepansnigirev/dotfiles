-- BufOnly command that closes all buffers except current
local M = {}

function M.setup()
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
end

return M
