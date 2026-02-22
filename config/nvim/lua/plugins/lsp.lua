return {
	{
		'mason-org/mason-lspconfig.nvim',
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				'lua_ls',
				'pylsp',
				'html',
				'cssls',
				'clojure_lsp',
				'jsonls',
				'eslint',
				'tailwindcss',
				'vue_ls',
				'vtsls',
				'marksman',
			},
		},
	},
}
