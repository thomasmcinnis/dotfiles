vim.cmd("highlight clear")
vim.g.colors_name = "theme"
vim.opt.background = dark
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
		cmd = cmd .. " cterm=" .. opts.cterm
	end
	-- Execute the highlight command
	vim.cmd(cmd)
end

---
-- Color definitions
---

local colors = {
	black = 0,      -- ansi 0 - background
	red = 1,        -- ansi 1 - red (errors, functions)
	green = 2,      -- ansi 2 - green (strings, added)
	yellow = 3,     -- ansi 3 - yellow (types, warnings)
	blue = 4,       -- ansi 4 - blue (keywords, info)
	magenta = 5,    -- ansi 5 - magenta (constants)
	cyan = 6,       -- ansi 6 - cyan (special)
	white = 7,      -- ansi 7 - foreground
	br_black = 8,   -- ansi 8 - bright black (comments)
	br_red = 9,     -- ansi 9 - bright red
	br_green = 10,  -- ansi 10 - bright green
	br_yellow = 11, -- ansi 11 - bright yellow
	br_blue = 12,   -- ansi 12 - bright blue
	br_magenta = 13, -- ansi 13 - bright magenta
	br_cyan = 14,   -- ansi 14 - bright cyan
	br_white = 15,  -- ansi 15 - bright white
}

---
-- Editor interface
---

hi("LineNr", { ctermfg = colors.br_black })
hi("StatusLine", { cterm = "underline" })
hi("StatusLineNC", { cterm = "underline" })
hi("SpellBad", { ctermfg = colors.red, cterm = "underline" })
hi("SpellCap", { ctermfg = colors.blue, cterm = "underline" })
hi("SpellLocal", { ctermfg = colors.cyan, cterm = "underline" })
hi("SpellRare", { ctermfg = colors.magenta, cterm = "underline" })


---
-- Syntax highlights
---

hi("Comment", { ctermfg = colors.br_black })
hi("String", { ctermfg = colors.br_green })
hi("Character", { ctermfg = colors.br_green })
hi("Number", { ctermfg = colors.br_cyan })
hi("Float", { ctermfg = colors.cyan })
hi("Boolean", { ctermfg = colors.red })
hi("Constant", { ctermfg = colors.magenta })
hi("Identifier", { ctermfg = colors.white })
hi("Function", { ctermfg = colors.red, cterm = "bold" })
hi("Statement", { ctermfg = colors.blue, cterm = "bold" })
hi("Conditional", { ctermfg = colors.blue })
hi("Repeat", { ctermfg = colors.blue })
hi("Label", { ctermfg = colors.blue })
hi("Operator", { ctermfg = colors.white })
hi("Keyword", { ctermfg = colors.blue, cterm = "bold" })
hi("Exception", { ctermfg = colors.red })
hi("PreProc", { ctermfg = colors.br_magenta })
hi("Include", { ctermfg = colors.br_magenta })
hi("Define", { ctermfg = colors.br_magenta })
hi("Macro", { ctermfg = colors.br_magenta })
hi("PreCondit", { ctermfg = colors.br_magenta })
hi("Type", { ctermfg = colors.yellow, cterm = "bold" })
hi("StorageClass", { ctermfg = colors.yellow })
hi("Structure", { ctermfg = colors.yellow })
hi("Typedef", { ctermfg = colors.yellow })
hi("Special", { ctermfg = colors.cyan })
hi("SpecialChar", { ctermfg = colors.br_cyan })
hi("Tag", { ctermfg = colors.red })
hi("Delimiter", { ctermfg = colors.br_black })
hi("SpecialComment", { ctermfg = colors.br_yellow })
hi("Debug", { ctermfg = colors.br_red })
hi("Class", { ctermfg = colors.yellow, cterm = "bold" })
hi("Variable", { ctermfg = colors.white })
hi("Property", { ctermfg = colors.cyan })
hi("Method", { ctermfg = colors.red })

---
-- LSP
---

