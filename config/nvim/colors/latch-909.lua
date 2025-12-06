vim.cmd("highlight clear")
vim.g.colors_name = "theme"
vim.opt.background = "dark"
vim.opt.termguicolors = false

--- Helper function to set highlight groups with cterm attributes
--- This function builds a vim highlight command string and executes it
--- @param group string The highlight group name to set
--- @param opts table Table containing highlight options:
---   - ctermfg: string|number Terminal foreground color (0-255 or color name)
---   - ctermbg: string|number Terminal background color (0-255 or color name)
---   - cterm: string Terminal attributes (bold, italic, underline, etc.)
local function hi(group, opts)
	-- Start building the highlight command string
	local cmd = "highlight " .. group
	-- Add terminal foreground color if specified
	if opts.ctermfg then
		cmd = cmd .. " ctermfg=" .. opts.ctermfg
	end
	-- Add terminal background color if specified
	if opts. ctermbg then
		cmd = cmd .. " ctermbg=" .. opts.ctermbg
	end
	-- Add terminal attributes (bold, italic, etc.) if specified
	if opts.cterm then
		cmd = cmd ..  " cterm=" .. opts.cterm
	end
	-- Execute the highlight command
	vim.cmd(cmd)
end

---
-- Color definitions
---

local colors = {
	bg = 0,			-- ansi 0 - black
	bg_soft = 8,	-- ansi 8 - bright black
	fg_soft = 7,     -- ansi 7 - white
	fg = 15,		-- ansi 15 - bright white
	red = 1,        -- ansi 1 - red
	red_strong = 9,     -- ansi 9 - bright red
	green = 2,      -- ansi 2 - green
	green_strong = 10,  -- ansi 10 - bright green
	yellow = 3,     -- ansi 3 - yellow
	yellow_strong = 11, -- ansi 11 - bright yellow
	blue = 4,       -- ansi 4 - blue (keywords, info)
	blue_strong = 12,   -- ansi 12 - bright blue
	magenta = 5,    -- ansi 5 - magenta
	magenta_strong = 13, -- ansi 13 - bright magenta
	cyan = 6,       -- ansi 6 - cyan
	cyan_strong = 14,   -- ansi 14 - bright cyan
}

---
-- Simplified semantic syntax map
-- Grouped by visual treatment with base and special variants
---

