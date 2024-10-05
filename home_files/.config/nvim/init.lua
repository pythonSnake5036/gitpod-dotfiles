vim.opt.encoding = "utf-8"

vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"

vim.opt.syntax = "on"

vim.opt.number = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local MiniDeps = require('mini.deps')

-- Set up 'mini.deps' (customize to your liking)
MiniDeps.setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	require('mini.files').setup()
	vim.keymap.set('n', '<space>fb', MiniFiles.open, {})

	require("mini.icons").setup()
	require('mini.tabline').setup()
	require('mini.trailspace').setup()
end)

later(function()
	require('mini.comment').setup()
	require('mini.completion').setup {
		lsp_completion = {
			source_func = 'omnifunc'
		}
	}

	require('mini.move').setup()
	require('mini.pairs').setup()

	require("mini.pick").setup()
	vim.keymap.set('n', '<space>ff',  MiniPick.builtin.files, {})
	vim.keymap.set('n', '<space>fg',  MiniPick.builtin.grep_live, {})
	vim.keymap.set('n', '<leader>fb', MiniPick.builtin.buffers, {})
	vim.keymap.set('n', '<space>fh',  MiniPick.builtin.help, {})

	require('mini.surround').setup()
end)

add({ source = 'neovim/nvim-lspconfig' })

later(function()
	local lspconfig = require('lspconfig')
	lspconfig.clangd.setup{}
	lspconfig.pyright.setup{}
	lspconfig.rust_analyzer.setup{}
	lspconfig.svelte.setup{}
	lspconfig.ts_ls.setup{}
	lspconfig.tailwindcss.setup{}
end)

add({ source = 'navarasu/onedark.nvim' })

now(function()
	local onedark = require('onedark')
	onedark.setup {
		style = 'darker'
	}
	onedark.load()
end)

add({ source = 'folke/trouble.nvim' })

later(function()
	local trouble = require('trouble')
	trouble.setup{}
	vim.keymap.set('n', "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
    vim.keymap.set('n', "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
    vim.keymap.set('n', "<leader>cs", "<cmd>Trouble symbols toggle focus=false win.position=left<cr>", { desc = "Symbols (Trouble)" })
    vim.keymap.set('n', "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
    vim.keymap.set('n', "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
    vim.keymap.set('n', "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
end)

