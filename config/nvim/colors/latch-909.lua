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
	if opts.ctermbg then
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
	bg_muted = 8,	-- ansi 8 - bright black
	fg = 15,		-- ansi 15 - bright white
	fg_muted = 7,	-- ansi 7 - white
	red = 1,		-- ansi 1 - red
	red_br = 9,		-- ansi 9 - bright red
	green = 2,		-- ansi 2 - green
	green_br = 10,  -- ansi 10 - bright green
	yellow = 3,		-- ansi 3 - yellow
	yellow_br = 11, -- ansi 11 - bright yellow
	blue = 4,		-- ansi 4 - blue (keywords, info)
	blue_br = 12,   -- ansi 12 - bright blue
	magenta = 5,	-- ansi 5 - magenta
	magenta_br = 13,-- ansi 13 - bright magenta
	cyan = 6,       -- ansi 6 - cyan
	cyan_br = 14,   -- ansi 14 - bright cyan
}

---
-- Semantic syntax map
---

local syntax = {
	-- Comments (muted/gray)
	comment = { ctermfg = colors.fg_muted },
	comment_special = { ctermfg = colors.fg_muted, cterm = "italic" },
	-- Keywords & Control Flow (blue)
	keyword = { ctermfg = colors.blue_br },
	keyword_special = { ctermfg = colors.blue, cterm = "bold" },
	-- Functions & Methods (yellow)
	function_name = { ctermfg = colors.yellow_br },
	function_special = { ctermfg = colors.yellow_br, cterm = "bold" },
	-- Types & Classes (yellow)
	type_name = { ctermfg = colors.yellow },
	type_special = { ctermfg = colors.yellow_br },
	-- Constants (magenta)
	constant = { ctermfg = colors.magenta_br },
	constant_special = { ctermfg = colors.magenta_br, cterm = "bold" },
	-- Variables (neutral)
	variable = { ctermfg = colors.fg },
	variable_special = { ctermfg = colors.yellow_br },
	-- Strings & Characters (green)
	string = { ctermfg = colors.green_br },
	string_special = { ctermfg = colors.green_br, cterm = "bold" },
	-- Numbers (red)
	number = { ctermfg = colors.red_br },
	number_special = { ctermfg = colors.red_br, cterm = "bold" },
	-- Operators & Punctuation (neutral)
	operator = { ctermfg = colors.fg },
	punctuation = { ctermfg = colors.fg },
	punctuation_special = { ctermfg = colors.green_br },
	-- Properties & Fields (cyan)
	property = { ctermfg = colors.cyan },
	property_special = { ctermfg = colors.cyan_br },
	-- Preprocessor & Includes (magenta)
	preprocessor = { ctermfg = colors.magenta_br },
	include = { ctermfg = colors.magenta_br },
	-- Attributes & Annotations (blue)
	attribute = { ctermfg = colors.blue_br },
	attribute_special = { ctermfg = colors.blue, cterm = "italic" },
	-- Text & Markup (neutral with modifiers)
	text = { ctermfg = colors.fg },
	text_bold = { ctermfg = colors.fg_muted, cterm = "bold" },
	text_italic = { ctermfg = colors.fg_muted, cterm = "italic" },
	text_underline = { ctermfg = colors.fg_muted, cterm = "underline" },
	text_strike = { ctermfg = colors.fg_muted, cterm = "strikethrough" },
	text_title = { ctermfg = colors.blue_br },
	text_code = { ctermfg = colors.green },
	text_uri = { ctermfg = colors.green_br, cterm = "underline" },
	-- Tags (HTML/XML)
	tag = { ctermfg = colors.blue_br },
	tag_attribute = { ctermfg = colors.cyan },
	tag_special = { ctermfg = colors.blue },
	-- Special elements (errors, warnings, etc.)
	error = { ctermfg = colors.red_br },
	error_strong = { ctermfg = colors.red_br, cterm = "bold" },
	warning = { ctermfg = colors.yellow_br },
	warning_strong = { ctermfg = colors.yellow_br, cterm = "bold" },
	info = { ctermfg = colors.blue_br },
	info_strong = { ctermfg = colors.blue_br, cterm = "bold" },
	success = { ctermfg = colors.green_br },
	success_strong = { ctermfg = colors.green_br, cterm = "bold" },
}

---
-- Editor interface
---

hi("LineNr", { ctermfg = colors.bg_muted })
hi("StatusLine", { ctermfg = colors.bg, ctermbg = colors.fg_muted, cterm = "none" })
hi("StatusLineNC", { ctermfg = colors.bg_muted, ctermbg = colors.fg_muted, cterm = "none" })
hi("VertSplit", { ctermfg = colors.fg_muted })
hi("SpellBad", { ctermfg = colors.red, cterm = "underline" })
hi("SpellCap", { ctermfg = colors.blue, cterm = "underline" })
hi("SpellLocal", { ctermfg = colors.cyan, cterm = "underline" })
hi("SpellRare", { ctermfg = colors.magenta, cterm = "underline" })