-- LSP semantic tokens
hi("@lsp.type.class", { ctermfg = colors.yellow })
hi("@lsp.type.comment", { ctermfg = colors.br_black })
hi("@lsp.type.decorator", { ctermfg = colors.blue })
hi("@lsp.type.enum", { ctermfg = colors.yellow })
hi("@lsp.type.enumMember", { ctermfg = colors.magenta })
hi("@lsp.type.event", { ctermfg = colors.red })
hi("@lsp.type.function", { ctermfg = colors.red })
hi("@lsp.type.interface", { ctermfg = colors.yellow })
hi("@lsp.type.keyword", { ctermfg = colors.blue })
hi("@lsp.type.macro", { ctermfg = colors.blue })
hi("@lsp.type.method", { ctermfg = colors.red })
hi("@lsp.type.modifier", { ctermfg = colors.blue })
hi("@lsp.type.namespace", { ctermfg = colors.yellow })
hi("@lsp.type.number", { ctermfg = colors.cyan })
hi("@lsp.type.operator", { ctermfg = colors.white })
hi("@lsp.type.parameter", { ctermfg = colors.white })
hi("@lsp.type.property", { ctermfg = colors.cyan })
hi("@lsp.type.regexp", { ctermfg = colors.green })
hi("@lsp.type.string", { ctermfg = colors.green })
hi("@lsp.type.struct", { ctermfg = colors.yellow })
hi("@lsp.type.type", { ctermfg = colors.yellow })
hi("@lsp.type.typeParameter", { ctermfg = colors.yellow })
hi("@lsp.type.variable", { ctermfg = colors.white })

-- Diagnostic highlights
hi("DiagnosticError", { ctermfg = colors.br_red })
hi("DiagnosticWarn", { ctermfg = colors.br_yellow })
hi("DiagnosticInfo", { ctermfg = colors.br_blue })
hi("DiagnosticHint", { ctermfg = colors.br_cyan })
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

-- LSP references
-- hi("LspReferenceText", { ctermbg = colors.br_black })
-- hi("LspReferenceRead", { ctermbg = colors.br_black })
-- hi("LspReferenceWrite", { ctermbg = colors.br_black })

-- LSP signature help
hi("LspSignatureActiveParameter", { ctermfg = colors.br_green, cterm = "bold" })

-- LSP code lens
hi("LspCodeLens", { ctermfg = colors.br_black })
hi("LspCodeLensSeparator", { ctermfg = colors.br_black })

-- LSP inlay hints
hi("LspInlayHint", { ctermfg = colors.br_black, ctermbg = colors.black })

---
-- Plugin Mini.icons
---
hi("MiniIconsAzure", { ctermfg = colors.br_cyan })
hi("MiniIconsBlue", { ctermfg = colors.blue })
hi("MiniIconsCyan", { ctermfg = colors.cyan })
hi("MiniIconsGreen", { ctermfg = colors.green })
hi("MiniIconsGrey", { ctermfg = colors.br_black })
hi("MiniIconsOrange", { ctermfg = colors.yellow })
hi("MiniIconsPurple", { ctermfg = colors.magenta })
hi("MiniIconsRed", { ctermfg = colors.red })
hi("MiniIconsYellow", { ctermfg = colors.br_yellow })

---
-- Plugin Mini.diff
---

hi("MiniDiffSignAdd", { ctermfg = colors.green })
hi("MiniDiffSignChange", { ctermfg = colors.yellow })
hi("MiniDiffSignDelete", { ctermfg = colors.red })
hi("MiniDiffOverAdd", { ctermfg = colors.green, ctermbg = colors.br_black })
hi("MiniDiffOverChange", { ctermfg = colors.yellow, ctermbg = colors.br_black })
hi("MiniDiffOverDelete", { ctermfg = colors.red, ctermbg = colors.br_black })

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
hi("RenderMarkdownCode", { ctermbg = colors.black })
hi("RenderMarkdownCodeInline", { ctermbg = colors.black })
hi("RenderMarkdownBullet", { ctermfg = colors.blue })
hi("RenderMarkdownTableHead", { ctermfg = colors.blue, cterm = "bold" })
hi("RenderMarkdownTableRow", { ctermfg = colors.white })
hi("RenderMarkdownSuccess", { ctermfg = colors.green })
hi("RenderMarkdownInfo", { ctermfg = colors.br_blue })
hi("RenderMarkdownHint", { ctermfg = colors.br_cyan })
hi("RenderMarkdownWarn", { ctermfg = colors.br_yellow })
hi("RenderMarkdownError", { ctermfg = colors.br_red })
hi("RenderMarkdownQuote", { ctermfg = colors.br_black })
hi("RenderMarkdownLink", { ctermfg = colors.br_green, cterm = "underline" })
hi("RenderMarkdownImage", { ctermfg = colors.red })

