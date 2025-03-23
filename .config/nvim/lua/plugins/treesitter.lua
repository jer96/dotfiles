return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "tsx",
        "javascript",
        "typescript",
        "vimdoc",
        "vim",
        "markdown",
        "markdown_inline",
      },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true, disable = { "python" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      },
    })

    -- Extract markdown code block using Treesitter
    vim.keymap.set("n", "<leader>cc", function()
      local ts_utils = require("nvim-treesitter.ts_utils")

      -- Helper function to find code block node
      local function find_code_block_node(node)
        while node do
          if node:type() == "fenced_code_block" then
            return node
          end
          -- Try parent node
          node = node:parent()
        end
        return nil
      end

      -- Get current node and try to find code block
      local cur_node = ts_utils.get_node_at_cursor()
      local code_block = find_code_block_node(cur_node)

      -- If not found, try searching nearby nodes
      if not code_block then
        -- Get current position
        local row = vim.api.nvim_win_get_cursor(0)[1] - 1
        local col = vim.api.nvim_win_get_cursor(0)[2]

        -- Try a few rows above and below current position
        for offset = -3, 3 do
          local try_row = row + offset
          if try_row >= 0 then
            local node_at_pos = vim.treesitter.get_node({
              pos = { try_row, col },
            })
            if node_at_pos then
              code_block = find_code_block_node(node_at_pos)
              if code_block then
                break
              end
            end
          end
        end
      end

      if code_block then
        local start_row, _, end_row, _ = code_block:range()
        -- Get the content without the fence markers
        local lines = vim.api.nvim_buf_get_lines(0, start_row + 1, end_row - 1, false)

        -- Remove possible language identifier
        if #lines > 0 and lines[1]:match("^```") then
          table.remove(lines, 1)
        end

        -- Copy to system clipboard and default register
        local text = table.concat(lines, "\n")
        vim.fn.setreg("+", text)
        vim.fn.setreg('"', text)

        vim.notify("Code block copied to clipboard", vim.log.levels.INFO)
      else
        vim.notify("No code block found near cursor", vim.log.levels.WARN)
      end
    end, { desc = "Extract markdown code block" })
  end,
}