-- Diff highlighting
hi("DiffAdd", syntax.success)
hi("DiffChange", syntax.warning)
hi("DiffDelete", syntax.error)
hi("DiffText", syntax.info)

---
-- Syntax highlights
---

hi("Comment", syntax.comment)
hi("String", syntax.string)
hi("Character", syntax.string)
hi("Number", syntax.number)
hi("Float", syntax.number)
hi("Boolean", syntax.constant)
hi("Constant", syntax.constant)
hi("Identifier", syntax.variable)
hi("Function", syntax.function_name)
hi("Statement", syntax.keyword)
hi("Conditional", syntax.keyword_special)
hi("Repeat", syntax.keyword_special)
hi("Label", syntax.type_name)
hi("Operator", syntax.operator)
hi("Keyword", syntax.keyword)
hi("Exception", syntax.error)
hi("PreProc", syntax.preprocessor)
hi("Include", syntax.include)
hi("Define", syntax.preprocessor)
hi("Macro", syntax.preprocessor)
hi("PreCondit", syntax.preprocessor)
hi("Type", syntax.type_special)
hi("StorageClass", syntax.keyword)
hi("Structure", syntax.type_special)
hi("Typedef", syntax.type_name)
hi("Special", syntax.constant)
hi("SpecialChar", syntax.punctuation_special)
hi("Tag", syntax.tag)
hi("Delimiter", syntax.punctuation)
hi("SpecialComment", syntax.comment_special)
hi("Debug", syntax.warning)
hi("Class", syntax.type_special)
hi("Variable", syntax.variable)
hi("Property", syntax.property_special)
hi("Method", syntax.function_name)

---
-- Treesitter
---

-- Annotations and attributes
hi("@annotation", syntax.attribute)
hi("@attribute", syntax.attribute)
hi("@decorator", syntax.attribute)

-- Booleans, characters, and constants
hi("@boolean", syntax.constant)
hi("@character", syntax.string)
hi("@character.special", syntax.string_special)

-- Comments
hi("@comment", syntax.comment)
hi("@comment.documentation", syntax.comment_special)

-- Control flow
hi("@conditional", syntax.keyword_special)
hi("@repeat", syntax.keyword_special)
hi("@exception", syntax.error)
hi("@keyword", syntax.keyword)
hi("@keyword.function", syntax.function_name)
hi("@keyword.operator", syntax.keyword)
hi("@keyword.return", syntax.keyword)

-- Constants and variables
hi("@constant", syntax.constant)
hi("@constant.builtin", syntax.constant)
hi("@constant.macro", syntax.constant_special)
hi("@variable", syntax.variable)
hi("@variable.builtin", syntax.variable_special)
hi("@parameter", syntax.variable)
hi("@parameter.reference", syntax.variable)

-- Functions and methods
hi("@function", syntax.function_name)
hi("@function.builtin", syntax.function_special)
hi("@function.call", syntax.function_name)
hi("@function.macro", syntax.function_special)
hi("@method", syntax.function_name)
hi("@method.call", syntax.function_name)
hi("@constructor", syntax.type_name)

-- Types and structures
hi("@type", syntax.type_name)
hi("@type.builtin", syntax.type_name)
hi("@type.definition", syntax.type_name)
hi("@type.qualifier", syntax.keyword)
hi("@namespace", syntax.type_name)
hi("@storageclass", syntax.keyword)

-- Properties and fields
hi("@property", syntax.property)
hi("@field", syntax.property)

-- Strings and numbers
hi("@string", syntax.string)
hi("@string.escape", syntax.string_special)
hi("@string.regex", syntax.string)
hi("@string.special", syntax.string_special)
hi("@number", syntax.number)
hi("@float", syntax.number)

-- Operators and punctuation
hi("@operator", syntax.operator)
hi("@punctuation.bracket", syntax.punctuation)
hi("@punctuation.delimiter", syntax.punctuation)
hi("@punctuation.special", syntax.punctuation_special)

-- Special elements
hi("@symbol", syntax.constant)
hi("@label", syntax.type_name)
hi("@include", syntax.include)
hi("@define", syntax.preprocessor)
hi("@debug", syntax.warning)
hi("@error", syntax.error)

-- Tags (HTML/XML)
hi("@tag", syntax.tag)
hi("@tag.attribute", syntax.tag_attribute)
hi("@tag.delimiter", syntax.tag_special)