---
-- Blink.nvim
---

-- Blink completion menu
hi("BlinkCmpMenu", { ctermfg = colors.white })
hi("BlinkCmpMenuBorder", { ctermfg = colors.br_white })
hi("BlinkCmpMenuSelection", { ctermfg = colors.black, ctermbg = colors.br_white })
hi("BlinkCmpMenuSearchMatch", { ctermfg = colors.black, ctermbg = colors.yellow })

-- Blink completion items
hi("BlinkCmpLabel", { ctermfg = colors.white })
hi("BlinkCmpLabelDetail", { ctermfg = colors.br_black })
hi("BlinkCmpLabelDescription", { ctermfg = colors.br_black })
hi("BlinkCmpLabelMatch", { ctermfg = colors.red })
hi("BlinkCmpLabelDeprecated", { ctermfg = colors.br_black, cterm = "strikethrough" })

-- Blink signature help
hi("BlinkCmpSignature", { ctermfg = colors.white, ctermbg = colors.br_black })
hi("BlinkCmpSignatureBorder", { ctermfg = colors.br_black, ctermbg = colors.br_black })
hi("BlinkCmpSignatureActiveParameter", { ctermfg = colors.red, ctermbg = colors.br_black })

-- Blink scrollbar
hi("BlinkCmpScrollbar", { ctermfg = colors.br_white, ctermbg = colors.br_white })
hi("BlinkCmpScrollbarThumb", { ctermfg = colors.white, ctermbg = colors.br_white })

-- Blink completion ghost text
hi("BlinkCmpGhostText", { ctermfg = colors.br_black })

-- Blink completion scrollbar
hi("BlinkCmpScrollbar", { ctermfg = colors.br_black, ctermbg = colors.br_black })
hi("BlinkCmpScrollbarThumb", { ctermfg = colors.white, ctermbg = colors.br_black })

-- Blink completion signature help
hi("BlinkCmpSignature", { ctermfg = colors.white })
hi("BlinkCmpSignatureBorder", { ctermfg = colors.br_white })
hi("BlinkCmpSignatureActiveParameter", { ctermfg = colors.red })

-- Blink completion fuzzy matching
-- hi("BlinkCmpFuzzy", { ctermfg = colors.red, cterm = "bold" })
-- hi("BlinkCmpFuzzyMatch", { ctermfg = colors.black, ctermbg = colors.yellow })

-- Blink completion preview
-- hi("BlinkCmpPreview", { ctermfg = colors.white, ctermbg = colors.br_black })
-- hi("BlinkCmpPreviewBorder", { ctermfg = colors.br_black })
-- hi("BlinkCmpPreviewTitle", { ctermfg = colors.red, cterm = "bold" })
--

---
-- Treesitter
---

-- Treesitter highlights
hi("@annotation", { ctermfg = colors.blue })
hi("@attribute", { ctermfg = colors.blue })
hi("@boolean", { ctermfg = colors.red })
hi("@character", { ctermfg = colors.green })
hi("@character.special", { ctermfg = colors.br_green })

-- Comments
hi("@comment", { ctermfg = colors.br_black, cterm = "italic" })
hi("@comment.documentation", { ctermfg = colors.br_black, cterm = "italic" })

