require 'config.settings'
require 'config.lazy'
require 'config.keymaps'

-- The lspconfig plugin adds default LSP configs for any LSP installed with Mason
-- For any which are not in the Mason registry they have to be manually installed and enabled
vim.lsp.enable("racket_langserver") -- installed with rako

-- Special handling for vue_ls which needs the plugin mounted in vtsls or ts_ls
local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_language_server_path,
	languages = { 'vue' },
	configNamespace = 'typescript',
}
vim.lsp.config('vtsls', {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- vim: ts=2 sts=2 sw=2 et