local syntax_map = {
	-- Comments (muted/gray)
	comment = { ctermfg = colors.fg_soft },
	comment_special = { ctermfg = colors.fg_soft, cterm = "italic" },

	-- Keywords & Control Flow (bright blue)
	keyword = { ctermfg = colors.blue_strong },
	keyword_special = { ctermfg = colors.blue, cterm = "bold" },

	-- Functions & Methods (bright yellow)
	function_name = { ctermfg = colors.yellow_strong },
	function_special = { ctermfg = colors.yellow_strong, cterm = "bold" },

	-- Types & Classes (warm yellow)
	type_name = { ctermfg = colors.yellow },
	type_special = { ctermfg = colors.yellow_strong },

	-- Constants (magenta/purple)
	constant = { ctermfg = colors.magenta_strong },
	constant_special = { ctermfg = colors.magenta_strong, cterm = "bold" },

	-- Variables (neutral white/gray)
	variable = { ctermfg = colors.fg },
	variable_special = { ctermfg = colors.yellow_strong },

	-- Strings & Characters (green)
	string = { ctermfg = colors.green_strong },
	string_special = { ctermfg = colors.green_strong, cterm = "bold" },

	-- Numbers (bright red)
	number = { ctermfg = colors.red_strong },
	number_special = { ctermfg = colors.red_strong, cterm = "bold" },

	-- Operators & Punctuation (neutral)
	operator = { ctermfg = colors.fg },
	punctuation = { ctermfg = colors.fg },
	punctuation_special = { ctermfg = colors.green_strong },

	-- Properties & Fields (cyan)
	property = { ctermfg = colors.cyan },
	property_special = { ctermfg = colors.cyan_strong },

	-- Preprocessor & Includes (magenta)
	preprocessor = { ctermfg = colors.magenta_strong },
	include = { ctermfg = colors.magenta_strong },

	-- Attributes & Annotations (blue)
	attribute = { ctermfg = colors.blue_strong },
	attribute_special = { ctermfg = colors.blue, cterm = "italic" },

	-- Text & Markup (neutral with modifiers)
	text = { ctermfg = colors.fg_soft },
	text_bold = { ctermfg = colors.fg_soft, cterm = "bold" },
	text_italic = { ctermfg = colors.fg_soft, cterm = "italic" },
	text_underline = { ctermfg = colors.fg_soft, cterm = "underline" },
	text_strike = { ctermfg = colors.fg_soft, cterm = "strikethrough" },
	text_title = { ctermfg = colors.blue, cterm = "bold" },
	text_code = { ctermfg = colors.green },
	text_uri = { ctermfg = colors.green_strong, cterm = "underline" },

	-- Tags (HTML/XML)
	tag = { ctermfg = colors.blue_strong },
	tag_attribute = { ctermfg = colors.cyan },
	tag_special = { ctermfg = colors.blue },

	-- Special elements (errors, warnings, etc.)
	error = { ctermfg = colors.red_strong },
	warning = { ctermfg = colors.yellow_strong, cterm = "bold" },
	info = { ctermfg = colors.blue_strong, cterm = "bold" },
	debug = { ctermfg = colors.red_strong },

	-- Diff highlighting
	diff_add = { ctermfg = colors.green_strong, cterm = "bold" },
	diff_change = { ctermfg = colors.yellow_strong },
	diff_delete = { ctermfg = colors.red_strong, cterm = "bold" },

	-- Spell checking
	spell_bad = { ctermfg = colors.red, cterm = "underline" },
	spell_cap = { ctermfg = colors.blue, cterm = "underline" },
	spell_local = { ctermfg = colors.cyan, cterm = "underline" },
	spell_rare = { ctermfg = colors.magenta, cterm = "underline" },

	-- UI elements
	line_nr = { ctermfg = colors.bg_soft },
	status_line = { ctermfg = colors.bg, ctermbg = colors.fg_soft, cterm = "none" },
	status_line_nc = { ctermfg = colors.bg_soft, ctermbg = colors.fg_soft, cterm = "none" },
	vert_split = { ctermfg = colors.fg_soft },
}

---
-- Editor interface
---

hi("LineNr", syntax_map.line_nr)
hi("StatusLine", syntax_map.status_line)
hi("StatusLineNC", syntax_map.status_line_nc)
hi("VertSplit", syntax_map.vert_split)
hi("SpellBad", syntax_map.spell_bad)
hi("SpellCap", syntax_map.spell_cap)
hi("SpellLocal", syntax_map.spell_local)
hi("SpellRare", syntax_map.spell_rare)

-- Diff highlighting
hi("DiffAdd", syntax_map.diff_add)
hi("DiffChange", syntax_map.diff_change)
hi("DiffDelete", syntax_map.diff_delete)
hi("DiffText", syntax_map.diff_change)

---
-- Syntax highlights
---

hi("Comment", syntax_map.comment)
hi("String", syntax_map.string)
hi("Character", syntax_map.string)
hi("Number", syntax_map.number)
hi("Float", syntax_map.number)
hi("Boolean", syntax_map.constant)
hi("Constant", syntax_map.constant)
hi("Identifier", syntax_map.variable)
hi("Function", syntax_map.function_name)
hi("Statement", syntax_map.keyword)
hi("Conditional", syntax_map.keyword_special)
hi("Repeat", syntax_map.keyword_special)
hi("Label", syntax_map.type_name)
hi("Operator", syntax_map.operator)
hi("Keyword", syntax_map.keyword)
hi("Exception", syntax_map.error)
hi("PreProc", syntax_map.preprocessor)
hi("Include", syntax_map.include)
hi("Define", syntax_map.preprocessor)
hi("Macro", syntax_map.preprocessor)
hi("PreCondit", syntax_map.preprocessor)
hi("Type", syntax_map.type_special)
hi("StorageClass", syntax_map.keyword)
hi("Structure", syntax_map.type_special)
hi("Typedef", syntax_map.type_name)
hi("Special", syntax_map.constant)
hi("SpecialChar", syntax_map.punctuation_special)
hi("Tag", syntax_map.tag)
hi("Delimiter", syntax_map.punctuation)
hi("SpecialComment", syntax_map.comment_special)
hi("Debug", syntax_map.debug)
hi("Class", syntax_map.type_special)
hi("Variable", syntax_map.variable)
hi("Property", syntax_map.property_special)
hi("Method", syntax_map.function_name)

