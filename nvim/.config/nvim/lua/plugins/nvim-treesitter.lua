return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function()
		-- Highlighting
		vim.api.nvim_create_autocmd('FileType', {
			pattern = { '<filetype>' },
			callback = function() vim.treesitter.start() end,
		})

		-- Folds
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'

		-- Identation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- Parsers
		require'nvim-treesitter'.install {
			'astro', 
			'bash', 
			'c', 
			'c_sharp', 
			'cpp', 
			'css', 
			'csv', 
			'dart',
			'desktop',
			'dockerfile',
			'git_config',
			'git_rebase',
			'gitcommit',
			'go',
			'html',
			'htmldjango',
			'hyprlang',
			'javascript',
			'jq',
			'json',
			'jsx',
			'kitty',
			'lua',
			'python',
			'rust',
			'scss',
			'sql',
			'ssh_config',
			'tmux',
			'toml',
			'tsx',
			'typescript',
			'vue',
			'yaml',
			'zsh',
		}
	end
}
