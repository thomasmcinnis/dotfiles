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
		enabled = false,
		keys = {
			{
				"<C-a>",
				function()
					require("copilot.suggestion").accept()
				end,
				desc = "Copilot: Accept suggestion",
				mode = { "i" },
			},
			{
				"<C-x>",
				function()
					require("copilot.suggestion").dismiss()
				end,
				desc = "Copilot: Dismiss suggestion",
				mode = { "i" },
			},
		},
		opts = {
			panel = { enabled = false },
			suggestion = {
				auto_trigger = true, -- Suggest as we start typing
				keymap = {
					accept_word = "<C-l>",
					accept_line = "<C-j>",
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
						height = 0.8,
						width = 0.20,
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
				}
			}
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<cr>",     desc = "CodeCompanion - Actions menu",        mode = { "n", "v" } },
			-- { "<leader>ac", "<cmd>CodeCompanionChat<cr>",        desc = "CodeCompanion - Start chat",          mode = { "n", "v" } },
			{ "<leader>av", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion - Toggle chat buffer",  mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion /explain<cr>",   desc = "CodeCompanion - Explain code",        mode = "v" },
			{ "<leader>ar", "<cmd>CodeCompanion /lsp<cr>",       desc = "CodeCompanion - Refactor code",       mode = "v" },
			{ "<leader>af", "<cmd>CodeCompanion /fix<cr>",       desc = "CodeCompanion - Fix code",            mode = "v" },
			{ "<leader>au", "<cmd>CodeCompanion /tests<cr>",     desc = "CodeCompanion - Generate unit tests", mode = "v" },
			{ "ga",         "<cmd>CodeCompanionChat Add<CR>",    desc = "Add selected text to a chat buffer",  mode = { "n", "v" } },
		}
	}
}

-- local prompts = {
--
-- 	-- Code related prompts
-- 	Explain = "Please explain how the following code works.",
-- 	Review =
-- 	"Please review the following code and provide suggestions for improvement. Do not provide actual code blocks in your response only suggestions.",
-- 	Tests = "Please explain how the selected code works, then generate unit tests for it.",
-- 	Refactor = "Please refactor the following code to improve its clarity and readability.",
-- 	FixCode = "Please fix the following code to make it work as intended.",
-- 	FixError = "Please explain the error in the following text and provide a solution.",
-- 	BetterNamings = "Please provide better names for the following variables and functions.",
-- 	Documentation = "Please provide documentation for the following code.",
--
-- 	-- Text related prompts
-- 	Summarize = "Please summarize the following text.",
-- 	Spelling = "Please correct any grammar and spelling errors in the following text.",
-- 	Wording = "Please improve the grammar and wording of the following text.",
-- 	Concise = "Please rewrite the following text to make it more concise.",
-- }
--
-- local has_fzf = not vim.g.vscode and package.loaded["fzf-lua"]