---
-- Treesitter
---

-- Annotations and attributes
hi("@annotation", syntax_map.attribute)
hi("@attribute", syntax_map.attribute)
hi("@decorator", syntax_map.attribute)

-- Booleans, characters, and constants
hi("@boolean", syntax_map.constant)
hi("@character", syntax_map.string)
hi("@character.special", syntax_map.string_special)

-- Comments
hi("@comment", syntax_map.comment)
hi("@comment.documentation", syntax_map.comment_special)

-- Control flow
hi("@conditional", syntax_map.keyword_special)
hi("@repeat", syntax_map.keyword_special)
hi("@exception", syntax_map.error)
hi("@keyword", syntax_map.keyword)
hi("@keyword.function", syntax_map.function_name)
hi("@keyword.operator", syntax_map.keyword)
hi("@keyword.return", syntax_map.keyword)

-- Constants and variables
hi("@constant", syntax_map.constant)
hi("@constant.builtin", syntax_map.constant)
hi("@constant.macro", syntax_map.constant_special)
hi("@variable", syntax_map.variable)
hi("@variable.builtin", syntax_map.variable_special)
hi("@parameter", syntax_map.variable)
hi("@parameter.reference", syntax_map.variable)

-- Functions and methods
hi("@function", syntax_map.function_name)
hi("@function.builtin", syntax_map.function_special)
hi("@function.call", syntax_map.function_name)
hi("@function.macro", syntax_map.function_special)
hi("@method", syntax_map.function_name)
hi("@method.call", syntax_map.function_name)
hi("@constructor", syntax_map.type_name)

-- Types and structures
hi("@type", syntax_map.type_name)
hi("@type.builtin", syntax_map.type_name)
hi("@type.definition", syntax_map.type_name)
hi("@type.qualifier", syntax_map.keyword)
hi("@namespace", syntax_map.type_name)
hi("@storageclass", syntax_map.keyword)

-- Properties and fields
hi("@property", syntax_map.property)
hi("@field", syntax_map.property)

-- Strings and numbers
hi("@string", syntax_map.string)
hi("@string.escape", syntax_map.string_special)
hi("@string.regex", syntax_map.string)
hi("@string.special", syntax_map.string_special)
hi("@number", syntax_map.number)
hi("@float", syntax_map.number)

-- Operators and punctuation
hi("@operator", syntax_map.operator)
hi("@punctuation.bracket", syntax_map.punctuation)
hi("@punctuation.delimiter", syntax_map.punctuation)
hi("@punctuation.special", syntax_map.punctuation_special)

-- Special elements
hi("@symbol", syntax_map.constant)
hi("@label", syntax_map.type_name)
hi("@include", syntax_map.include)
hi("@define", syntax_map.preprocessor)
hi("@debug", syntax_map.debug)
hi("@error", syntax_map.error)

-- Tags (HTML/XML)
hi("@tag", syntax_map.tag)
hi("@tag.attribute", syntax_map.tag_attribute)
hi("@tag.delimiter", syntax_map.tag_special)

-- Text elements (Markdown, etc.)
hi("@text", syntax_map.text)
hi("@text.strong", syntax_map.text_bold)
hi("@text.emphasis", syntax_map.text_italic)
hi("@text.underline", syntax_map.text_underline)
hi("@text.strike", syntax_map.text_strike)
hi("@text.title", syntax_map.text_title)
hi("@text.literal", syntax_map.text_code)
hi("@text.uri", syntax_map.text_uri)
hi("@text.math", syntax_map.constant)
hi("@text.environment", syntax_map.keyword)
hi("@text.environment.name", syntax_map.function_name)
hi("@text.reference", syntax_map.constant)
hi("@text.todo", syntax_map.warning)
hi("@text.note", syntax_map.info)
hi("@text.warning", syntax_map.warning)
hi("@text.danger", syntax_map.error)

