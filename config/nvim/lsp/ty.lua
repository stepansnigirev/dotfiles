---@type vim.lsp.Config
return {
    cmd = { "ty", "server" },
    filetypes = { "python" },

    root_markers = {
        "ty.toml",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        ".git",
    },

    settings = {
        ty = {
            -- Check currently opened files. Use "workspace" to check everything.
            diagnosticMode = "openFilesOnly",

            -- Ruff will report syntax errors, avoiding duplicate messages.
            showSyntaxErrors = false,
        },
    },
}