-- Control flow
hi("@conditional", { ctermfg = colors.blue, cterm = "bold" })
hi("@repeat", { ctermfg = colors.blue, cterm = "bold" })
hi("@exception", { ctermfg = colors.blue })
hi("@keyword", { ctermfg = colors.blue })
hi("@keyword.function", { ctermfg = colors.blue })
hi("@keyword.operator", { ctermfg = colors.blue })
hi("@keyword.return", { ctermfg = colors.blue })

-- Constants and variables
hi("@constant", { ctermfg = colors.magenta })
hi("@constant.builtin", { ctermfg = colors.magenta })
hi("@constant.macro", { ctermfg = colors.magenta })
hi("@variable", { ctermfg = colors.white })
hi("@variable.builtin", { ctermfg = colors.yellow })
hi("@parameter", { ctermfg = colors.white })
hi("@parameter.reference", { ctermfg = colors.white })

-- Functions and methods
hi("@function", { ctermfg = colors.red })
hi("@function.builtin", { ctermfg = colors.red, cterm = "bold" })
hi("@function.call", { ctermfg = colors.red })
hi("@function.macro", { ctermfg = colors.red, cterm = "bold" })
hi("@method", { ctermfg = colors.red })
hi("@method.call", { ctermfg = colors.red })
hi("@constructor", { ctermfg = colors.yellow })

-- Types and structures
hi("@type", { ctermfg = colors.yellow })
hi("@type.builtin", { ctermfg = colors.yellow })
hi("@type.definition", { ctermfg = colors.yellow })
hi("@type.qualifier", { ctermfg = colors.blue })
hi("@namespace", { ctermfg = colors.yellow })
hi("@storageclass", { ctermfg = colors.blue })

-- Properties and fields
hi("@property", { ctermfg = colors.cyan })
hi("@field", { ctermfg = colors.cyan })

-- Strings and numbers
hi("@string", { ctermfg = colors.green })
hi("@string.escape", { ctermfg = colors.br_green, cterm = "bold" })
hi("@string.regex", { ctermfg = colors.green })
hi("@string.special", { ctermfg = colors.br_green })
hi("@number", { ctermfg = colors.cyan })
hi("@float", { ctermfg = colors.cyan })

-- Operators and punctuation
hi("@operator", { ctermfg = colors.white })
hi("@punctuation.bracket", { ctermfg = colors.white })
hi("@punctuation.delimiter", { ctermfg = colors.white })
hi("@punctuation.special", { ctermfg = colors.br_green })

-- Special elements
hi("@symbol", { ctermfg = colors.magenta })
hi("@label", { ctermfg = colors.yellow })
hi("@include", { ctermfg = colors.blue, cterm = italic })
hi("@define", { ctermfg = colors.blue })
hi("@debug", { ctermfg = colors.br_red })
hi("@error", { ctermfg = colors.br_red })

-- Tags (HTML/XML)
hi("@tag", { ctermfg = colors.blue })
hi("@tag.attribute", { ctermfg = colors.cyan })
hi("@tag.delimiter", { ctermfg = colors.white })

-- Text elements (Markdown, etc.)
hi("@text", { ctermfg = colors.white })
hi("@text.strong", { ctermfg = colors.white, cterm = "bold" })
hi("@text.emphasis", { ctermfg = colors.white, cterm = italic })
hi("@text.underline", { ctermfg = colors.white, cterm = "underline" })
hi("@text.strike", { ctermfg = colors.white, cterm = "strikethrough" })
hi("@text.title", { ctermfg = colors.blue, cterm = "bold" })
hi("@text.literal", { ctermfg = colors.green })
hi("@text.uri", { ctermfg = colors.br_green, cterm = "underline" })
hi("@text.math", { ctermfg = colors.cyan })
hi("@text.environment", { ctermfg = colors.blue })
hi("@text.environment.name", { ctermfg = colors.yellow })
hi("@text.reference", { ctermfg = colors.cyan })
hi("@text.todo", { ctermfg = colors.br_black, cterm = "bold" })
hi("@text.note", { ctermfg = colors.br_blue, cterm = "bold" })
hi("@text.warning", { ctermfg = colors.br_yellow, cterm = "bold" })
hi("@text.danger", { ctermfg = colors.br_red, cterm = "bold" })