-- return {
-- 	{
-- 		"folke/which-key.nvim",
-- 		optional = true,
-- 		opts = {
-- 			spec = {
-- 				{ "<leader>a", group = "ai", mode = { "n", "v" } },
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		opts = { ensure_installed = { "diff", "markdown" } },
-- 	},
-- 	{
-- 		"CopilotC-Nvim/CopilotChat.nvim",
-- 		branch = "main",
-- 		build = "make tiktoken",
-- 		dependencies = {
-- 			{ "nvim-lua/plenary.nvim" },
-- 			{ "zbirenbaum/copilot.lua" },
-- 		},
-- 		opts = {
-- 			question_header = "  User  ",
-- 			answer_header = "  Copilot  ",
-- 			error_header = "  Error  ",
-- 			prompts = prompts,
-- 			model = "claude-3.7-sonnet",
-- 			mappings = {
-- 				-- Use tab for completion
-- 				complete = {
-- 					detail = "Use @<Tab> or /<Tab> for options.",
-- 					insert = "<Tab>",
-- 				},
-- 				-- Close the chat
-- 				close = {
-- 					normal = "q",
-- 					insert = "<C-c>",
-- 				},
-- 				-- Reset the chat buffer
-- 				reset = {
-- 					normal = "<C-x>",
-- 					insert = "<C-x>",
-- 				},
-- 				-- Submit the prompt to Copilot
-- 				submit_prompt = {
-- 					normal = "<CR>",
-- 					insert = "<C-CR>",
-- 				},
-- 				-- Accept the diff
-- 				accept_diff = {
-- 					normal = "<C-y>",
-- 					insert = "<C-y>",
-- 				},
-- 				-- Show help
-- 				show_help = {
-- 					normal = "g?",
-- 				},
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			local chat = require("CopilotChat")
--
-- 			chat.setup(opts)
--
-- 			local select = require("CopilotChat.select")
-- 			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
-- 				chat.ask(args.args, { selection = select.visual })
-- 			end, { nargs = "*", range = true })
--
-- 			-- Inline chat with Copilot
-- 			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
-- 				chat.ask(args.args, {
-- 					selection = select.visual,
-- 					window = {
-- 						layout = "float",
-- 						relative = "cursor",
-- 						width = 1,
-- 						height = 0.4,
-- 						row = 1,
-- 					},
-- 				})
-- 			end, { nargs = "*", range = true })
--
-- 			-- Restore CopilotChatBuffer
-- 			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
-- 				chat.ask(args.args, { selection = select.buffer })
-- 			end, { nargs = "*", range = true })
--
-- 			-- Custom buffer for CopilotChat
-- 			vim.api.nvim_create_autocmd("BufEnter", {
-- 				pattern = "copilot-*",
-- 				callback = function()
-- 					vim.opt_local.relativenumber = true
-- 					vim.opt_local.number = false
-- 				end,
-- 			})
-- 		end,
-- 		keys = {
-- 			-- Show prompts actions
-- 			{
-- 				"<leader>ap",
-- 				function()
-- 					local actions = require("CopilotChat.actions")
-- 					if has_fzf then
-- 						require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
-- 					else
-- 						-- __AUTO_GENERATED_PRINT_VAR_START__
-- 						print([==[function#if has_snacks:]==], vim.inspect(has_snacks)) -- __AUTO_GENERATED_PRINT_VAR_END__
-- 						require("CopilotChat.integrations.snacks").pick(actions.prompt_actions())
-- 					end
-- 				end,
-- 				desc = "CopilotChat - Prompt actions",
-- 			},
-- 			{
-- 				"<leader>ap",
-- 				function()
-- 					local actions = require("CopilotChat.actions")
-- 					if has_fzf then
-- 						require("CopilotChat.integrations.fzflua").pick(
-- 							actions.prompt_actions({ selection = require("CopilotChat.select").visual })
-- 						)
-- 					else
-- 						require("CopilotChat.integrations.snacks").pick(
-- 							actions.prompt_actions({ selection = require("CopilotChat.select").visual })
-- 						)
-- 					end
-- 				end,
-- 				mode = "x",
-- 				desc = "CopilotChat - Prompt actions",
-- 			},
-- 			-- Code related commands
-- 			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
-- 			{ "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
-- 			{ "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
-- 			{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
-- 			{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
-- 			-- Chat with Copilot in visual mode
-- 			{
-- 				"<leader>av",
-- 				":CopilotChatVisual <cr>",
-- 				mode = "v",
-- 				desc = "CopilotChat - Open in vertical split",
-- 			},
-- 			{
-- 				"<leader>ai",
-- 				":CopilotChatInline <cr>",
-- 				mode = "v",
-- 				desc = "CopilotChat - Inline chat",
-- 			},
-- 			-- Custom input for CopilotChat
-- 			{
-- 				"<leader>ai",
-- 				function()
-- 					local input = vim.fn.input("Ask Copilot: ")
-- 					if input ~= "" then
-- 						vim.cmd("CopilotChat " .. input)
-- 					end
-- 				end,
-- 				desc = "CopilotChat - Ask input",
-- 			},
-- 			-- Generate commit message based on the git diff
-- 			{
-- 				"<leader>am",
-- 				"<cmd>CopilotChatCommit<cr>",
-- 				desc = "CopilotChat - Generate commit message for all changes",
-- 			},
-- 			{
-- 				"<leader>aq",
-- 				function()
-- 					local input = vim.fn.input("Quick Chat: ")
-- 					if input ~= "" then
-- 						vim.cmd("CopilotChatBuffer " .. input)
-- 					end
-- 				end,
-- 				desc = "CopilotChat - Quick chat",
-- 			},
-- 			-- Debug
-- 			{ "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
-- 			-- Fix the issue with diagnostic
-- 			{ "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
-- 			-- Clear buffer and chat history
-- 			{ "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
-- 			-- Toggle Copilot Chat Vsplit
-- 			{ "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
-- 			-- Copilot Chat Models
-- 			{ "<leader>a?", "<cmd>CopilotChatModels<cr>",        desc = "CopilotChat - Select Models" },
-- 			-- Copilot Chat Agents
-- 			{ "<leader>aa", "<cmd>CopilotChatAgents<cr>",        desc = "CopilotChat - Select Agents" },
-- 		},
-- 	},
-- }
--