-- Language-specific highlights
hi("@variable.builtin.vim", syntax_map.variable_special)
hi("@function.builtin.vim", syntax_map.function_special)

-- HTML
hi("@tag.html", syntax_map.tag)
hi("@tag.delimiter.html", syntax_map.tag_special)
hi("@tag.attribute.html", syntax_map.tag_attribute)

-- CSS
hi("@property.css", syntax_map.property_special)
hi("@type.css", syntax_map.keyword)
hi("@string.css", syntax_map.string)
hi("@number.css", syntax_map.property_special)

-- JavaScript/TypeScript
hi("@constructor.javascript", syntax_map.function_special)
hi("@constructor.typescript", syntax_map.function_special)
hi("@variable.builtin.javascript", syntax_map.variable_special)
hi("@variable.builtin.typescript", syntax_map.variable_special)

---
-- LSP
---

-- LSP semantic tokens
hi("@lsp.type.class", syntax_map.type_special)
hi("@lsp.type.comment", syntax_map.comment)
hi("@lsp.type.decorator", syntax_map.attribute)
hi("@lsp.type.enum", syntax_map.type_name)
hi("@lsp.type.enumMember", syntax_map.constant)
hi("@lsp.type.event", syntax_map.error)
hi("@lsp.type.function", syntax_map.function_name)
hi("@lsp.type.interface", syntax_map.type_name)
hi("@lsp.type.keyword", syntax_map.keyword)
hi("@lsp.type.macro", syntax_map.preprocessor)
hi("@lsp.type.method", syntax_map.function_name)
hi("@lsp.type.modifier", syntax_map.attribute)
hi("@lsp.type.namespace", syntax_map.type_name)
hi("@lsp.type.number", syntax_map.number)
hi("@lsp.type.operator", syntax_map.operator)
hi("@lsp.type.parameter", syntax_map.variable)
hi("@lsp.type.property", syntax_map.property_special)
hi("@lsp.type.regexp", syntax_map.string)
hi("@lsp.type.string", syntax_map.string)
hi("@lsp.type.struct", syntax_map.type_special)
hi("@lsp.type.type", syntax_map.type_special)
hi("@lsp.type.typeParameter", syntax_map.type_name)
hi("@lsp.type.variable", syntax_map.variable)

-- Diagnostic highlights
hi("DiagnosticError", { ctermfg = colors.red_strong })
hi("DiagnosticWarn", { ctermfg = colors.yellow_strong })
hi("DiagnosticInfo", { ctermfg = colors.blue_strong })
hi("DiagnosticHint", { ctermfg = colors.cyan_strong })
hi("DiagnosticOk", { ctermfg = colors.green })

-- Diagnostic virtual text
hi("DiagnosticVirtualTextError", { ctermfg = colors.red })
hi("DiagnosticVirtualTextWarn", { ctermfg = colors.yellow })
hi("DiagnosticVirtualTextInfo", { ctermfg = colors.blue })
hi("DiagnosticVirtualTextHint", { ctermfg = colors.cyan })
hi("DiagnosticVirtualTextOk", { ctermfg = colors.green })

-- Diagnostic underlines
hi("DiagnosticUnderlineError", { ctermfg = colors.red, cterm = "underline" })
hi("DiagnosticUnderlineWarn", { ctermfg = colors.yellow, cterm = "underline" })
hi("DiagnosticUnderlineInfo", { ctermfg = colors.blue, cterm = "underline" })
hi("DiagnosticUnderlineHint", { ctermfg = colors.cyan, cterm = "underline" })
hi("DiagnosticUnderlineOk", { ctermfg = colors.green, cterm = "underline" })

-- Diagnostic signs
hi("DiagnosticSignError", { ctermfg = colors.red })
hi("DiagnosticSignWarn", { ctermfg = colors.yellow })
hi("DiagnosticSignInfo", { ctermfg = colors.blue })
hi("DiagnosticSignHint", { ctermfg = colors.cyan })
hi("DiagnosticSignOk", { ctermfg = colors.green })

-- Floating window highlights
hi("DiagnosticFloatingError", { ctermfg = colors.red })
hi("DiagnosticFloatingWarn", { ctermfg = colors.yellow })
hi("DiagnosticFloatingInfo", { ctermfg = colors.blue })
hi("DiagnosticFloatingHint", { ctermfg = colors.cyan })
hi("DiagnosticFloatingOk", { ctermfg = colors.green })

