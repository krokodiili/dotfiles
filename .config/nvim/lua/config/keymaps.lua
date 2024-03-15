-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here-- Normal mode mappings for <S-m> and <S-j>
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.api.nvim_exec(
  [[
function! s:GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    if line_start == line_end
        let lines[0] = lines[0][column_start - 1 : column_end - 1]
    else
        let lines[-1] = lines[-1][: column_end - 1]
        let lines[0] = lines[0][column_start - 1:]
    endif
    return join(lines, "\n")
endfunction

function! s:SearchReplaceVisualSelection()
    let selection = s:GetVisualSelection()
    let escaped_selection = escape(selection, '/\')
    let command = ':%s/' . escaped_selection . '/'
    call feedkeys(":" . command, 'n')
endfunction

xnoremap <leader>sr :<C-u>call <SID>SearchReplaceVisualSelection()<CR>
]],
  false
)

keymap("n", "<S-m>", "<C-d>zz", opts)
keymap("n", "<S-j>", "<C-u>zz", opts)

keymap("v", "<S-m>", "<C-d>zz", opts)
keymap("v", "<S-j>", "<C-u>zz", opts)

keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

keymap("n", "<leader>l", "_v$", opts)
