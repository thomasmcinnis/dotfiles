return {
	{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			spec = {
				{ "<leader>a", group = "ai", mode = { "n", "v" } },
			},
		},
	},
	{
		"zbirenbaum/copilot.lua", -- AI programming
		event = "InsertEnter",
		enabled = true,
		opts = {
			suggestion = {
				auto_trigger = true, -- Suggest as we start typing
				keymap = {
					accept = "<C-y>",
					accept_word = "<C-l>",
					accept_line = "<C-j,>",
					next = "<C-o>",
					prev = "<C-i>",
					dismiss = "<C-u>",
				},
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		config = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim",           branch = "master" },
			{ "nvim-treesitter/nvim-treesitter", }
		},
		opts = {
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						-- MCP Tools
						make_tools = true,   -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
						show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
						add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
						show_result_in_chat = true, -- Show tool results directly in chat buffer
						format_tool = nil,   -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
						-- MCP Resources
						make_vars = true,    -- Convert MCP resources to #variables for prompts
						-- MCP Prompts
						make_slash_commands = true, -- Add MCP prompts as /slash commands
					}
				}
			},
			strategies = {
				chat = {
					roles = {
						---The header name for the LLM's messages
						---@diagnostic disable-next-line: undefined-doc-name
						---@type string|fun(adapter: CodeCompanion.Adapter): string
						llm = function(adapter)
							---@diagnostic disable-next-line: undefined-field
							return "  (" .. adapter.formatted_name .. ")"
						end,

						---The header name for your messages
						---@type string
						user = "  (Thomas)",
					}
				}
			},
			display = {
				diff = {
					enabled = true,
					close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
					layout = "vertical", -- vertical|horizontal split for default provider
					opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
					provider = "mini_diff", -- default|mini_diff
				},
				chat = {
					-- show_settings = true,
					-- Options to customize the UI of the chat buffer
					window = {
						layout = "vertical", -- float|vertical|horizontal|buffer
						position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
						border = "single",
						width = 80,
						relative = "editor",
						full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
						opts = {
							breakindent = true,
							cursorcolumn = false,
							cursorline = false,
							foldcolumn = "0",
							linebreak = true,
							list = false,
							number = false,
							relativenumber = false,
							numberwidth = 1,
							signcolumn = "no",
							spell = false,
							wrap = true,
						},
					},
				},
				action_palette = {
					width = 95,
					height = 10,
					prompt = "Prompt ",   -- Prompt used for interactive LLM calls
					provider = "snacks",  -- Can be "default", "telescope", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
					opts = {
						show_default_actions = true, -- Show the default actions in the action palette?
						show_default_prompt_library = true, -- Show the default prompt library in the action palette?
					},
				},
			}
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>",     desc = "CodeCompanion - Actions menu",        mode = { "n", "v" } },
			{ "<leader>ac", "<cmd>CodeCompanionChat<cr>",        desc = "CodeCompanion - Start chat",          mode = { "n", "v" } },
			{ "<leader>av", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion - Toggle chat buffer",  mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion /explain<cr>",   desc = "CodeCompanion - Explain code",        mode = "v" },
			{ "<leader>ar", "<cmd>CodeCompanion /lsp<cr>",       desc = "CodeCompanion - Refactor code",       mode = "v" },
			{ "<leader>af", "<cmd>CodeCompanion /fix<cr>",       desc = "CodeCompanion - Fix code",            mode = "v" },
			{ "<leader>au", "<cmd>CodeCompanion /tests<cr>",     desc = "CodeCompanion - Generate unit tests", mode = "v" },
			{ "ga",         "<cmd>CodeCompanionChat Add<CR>",    desc = "Add selected text to a chat buffer",  mode = { "n", "v" } },
		}
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
		config = function()
			require("mcphub").setup()
		end
	},
}