-- LSP signature help
hi("LspSignatureActiveParameter", { ctermfg = colors.green_strong, cterm = "bold" })

-- LSP code lens
hi("LspCodeLens", { ctermfg = colors.bg_soft })
hi("LspCodeLensSeparator", { ctermfg = colors.bg_soft })

-- LSP inlay hints
hi("LspInlayHint", { ctermfg = colors.bg_soft, ctermbg = colors.bg })

---
-- Plugin Mini.icons
---
hi("MiniIconsAzure", { ctermfg = colors.cyan })
hi("MiniIconsBlue", { ctermfg = colors.blue })
hi("MiniIconsCyan", { ctermfg = colors.cyan })
hi("MiniIconsGreen", { ctermfg = colors.green })
hi("MiniIconsGrey", { ctermfg = colors.fg_soft })
hi("MiniIconsOrange", { ctermfg = colors.yellow })
hi("MiniIconsPurple", { ctermfg = colors.magenta })
hi("MiniIconsRed", { ctermfg = colors.red })
hi("MiniIconsYellow", { ctermfg = colors.yellow })

---
-- Plugin Mini.diff
---

hi("MiniDiffSignAdd", { ctermfg = colors.green })
hi("MiniDiffSignChange", { ctermfg = colors.yellow })
hi("MiniDiffSignDelete", { ctermfg = colors.red })
hi("MiniDiffOverAdd", { ctermfg = colors.green, ctermbg = colors.bg_soft })
hi("MiniDiffOverChange", { ctermfg = colors.yellow, ctermbg = colors.bg_soft })
hi("MiniDiffOverDelete", { ctermfg = colors.red, ctermbg = colors.bg_soft })

---
-- Markdown
---

