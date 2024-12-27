-- remap space as leader key
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- alpha
vim.api.nvim_set_keymap("n", "<Leader>al", ":Alpha<CR>", opts)

-- quit and save
vim.api.nvim_set_keymap("n", "<Leader>qq", ":qall<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>qqq", ":qall!<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>wq", ":wqall<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>w", ":wall<CR>", opts)

-- window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)

-- move text up and down
-- normal mode
vim.api.nvim_set_keymap("n", "∆", "<Esc>:m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "˚", "<Esc>:m .-2<CR>==", opts)
-- visual mode
vim.api.nvim_set_keymap("v", "∆", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "˚", ":m .-2<CR>==", opts)
-- visual block
vim.api.nvim_set_keymap("x", "∆", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "˚", ":move '<-2<CR>gv-gv", opts)

-- increase/decrease window size
vim.api.nvim_set_keymap("n", "–", ":vert res -3<CR>", opts)
vim.api.nvim_set_keymap("n", "≠", ":vert res +3<CR>", opts)
vim.api.nvim_set_keymap("n", "—", ":res -3<CR>", opts)
vim.api.nvim_set_keymap("n", "±", ":res +3<CR>", opts)

-- buffers
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-w>", ":Bdelete<CR>", opts)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true }) -- Exit terminal mode
vim.keymap.set("n", "<Leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 25)
    vim.bo.modifiable = true
end)

-- molten
vim.keymap.set("v", "<leader>m", function()
    -- Get start and end positions of the visual selection
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    vim.fn.MoltenEvaluateRange(start_line, end_line)
end)

vim.keymap.set("n", "<leader>mb", function()
    local last_line = vim.api.nvim_buf_line_count(0)
    vim.fn.MoltenEvaluateRange(1, last_line)
end)
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set(
    "n",
    "<localleader>me",
    ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "run operator selection" }
)
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
vim.keymap.set(
    "n",
    "<localleader>mo",
    ":noautocmd MoltenEnterOutput<CR>",
    { silent = true, desc = "show/enter output" }
)
vim.keymap.set(
    "v",
    "<localleader>r",
    ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "evaluate visual selection" }
)
-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function(e) -- init molten buffer
    vim.schedule(function()
        local kernels = vim.fn.MoltenAvailableKernels() or {}
        local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
        end
        print(e.file)
        local ok, kernel_name = pcall(try_kernel_name)
        if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv ~= nil then
                kernel_name = string.match(venv, "/.+/(.+)")
            end
        end
        if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
        end
        vim.cmd("MoltenImportOutput")
    end)
end

vim.keymap.set("n", "<localleader>ip", function()
    imb()
end, { desc = "Initialize Molten for python3", silent = true })
-- automatically import output chunks from a jupyter notebook
vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.ipynb" },
    callback = function(e)
        if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
        end
    end,
})
-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.ipynb" },
    callback = function()
        if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
        end
    end,
})

-- change the configuration when editing a python file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.py",
    callback = function(e)
        if string.match(e.file, ".otter.") then
            return
        end
        if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("virt_text_output", false)
        else
            vim.g.molten_virt_lines_off_by_1 = false
            vim.g.molten_virt_text_output = false
        end
    end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.qmd", "*.md", "*.ipynb" },
    callback = function(e)
        if string.match(e.file, ".otter.") then
            return
        end
        if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
            vim.fn.MoltenUpdateOption("virt_text_output", true)
        else
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_virt_text_output = true
        end
    end,
})

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
    else
        print("Error: Could not open new notebook file for writing.")
    end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
    new_notebook(opts.args)
end, {
    nargs = 1,
    complete = "file",
})
