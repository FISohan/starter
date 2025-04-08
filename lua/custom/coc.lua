local keyset = vim.keymap.set
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

-- Tab completion
_G.check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', opts)

-- Press <CR> to confirm completion, `<C-g>u` breaks undo sequence
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Trigger completion manually
keyset("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })

-- Go to definition / references / implementation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Show documentation
function _G.show_docs()
  local cw = vim.fn.expand("<cword>")
  if vim.bo.filetype == "vim" or vim.bo.filetype == "help" then
    vim.api.nvim_command("h " .. cw)
  else
    vim.fn.CocActionAsync("doHover")
  end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

-- Format
keyset("n", "<leader>f", "<Plug>(coc-format)", { silent = true })

-- Diagnostics navigation
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- Code Action for Flutter (Refactor, Organize Imports, etc.)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })  -- Apply code actions to selected region
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", { silent = true })   -- Apply code action at cursor position
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", { silent = true })   -- Apply source code actions for current file

-- Organize imports (Flutter)
keyset("n", "<leader>oi", ":CocCommand flutter.organizeImports<CR>", { silent = true }) -- Organize imports in Flutter files

