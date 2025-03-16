local M = {}

-- Common ignored file patterns for both nvim-tree and telescope
M.ignored_patterns = {
    ".oh-my-zsh/",
    ".Trash",
    ".DS_Store",
    ".cache",
    ".lesshst",
    ".npm",
    "Applications",
    "Desktop",
    "Downloads",
    "Documents",
    "Library",
    "Music",
    "Movies",
    "Public",
    "Pictures",
    "^.git$",
    ".venv",
    ".cargo",
    ".pyenv",
    ".CFUserTextEncoding",
    ".local",
    "quarto_files",
    "build",
    "node_modules",
    "dist",
}

M.set_python3_host_prog = function()
    -- Check for virtual environment
    local venv_path = os.getenv("VIRTUAL_ENV")
    if venv_path then
        local venv_python = venv_path .. "/bin/python"
        if vim.fn.executable(venv_python) == 1 then
            vim.g.python3_host_prog = venv_python
            return
        end
    end

    -- Check for pyenv shims
    local pyenv_python = vim.fn.expand("~/.pyenv/shims/python")
    if vim.fn.executable(pyenv_python) == 1 then
        vim.g.python3_host_prog = pyenv_python
        return
    end

    -- Check for system Python3
    local system_python = vim.fn.exepath("python3")
    if system_python ~= "" then
        vim.g.python3_host_prog = system_python
        return
    end

    -- Fallback to python if python3 is not found
    local python = vim.fn.exepath("python")
    if python ~= "" then
        vim.g.python3_host_prog = python
        return
    end

    vim.notify("No Python interpreter found!", vim.log.levels.WARN)
end

return M