-- Text elements (Markdown, etc.)
hi("@text", syntax.text)
hi("@text.strong", syntax.text_bold)
hi("@text.emphasis", syntax.text_italic)
hi("@text.underline", syntax.text_underline)
hi("@text.strike", syntax.text_strike)
hi("@text.title", syntax.text_title)
hi("@text.literal", syntax.text_code)
hi("@text.uri", syntax.text_uri)
hi("@text.math", syntax.constant)
hi("@text.environment", syntax.keyword)
hi("@text.environment.name", syntax.function_name)
hi("@text.reference", syntax.constant)
hi("@text.todo", syntax.warning)
hi("@text.note", syntax.info)
hi("@text.warning", syntax.warning)
hi("@text.danger", syntax.error)

-- Language-specific highlights
hi("@variable.builtin.vim", syntax.variable_special)
hi("@function.builtin.vim", syntax.function_special)

-- HTML
hi("@tag.html", syntax.tag)
hi("@tag.delimiter.html", syntax.tag_special)
hi("@tag.attribute.html", syntax.tag_attribute)

-- CSS
hi("@property.css", syntax.property_special)
hi("@type.css", syntax.keyword)
hi("@string.css", syntax.string)
hi("@number.css", syntax.property_special)

-- JavaScript/TypeScript
hi("@constructor.javascript", syntax.function_special)
hi("@constructor.typescript", syntax.function_special)
hi("@variable.builtin.javascript", syntax.variable_special)
hi("@variable.builtin.typescript", syntax.variable_special)

---
-- LSP
---

-- LSP semantic tokens
hi("@lsp.type.class", syntax.type_special)
hi("@lsp.type.comment", syntax.comment)
hi("@lsp.type.decorator", syntax.attribute)
hi("@lsp.type.enum", syntax.type_name)
hi("@lsp.type.enumMember", syntax.constant)
hi("@lsp.type.event", syntax.error)
hi("@lsp.type.function", syntax.function_name)
hi("@lsp.type.interface", syntax.type_name)
hi("@lsp.type.keyword", syntax.keyword)
hi("@lsp.type.macro", syntax.preprocessor)
hi("@lsp.type.method", syntax.function_name)
hi("@lsp.type.modifier", syntax.attribute)
hi("@lsp.type.namespace", syntax.type_name)
hi("@lsp.type.number", syntax.number)
hi("@lsp.type.operator", syntax.operator)
hi("@lsp.type.parameter", syntax.variable)
hi("@lsp.type.property", syntax.property_special)
hi("@lsp.type.regexp", syntax.string)
hi("@lsp.type.string", syntax.string)
hi("@lsp.type.struct", syntax.type_special)
hi("@lsp.type.type", syntax.type_special)
hi("@lsp.type.typeParameter", syntax.type_name)
hi("@lsp.type.variable", syntax.variable)

-- Diagnostic highlights
hi("DiagnosticError", syntax.error)
hi("DiagnosticWarn", syntax.warning)
hi("DiagnosticInfo", syntax.info)
hi("DiagnosticHint", syntax.info)
hi("DiagnosticOk", syntax.success)

-- Diagnostic virtual text
hi("DiagnosticVirtualTextError", syntax.error)
hi("DiagnosticVirtualTextWarn", syntax.warning)
hi("DiagnosticVirtualTextInfo", syntax.info)
hi("DiagnosticVirtualTextHint", syntax.info)
hi("DiagnosticVirtualTextOk", syntax.success)

-- Diagnostic underlines
hi("DiagnosticUnderlineError", { ctermfg = colors.red, cterm = "underline" })
hi("DiagnosticUnderlineWarn", { ctermfg = colors.yellow, cterm = "underline" })
hi("DiagnosticUnderlineInfo", { ctermfg = colors.blue, cterm = "underline" })
hi("DiagnosticUnderlineHint", { ctermfg = colors.cyan, cterm = "underline" })
hi("DiagnosticUnderlineOk", { ctermfg = colors.green, cterm = "underline" })

-- Diagnostic signs
hi("DiagnosticSignError", syntax.error_strong)
hi("DiagnosticSignWarn", syntax.warning_strong)
hi("DiagnosticSignInfo", syntax.info_strong)
hi("DiagnosticSignHint", syntax.info_strong)
hi("DiagnosticSignOk", syntax.success_strong)

-- Floating window highlights
hi("DiagnosticFloatingError", syntax.error)
hi("DiagnosticFloatingWarn", syntax.warning)
hi("DiagnosticFloatingInfo", syntax.info)
hi("DiagnosticFloatingHint", syntax.info)
hi("DiagnosticFloatingOk", syntax.success)

-- LSP signature help
hi("LspSignatureActiveParameter", { ctermfg = colors.green_br, cterm = "bold" })

-- LSP code lens
hi("LspCodeLens", { ctermfg = colors.bg_muted })
hi("LspCodeLensSeparator", { ctermfg = colors.bg_muted })