-- Language-specific highlights
hi("@variable.builtin.vim", { ctermfg = colors.yellow })
hi("@function.builtin.vim", { ctermfg = colors.red })

-- HTML
hi("@tag.html", { ctermfg = colors.blue })
hi("@tag.delimiter.html", { ctermfg = colors.white })
hi("@tag.attribute.html", { ctermfg = colors.cyan })

-- CSS
hi("@property.css", { ctermfg = colors.cyan })
hi("@type.css", { ctermfg = colors.blue })
hi("@string.css", { ctermfg = colors.green })
hi("@number.css", { ctermfg = colors.cyan })

-- JavaScript/TypeScript
hi("@constructor.javascript", { ctermfg = colors.yellow })
hi("@constructor.typescript", { ctermfg = colors.yellow })
hi("@variable.builtin.javascript", { ctermfg = colors.yellow })
hi("@variable.builtin.typescript", { ctermfg = colors.yellow })

---
-- IndentBlankLine.nvim
---

-- Indent Blankline v2 (legacy)
hi("IndentBlanklineChar", { ctermfg = colors.br_black })
hi("IndentBlanklineContextChar", { ctermfg = colors.br_blue })
hi("IndentBlanklineContextStart", { cterm = "underline" })
hi("IndentBlanklineSpaceChar", { ctermfg = colors.br_black })
hi("IndentBlanklineSpaceCharBlankline", { ctermfg = colors.br_black })

-- Indent Blankline v3 (current)
hi("IblIndent", { ctermfg = colors.br_black })
hi("IblWhitespace", { ctermfg = colors.br_black })
hi("IblScope", { ctermfg = colors.br_blue })

-- Rainbow indent colors for v3
hi("RainbowDelimiterRed", { ctermfg = colors.br_red })
hi("RainbowDelimiterYellow", { ctermfg = colors.br_yellow })
hi("RainbowDelimiterBlue", { ctermfg = colors.br_blue })
hi("RainbowDelimiterOrange", { ctermfg = colors.br_green })
hi("RainbowDelimiterGreen", { ctermfg = colors.green })
hi("RainbowDelimiterViolet", { ctermfg = colors.red })
hi("RainbowDelimiterCyan", { ctermfg = colors.green })

-- Indent highlight groups for different nesting levels
hi("IndentLevel1", { ctermfg = colors.br_black })
hi("IndentLevel2", { ctermfg = colors.br_black })
hi("IndentLevel3", { ctermfg = colors.br_black })
hi("IndentLevel4", { ctermfg = colors.br_black })
hi("IndentLevel5", { ctermfg = colors.br_black })
hi("IndentLevel6", { ctermfg = colors.br_black })

-- Context highlighting
hi("IndentContext", { ctermfg = colors.br_blue })
hi("IndentContextStart", { cterm = "underline" })
hi("IndentContextEnd", { cterm = "underline" })

-- Scope highlighting
hi("IndentScope", { ctermfg = colors.br_blue })
hi("IndentScopeActive", { ctermfg = colors.br_blue, cterm = "bold" })
hi("IndentScopeInactive", { ctermfg = colors.br_black })

-- Error highlighting
hi("IndentError", { ctermfg = colors.br_red })
hi("IndentWarning", { ctermfg = colors.br_yellow })

-- Custom bracket highlighting
hi("IndentBracket", { ctermfg = colors.white })
hi("IndentBracketActive", { ctermfg = colors.br_blue, cterm = "bold" })

-- Fold integration
hi("IndentFold", { ctermfg = colors.br_black })
hi("IndentFoldActive", { ctermfg = colors.br_blue })

-- Virtual text
hi("IndentVirtualText", { ctermfg = colors.br_black })
hi("IndentVirtualTextActive", { ctermfg = colors.br_blue })

-- Line highlighting
hi("IndentLine", { ctermfg = colors.br_black })
hi("IndentLineActive", { ctermfg = colors.br_blue })
hi("IndentLineContext", { ctermfg = colors.br_blue, ctermbg = colors.br_black })
