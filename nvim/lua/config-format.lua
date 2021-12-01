require"format".setup {
    ["*"] = {{cmd = {"sed -i 's/[ \t]*$//'"}}},
    html = {{cmd = {"prettier -w"}}},
    css = {{cmd = {"prettier -w"}}},
    json = {{cmd = {"prettier -w"}}},
    yaml = {{cmd = {"prettier -w"}}},
    javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    javascriptreact = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    typescript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    typescriptreact = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    lua = {
        {
            cmd = {
                function(file)
                    return string.format("lua-format -i --column-limit=125 --break-after-table-lb %s", file)
                end
            },
            tempfile_postfix = ".tmp"
        }
    },
    python = {{cmd = {function(file) return string.format("black --quiet %s", file) end}, tempfile_postfix = ".tmp"}},
    c = {
        {cmd = {function(file) return string.format("clang-format -i --style=llvm %s", file) end}, tempfile_postfix = ".tmp"}
    },
    cpp = {
        {
            cmd = {function(file)
                return string.format("clang-format -i --style=llvm --sort-includes=false %s", file)
            end},
            tempfile_postfix = ".tmp"
        }
    },
    -- vim = {
    --     {
    --         cmd = {"luafmt -w replace"},
    --         start_pattern = "^lua << EOF$",
    --         end_pattern = "^EOF$"
    --     }
    -- },
    vimwiki = {{cmd = {"prettier -w --parser babel"}, start_pattern = "^{{{javascript$", end_pattern = "^}}}$"}},
    -- lua = {
    --     {
    --         cmd = {
    --             function(file)
    --                 return string.format("luafmt -l %s -w replace %s", vim.bo.textwidth, file)
    --             end
    --         }
    --     }
    -- },
    markdown = {
        {cmd = {"prettier -w"}}, {cmd = {"black"}, start_pattern = "^```python$", end_pattern = "^```$", target = "current"}
    }
}

vim.cmd('autocmd BufWritePost * FormatWrite')