-- LSP inlay hints
hi("LspInlayHint", { ctermfg = colors.bg_muted, ctermbg = colors.bg })

---
-- Plugin Mini.icons
---
hi("MiniIconsAzure", { ctermfg = colors.cyan })
hi("MiniIconsBlue", { ctermfg = colors.blue })
hi("MiniIconsCyan", { ctermfg = colors.cyan })
hi("MiniIconsGreen", { ctermfg = colors.green })
hi("MiniIconsGrey", { ctermfg = colors.fg_muted })
hi("MiniIconsOrange", { ctermfg = colors.yellow })
hi("MiniIconsPurple", { ctermfg = colors.magenta })
hi("MiniIconsRed", { ctermfg = colors.red })
hi("MiniIconsYellow", { ctermfg = colors.yellow })

---
-- Plugin Mini.diff
---
hi("MiniDiffSignAdd", syntax.success)
hi("MiniDiffSignChange", syntax.warning)
hi("MiniDiffSignDelete", syntax.error)
hi("MiniDiffOverAdd", syntax.success)
hi("MiniDiffOverChange", syntax.warning)
hi("MiniDiffOverDelete", syntax.error)

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
hi("RenderMarkdownTableRow", { ctermfg = colors.blue })
hi("RenderMarkdownSuccess", { ctermfg = colors.green })
hi("RenderMarkdownInfo", { ctermfg = colors.blue_br })
hi("RenderMarkdownHint", { ctermfg = colors.cyan_br })
hi("RenderMarkdownWarn", { ctermfg = colors.yellow_br })
hi("RenderMarkdownError", { ctermfg = colors.red_br })
hi("RenderMarkdownQuote", { ctermfg = colors.bg_muted })
hi("RenderMarkdownLink", { ctermfg = colors.green_br, cterm = "underline" })
hi("RenderMarkdownImage", { ctermfg = colors.red })

---
-- Blink.nvim
---

-- Blink completion menu
hi("BlinkCmpMenu", { ctermfg = colors.fg })
hi("BlinkCmpMenuBorder", { ctermfg = colors.fg })
hi("BlinkCmpMenuSelection", { ctermfg = colors.bg, ctermbg = colors.fg_muted })
hi("BlinkCmpMenuSearchMatch", { ctermfg = colors.bg_muted, ctermbg = colors.yellow })

-- Blink completion items
hi("BlinkCmpLabel", { ctermfg = colors.fg })
hi("BlinkCmpLabelDetail", { ctermfg = colors.bg })
hi("BlinkCmpLabelDescription", { ctermfg = colors.bg_muted })
hi("BlinkCmpLabelMatch", { ctermfg = colors.red })
hi("BlinkCmpLabelDeprecated", { ctermfg = colors.bg_muted, cterm = "strikethrough" })

-- Blink signature help
hi("BlinkCmpSignature", { ctermfg = colors.fg_muted, ctermbg = colors.bg_muted })
hi("BlinkCmpSignatureBorder", { ctermfg = colors.bg_muted, ctermbg = colors.bg_muted })
hi("BlinkCmpSignatureActiveParameter", { ctermfg = colors.red, ctermbg = colors.bg_muted })

-- Blink scrollbar
hi("BlinkCmpScrollbar", { ctermfg = colors.fg, ctermbg = colors.fg })
hi("BlinkCmpScrollbarThumb", { ctermfg = colors.fg_muted, ctermbg = colors.fg })

-- Blink completion ghost text
hi("BlinkCmpGhostText", { ctermfg = colors.bg_muted })

-- Blink completion scrollbar
hi("BlinkCmpScrollbar", { ctermfg = colors.bg_muted, ctermbg = colors.bg_muted })
hi("BlinkCmpScrollbarThumb", { ctermfg = colors.fg_muted, ctermbg = colors.bg_muted })

-- Blink completion signature help
hi("BlinkCmpSignature", { ctermfg = colors.fg_muted })
hi("BlinkCmpSignatureBorder", { ctermfg = colors.fg })
hi("BlinkCmpSignatureActiveParameter", { ctermfg = colors.red })

---
-- IndentBlankLine.nvim
---

-- Indent Blankline v3 (current)
hi("IblIndent", { ctermfg = colors.bg_muted })
hi("IblWhitespace", { ctermfg = colors.bg_muted })
hi("IblScope", { ctermfg = colors.blue_br })

-- Indent highlight groups for different nesting levels
hi("IndentLevel1", { ctermfg = colors.bg_muted })
hi("IndentLevel2", { ctermfg = colors.bg_muted })
hi("IndentLevel3", { ctermfg = colors.bg_muted })
hi("IndentLevel4", { ctermfg = colors.bg_muted })
hi("IndentLevel5", { ctermfg = colors.bg_muted })
hi("IndentLevel6", { ctermfg = colors.bg_muted })
