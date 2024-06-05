return {
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lsp_zero = require('lsp-zero')

			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
			  lsp_zero.default_keymaps({buffer = bufnr})
			end)

			require('lspconfig').clangd.setup{}
			require('lspconfig').pyright.setup{}
			require('lspconfig').tsserver.setup{}
			require('lspconfig').tailwindcss.setup{}
			require('lspconfig').rust_analyzer.setup{}
		end
	},
	{'hrsh7th/cmp-nvim-lsp'},
	{
		'hrsh7th/nvim-cmp',
		config = function()
			local cmp = require("cmp")
			local cmp_action = require('lsp-zero').cmp_action()

			cmp.setup({
	  			mapping = cmp.mapping.preset.insert({
					['<Tab>'] = cmp_action.tab_complete(),
					['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
					['<CR>'] = cmp.mapping.confirm({select = false}),
	  			}),
			})
		end
	},
	{'L3MON4D3/LuaSnip'},
	{
		'morhetz/gruvbox',
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end
	},
}