-- Render markdown
hi("RenderMarkdownH1", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownH2", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownH3", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownH4", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownH5", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownH6", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownCode", { ctermbg = colors.bg })
hi("RenderMarkdownCodeInline", { ctermbg = colors.bg })
hi("RenderMarkdownBullet", { ctermfg = colors.blue })
hi("RenderMarkdownTableHead", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownTableRow", { ctermfg = colors.fg_soft })
hi("RenderMarkdownSuccess", { ctermfg = colors.green })
hi("RenderMarkdownInfo", { ctermfg = colors.blue_strong })
hi("RenderMarkdownHint", { ctermfg = colors.cyan_strong })
hi("RenderMarkdownWarn", { ctermfg = colors.yellow_strong })
hi("RenderMarkdownError", { ctermfg = colors.red_strong })
hi("RenderMarkdownQuote", { ctermfg = colors.bg_soft })
hi("RenderMarkdownLink", { ctermfg = colors.green_strong, cterm = "underline" })
hi("RenderMarkdownImage", { ctermfg = colors.red })

---
-- Blink.nvim
---

-- Blink completion menu
hi("BlinkCmpMenu", { ctermfg = colors.fg })
hi("BlinkCmpMenuBorder", { ctermfg = colors.fg })
hi("BlinkCmpMenuSelection", { ctermfg = colors.bg, ctermbg = colors.fg_soft })
hi("BlinkCmpMenuSearchMatch", { ctermfg = colors.bg_soft, ctermbg = colors.yellow })

-- Blink completion items
hi("BlinkCmpLabel", { ctermfg = colors.fg })
hi("BlinkCmpLabelDetail", { ctermfg = colors.bg })
hi("BlinkCmpLabelDescription", { ctermfg = colors.bg_soft })
hi("BlinkCmpLabelMatch", { ctermfg = colors.red })
hi("BlinkCmpLabelDeprecated", { ctermfg = colors.bg_soft, cterm = "strikethrough" })

-- Blink signature help
hi("BlinkCmpSignature", { ctermfg = colors.fg_soft, ctermbg = colors.bg_soft })
hi("BlinkCmpSignatureBorder", { ctermfg = colors.bg_soft, ctermbg = colors.bg_soft })
hi("BlinkCmpSignatureActiveParameter", { ctermfg = colors.red, ctermbg = colors.bg_soft })

-- Blink scrollbar
hi("BlinkCmpScrollbar", { ctermfg = colors.fg, ctermbg = colors.fg })
hi("BlinkCmpScrollbarThumb", { ctermfg = colors.fg_soft, ctermbg = colors.fg })

-- Blink completion ghost text
hi("BlinkCmpGhostText", { ctermfg = colors.bg_soft })

-- Blink completion scrollbar
hi("BlinkCmpScrollbar", { ctermfg = colors.bg_soft, ctermbg = colors.bg_soft })
hi("BlinkCmpScrollbarThumb", { ctermfg = colors.fg_soft, ctermbg = colors.bg_soft })

-- Blink completion signature help
hi("BlinkCmpSignature", { ctermfg = colors.fg_soft })
hi("BlinkCmpSignatureBorder", { ctermfg = colors.fg })
hi("BlinkCmpSignatureActiveParameter", { ctermfg = colors.red })

---
-- IndentBlankLine.nvim
---

-- Indent Blankline v2 (legacy)
hi("IndentBlanklineChar", { ctermfg = colors.bg_soft })
hi("IndentBlanklineContextChar", { ctermfg = colors.blue_strong })
hi("IndentBlanklineContextStart", { cterm = "underline" })
hi("IndentBlanklineSpaceChar", { ctermfg = colors.bg_soft })
hi("IndentBlanklineSpaceCharBlankline", { ctermfg = colors.bg_soft })

-- Indent Blankline v3 (current)
hi("IblIndent", { ctermfg = colors.bg_soft })
hi("IblWhitespace", { ctermfg = colors.bg_soft })
hi("IblScope", { ctermfg = colors.blue_strong })

-- Rainbow indent colors for v3
hi("RainbowDelimiterRed", { ctermfg = colors.red_strong })
hi("RainbowDelimiterYellow", { ctermfg = colors.yellow_strong })
hi("RainbowDelimiterBlue", { ctermfg = colors.blue_strong })
hi("RainbowDelimiterOrange", { ctermfg = colors.green_strong })
hi("RainbowDelimiterGreen", { ctermfg = colors.green })
hi("RainbowDelimiterViolet", { ctermfg = colors.red })
hi("RainbowDelimiterCyan", { ctermfg = colors.green })

-- Indent highlight groups for different nesting levels
hi("IndentLevel1", { ctermfg = colors.bg_soft })
hi("IndentLevel2", { ctermfg = colors.bg_soft })
hi("IndentLevel3", { ctermfg = colors.bg_soft })
hi("IndentLevel4", { ctermfg = colors.bg_soft })
hi("IndentLevel5", { ctermfg = colors.bg_soft })
hi("IndentLevel6", { ctermfg = colors.bg_soft })

-- Context highlighting
hi("IndentContext", { ctermfg = colors.blue_strong })
hi("IndentContextStart", { cterm = "underline" })
hi("IndentContextEnd", { cterm = "underline" })

-- Scope highlighting
hi("IndentScope", { ctermfg = colors.blue_strong })
hi("IndentScopeActive", { ctermfg = colors.blue_strong, cterm = "bold" })
hi("IndentScopeInactive", { ctermfg = colors.bg_soft })

-- Error highlighting
hi("IndentError", { ctermfg = colors.red_strong })
hi("IndentWarning", { ctermfg = colors.yellow_strong })

-- Custom bracket highlighting
hi("IndentBracket", { ctermfg = colors.fg_soft })
hi("IndentBracketActive", { ctermfg = colors.blue_strong, cterm = "bold" })

-- Fold integration
hi("IndentFold", { ctermfg = colors.bg_soft })
hi("IndentFoldActive", { ctermfg = colors.blue_strong })

-- Virtual text
hi("IndentVirtualText", { ctermfg = colors.bg_soft })
hi("IndentVirtualTextActive", { ctermfg = colors.blue_strong })

-- Line highlighting
hi("IndentLine", { ctermfg = colors.bg_soft })
hi("IndentLineActive", { ctermfg = colors.blue_strong })
hi("IndentLineContext", { ctermfg = colors.blue_strong, ctermbg = colors.bg_soft })
