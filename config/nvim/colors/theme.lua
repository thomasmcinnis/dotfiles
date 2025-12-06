-- This theme maps the 16 ansi terminal colours to nvim highlight groups.
-- No other color values are used. This enables the appearance of nvim to reflect
-- the current selected terminal theme (dark or light) without coordination.
--
-- The theme assumes that 'black' is intended as the background color, 'white' is the
-- foreground color, and their respective 'bright' values an intermediate surface.
--
-- Syntax highlighting primarily uses the normal color variants, with bright 
-- reserved for certain diagnostic ui only.

vim.cmd("highlight clear")
vim.g.colors_name = "theme"
vim.opt.background = "dark"
vim.opt.termguicolors = false

local palette = {
	black = 0, -- ansi 0 - black
	black_br = 8, -- ansi 8 - bright black
	white = 7, -- ansi 7 - white
	white_br = 15, -- ansi 15 - bright white
	red = 1,  -- ansi 1 - red
	red_br = 9, -- ansi 9 - bright red
	green = 2, -- ansi 2 - green
	green_br = 10, -- ansi 10 - bright green
	yellow = 3, -- ansi 3 - yellow
	yellow_br = 11, -- ansi 11 - bright yellow
	blue = 4, -- ansi 4 - blue (keywords, info)
	blue_br = 12, -- ansi 12 - bright blue
	magenta = 5, -- ansi 5 - magenta
	magenta_br = 13, -- ansi 13 - bright magenta
	cyan = 6, -- ansi 6 - cyan
	cyan_br = 14, -- ansi 14 - bright cyan
}

local theme = {
	ui = {
		fg_0 = palette.white_br,
		fg_1 = palette.white,
		fg_reverse = palette.black,
		bg_0 = palette.black,
		bg_1 = palette.black_br,
		bg_search = palette.black_br,
	},
	diff = {
		add = palette.green,
		delete = palette.red,
		change = palette.blue,
		text = palette.yellow,
	},
	diag = {
		ok = palette.green_br,
		error = palette.red_br,
		warning = palette.yellow_br,
		info = palette.blue_br,
		hint = palette.cyan_br,
	},
	syn = {
		str = palette.green,
		var = "none",
		number = palette.cyan,
		constant = "none",
		identifier = "none",
		parameter = palette.blue,
		fun = palette.blue,
		statement = palette.blue,
		keyword = palette.blue,
		operator = "none",
		preproc = palette.red,
		type = palette.cyan,
		regex = palette.yellow,
		deprecated = palette.white,
		comment = palette.yellow,
		punct = palette.magenta,
		special1 = palette.magenta,
		special2 = palette.red,
	}
}

local bindings = {
	editor = {
		CursorLine = { ctermfg = theme.ui.bg_0, ctermbg = theme.ui.fg_1 },
		CurSearch = { ctermfg = palette.red_br, ctermbg = theme.ui.bg_search },
		Search = { link = "CurSearch" },

		DiagnosticError = { ctermfg = theme.diag.error },
		DiagnosticWarn = { ctermfg = theme.diag.warning },
		DiagnosticInfo = { ctermfg = theme.diag.info },
		DiagnosticHint = { ctermfg = theme.diag.hint },
		DiagnosticOk = { ctermfg = theme.diag.ok },

		DiagnosticFloatingError = { ctermfg = theme.diag.error },
		DiagnosticFloatingWarn = { ctermfg = theme.diag.warning },
		DiagnosticFloatingInfo = { ctermfg = theme.diag.info },
		DiagnosticFloatingHint = { ctermfg = theme.diag.hint },
		DiagnosticFloatingOk = { ctermfg = theme.diag.ok },

		DiagnosticSignError = { ctermfg = theme.diag.error },
		DiagnosticSignWarn = { ctermfg = theme.diag.warning },
		DiagnosticSignInfo = { ctermfg = theme.diag.info },
		DiagnosticSignHint = { ctermfg = theme.diag.hint },

		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },

		DiffAdd = { ctermfg = theme.diff.add },
		DiffChange = { ctermfg = theme.diff.change },
		DiffDelete = { ctermfg = theme.diff.delete },
		DiffText = { ctermfg = theme.diff.text },

		-- The ~ char filling the empty lines
		EndOfBuffer = { ctermfg = theme.ui.bg_0 },
		ErrorMsg = { ctermfg = theme.diag.error },
		WarningMsg = { ctermfg = theme.diag.warning },
		LineNr = { ctermfg = theme.ui.bg_1 },
		MatchParen = { ctermfg = theme.diag.error, cterm = { bold = true } },
		NonText = { ctermfg = theme.ui.bg_1 },

		StatusLine = { ctermfg = theme.ui.fg_0, ctermbg = theme.ui.bg_1, cterm = {} },
		StatusLineNC = { ctermfg = theme.ui.fg_1, ctermbg = theme.ui.bg_1, cterm = {} },

		SpellBad = { ctermfg = theme.diag.warning, cterm = { underline = true } },
		SpellCap = { ctermfg = theme.diag.warning, cterm = { underline = true } },
		SpellLocal = { ctermfg = theme.diag.hint, cterm = { underline = true } },
		SpellRare = { ctermfg = theme.diag.info, cterm = { underline = true } },

		WinSeparator = { ctermfg = theme.ui.bg_1 },
		VertSplit = { link = "WinSeparator" },

		LspCodeLens = { ctermfg = theme.ui.bg_1 },
		LspCodeLensSeparator = { ctermfg = theme.ui.bg_1 },
		LspInlayHint = { ctermfg = theme.ui.bg_1, ctermbg = theme.ui.bg_0 },
		LspSignatureActiveParameter = { ctermfg = theme.diag.success, cterm = { bold = true } },

	},
	syntax = {
		Comment = { ctermfg = theme.syn.comment },
		Constant = { ctermfg = theme.syn.constant },
		String = { ctermfg = theme.syn.str },
		Character = { ctermfg = theme.syn.str },
		Boolean = { ctermfg = theme.syn.special2 },
		Number = { ctermfg = theme.syn.number },
		Float = { link = "Number" },
		Identifier = { ctermfg = theme.syn.var },
		Function = { ctermfg = theme.syn.fun },
		Statement = { ctermfg = theme.syn.keyword },
		-- Conditional
		-- Repeat
		-- Label
		Operator = { ctermfg = theme.syn.operator },
		Keyword = { ctermfg = theme.syn.keyword },
		Exception = { ctermfg = theme.syn.special1 },
		PreProc = { ctermfg = theme.syn.preproc },
		-- Include
		-- Define
		-- Macro
		-- PreCondit
		Type = { ctermfg = theme.syn.type },
		-- StorageClass
		-- Structure
		-- Typedef
		Special = { ctermfg = theme.syn.special1 },
		-- SpecialChar
		-- Tag
		Delimiter = { ctermfg = theme.syn.punct },
		Error = { ctermfg = theme.diag.error },
		Todo = { ctermfg = theme.ui.fg_reverse, ctermbg = theme.diag.info, cterm = { bold = true } },
	},
	treesitter = {
		-- @variable                       various variable names
		["@variable"] = { ctermfg = theme.ui.fg_0 },
		-- @variable.builtin (Special)     built-in variable names (e.g. `this`, `self`)
		["@variable.builtin"] = { ctermfg = theme.syn.constant, cterm = { bold = true } },
		-- @variable.parameter             parameters of a function
		["@variable.parameter"] = { ctermfg = theme.syn.parameter },
		-- @variable.parameter.builtin     special parameters (e.g. `_`, `it`)
		-- @variable.member                object and struct fields
		["@variable.member"] = { ctermfg = theme.syn.identifier },
		--
		-- @constant (Constant)              constant identifiers
		-- @constant.builtin       built-in constant values
		-- @constant.macro         constants defined by the preprocessor
		--
		-- @module (Structure)      modules or namespaces
		-- @module.builtin         built-in modules or namespaces
		-- @label                  `GOTO` and other labels (e.g. `label:` in C), including heredoc labels
		--
		-- @string                 string literals
		-- @string.documentation   string documenting code (e.g. Python docstrings)
		-- @string.regexp          regular expressions
		["@string.regexp"] = { ctermfg = theme.syn.regex },
		-- @string.escape          escape sequences
		["@string.escape"] = { ctermfg = theme.syn.regex, cterm = { bold = true } },
		-- @string.special         other special strings (e.g. dates)
		-- @string.special.symbol  symbols or atoms
		["@string.special.symbol"] = { ctermfg = theme.syn.identifier },
		-- @string.special.path    filenames
		-- @string.special.url (Underlined)     URIs (e.g. hyperlinks)
		["@string.special.url"] = { ctermfg = theme.syn.special1, cterm = { underline = true } },
		-- @character              character literals
		-- @character.special      special characters (e.g. wildcards)
		--
		-- @boolean                boolean literals
		-- @number                 numeric literals
		-- @number.float           floating-point number literals
		--
		-- @type                   type or class definitions and annotations
		-- @type.builtin           built-in types
		-- @type.definition        identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
		--
		-- @attribute              attribute annotations (e.g. Python decorators, Rust lifetimes)
		["@attribute"] = { link = "Constant" },
		-- @attribute.builtin      builtin annotations (e.g. `@property` in Python)
		-- @property               the key in key/value pairs
		--
		-- @function               function definitions
		-- @function.builtin       built-in functions
		-- @function.call          function calls
		-- @function.macro         preprocessor macros
		--
		-- @function.method        method definitions
		-- @function.method.call   method calls
		--
		-- @constructor            constructor calls and definitions
		["@constructor"] = { ctermfg = theme.syn.special1 },
		["@constructor.lua"] = { ctermfg = theme.syn.keyword },
		-- @operator               symbolic operators (e.g. `+`, `*`)
		["@operator"] = { link = "Operator" },
		--
		-- @keyword                keywords not fitting into specific categories
		-- @keyword.coroutine      keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		-- @keyword.function       keywords that define a function (e.g. `func` in Go, `def` in Python)
		-- @keyword.operator       operators that are English words (e.g. `and`, `or`)
		["@keyword.operator"] = { ctermfg = theme.syn.operator, cterm = { bold = true } },
		-- @keyword.import         keywords for including modules (e.g. `import`, `from` in Python)
		["@keyword.import"] = { link = "PreProc" },
		-- @keyword.type           keywords defining composite types (e.g. `struct`, `enum`)
		-- @keyword.modifier       keywords defining type modifiers (e.g. `const`, `static`, `public`)
		-- @keyword.repeat         keywords related to loops (e.g. `for`, `while`)
		-- @keyword.return         keywords like `return` and `yield`
		["@keyword.return"] = { ctermfg = theme.syn.special2 },
		-- @keyword.debug          keywords related to debugging
		-- @keyword.exception      keywords related to exceptions (e.g. `throw`, `catch`)
		["@keyword.exception"] = { ctermfg = theme.diag.error },

		["@keyword.luap"] = { link = "@string.regex" },
		--
		-- @keyword.conditional         keywords related to conditionals (e.g. `if`, `else`)
		-- @keyword.conditional.ternary ternary operator (e.g. `?`, `:`)
		--
		-- @keyword.directive           various preprocessor directives and shebangs
		-- @keyword.directive.define    preprocessor definition directives
		--
		-- @punctuation.delimiter  delimiters (e.g. `;`, `.`, `,`)
		["@punctuation.delimiter"] = { ctermfg = theme.syn.punct },
		-- @punctuation.bracket    brackets (e.g. `()`, `{}`, `[]`)
		["@punctuation.bracket"] = { ctermfg = theme.syn.punct },
		-- @punctuation.special    special symbols (e.g. `{}` in string interpolation)
		["@punctuation.special"] = { ctermfg = theme.syn.special1 },
		--
		-- @comment                line and block comments
		-- @comment.documentation  comments documenting code
		--
		-- @comment.error          error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
		["@comment.error"] = { ctermfg = theme.ui.fg_0, bg = theme.diag.error, cterm = { bold = true } },
		-- @comment.warning        warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
		["@comment.warning"] = { ctermfg = theme.ui.fg_reverse, bg = theme.diag.warning, cterm = { bold = true } },
		-- @comment.todo           todo-type comments (e.g. `TODO`, `WIP`)
		-- @comment.note           note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
		["@comment.note"] = { ctermfg = theme.ui.fg_reverse, bg = theme.diag.hint, cterm = { bold = true } },
		--
		-- @markup.strong          bold text
		["@markup.strong"] = { cterm = { bold = true } },
		-- @markup.italic          italic text
		["@markup.italic"] = { cterm = { italic = true } },
		-- @markup.strikethrough   struck-through text
		["@markup.strikethrough"] = { cterm = { strikethrough = true } },
		-- @markup.underline       underlined text (only for literal underline markup!)
		["@markup.underline"] = { cterm = { underline = true } },
		--
		-- @markup.heading         headings, titles (including markers)
		["@markup.heading"] = { link = "Function" },
		-- @markup.heading.1       top-level heading
		-- @markup.heading.2       section heading
		-- @markup.heading.3       subsection heading
		-- @markup.heading.4       and so on
		-- @markup.heading.5       and so forth
		-- @markup.heading.6       six levels ought to be enough for anybody
		--
		-- @markup.quote           block quotes
		["@markup.quote"] = { link = "@variable.parameter" },
		-- @markup.math            math environments (e.g. `$ ... $` in LaTeX)
		["@markup.math"] = { link = "Constant" },
		-- @markup.environment     environments (e.g. in LaTeX)
		["@markup.environment"] = { link = "Keyword" },
		--
		-- @markup.link            text references, footnotes, citations, etc.
		-- @markup.link.label      link, reference descriptions
		-- @markup.link.url        URL-style links
		["@markup.link.url"] = { link = "@string.special.url" },
		-- @markup.raw             literal or verbatim text (e.g. inline code)
		["@markup.raw"] = { link = "String" },
		-- @markup.raw.block       literal or verbatim text as a stand-alone block
		--
		-- @markup.list            list markers
		-- @markup.list.checked    checked todo-style list markers
		-- @markup.list.unchecked  unchecked todo-style list markers
		--
		-- @diff.plus              added text (for diff files)
		["@diff.plus"] = { ctermfg = theme.diff.add },
		-- @diff.minus             deleted text (for diff files)
		["@diff.minus"] = { ctermfg = theme.diff.delete },
		-- @diff.delta             changed text (for diff files)
		["@diff.delta"] = { ctermfg = theme.diff.change },
		--
		-- @tag                    XML-style tag names (e.g. in XML, HTML, etc.)
		-- @tag.builtin            XML-style tag names (e.g. HTML5 tags)
		-- @tag.attribute          XML-style tag attributes
		["@tag.attribute"] = { ctermfg = theme.syn.identifier },
		-- @tag.delimiter          XML-style tag delimiters
		["@tag.delimiter"] = { ctermfg = theme.syn.punct },
	},
	lsp = {
		["@lsp.type.class"] = { link = "Structure" },
		-- ["@lsp.type.decorator"] = { link = "Function" },
		-- ["@lsp.type.enum"] = { link = "Structure" },
		-- ["@lsp.type.enumMember"] = { link = "Constant" },
		-- ["@lsp.type.function"] = { link = "Function" },
		-- ["@lsp.type.interface"] = { link = "Structure" },
		["@lsp.type.macro"] = { link = "Macro" },
		["@lsp.type.method"] = { link = "@function.method" }, -- Function
		["@lsp.type.namespace"] = { link = "@module" }, -- Structure
		["@lsp.type.parameter"] = { link = "@variable.parameter" }, -- Identifier
		-- ["@lsp.type.property"] = { link = "Identifier" },
		-- ["@lsp.type.struct"] = { link = "Structure" },
		-- ["@lsp.type.type"] = { link = "Type" },
		-- ["@lsp.type.typeParameter"] = { link = "TypeDef" },
		["@lsp.type.variable"] = { ctermfg = "none" }, -- Identifier
		["@lsp.type.comment"] = { link = "Comment" }, -- Comment
		["@lsp.type.const"] = { link = "Constant" },
		["@lsp.type.comparison"] = { link = "Operator" },
		["@lsp.type.bitwise"] = { link = "Operator" },
		["@lsp.type.punctuation"] = { link = "Delimiter" },
		["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
		-- ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
		["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
		["@lsp.type.magicFunction"] = { link = "@function.builtin" },
		["@lsp.mod.readonly"] = { link = "Constant" },
		["@lsp.mod.typeHint"] = { link = "Type" },
		-- ["@lsp.mod.defaultLibrary"] = { link = "Special" },
		-- ["@lsp.mod.builtin"] = { link = "Special" },
		["@lsp.typemod.operator.controlFlow"] = { link = "@keyword.exception" }, -- rust ? operator
		["@lsp.type.lifetime"] = { link = "Operator" },
		["@lsp.typemod.keyword.documentation"] = { link = "Special" },
		["@lsp.type.decorator.rust"] = { link = "PreProc" },
		["@lsp.typemod.variable.global"] = { link = "Constant" },
		["@lsp.typemod.variable.static"] = { link = "Constant" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "Special" },
		["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },
		["@lsp.typemod.function.readonly"] = { ctermfg = theme.syn.fun, bold = true },
	},
	plugins = {
		-- Mini
		MiniIconsAzure = { ctermfg = palette.cyan },
		MiniIconsBlue = { ctermfg = palette.blue },
		MiniIconsCyan = { ctermfg = palette.cyan },
		MiniIconsGreen = { ctermfg = palette.green },
		MiniIconsGrey = { ctermfg = palette.white },
		MiniIconsOrange = { ctermfg = palette.yellow },
		MiniIconsPurple = { ctermfg = palette.magenta },
		MiniIconsRed = { ctermfg = palette.red },
		MiniIconsYellow = { ctermfg = palette.yellow },

		MiniDiffSignAdd = { ctermfg = theme.diag.success },
		MiniDiffSignChange = { ctermfg = theme.diag.warning },
		MiniDiffSignDelete = { ctermfg = theme.diag.error },
		MiniDiffOverAdd = { ctermfg = theme.diag.success },
		MiniDiffOverChange = { ctermfg = theme.diag.warning },
		MiniDiffOverDelete = { ctermfg = theme.diag.error },

		-- Blink
		BlinkCmpMenu = { ctermfg = theme.ui.fg_0 },
		BlinkCmpMenuBorder = { ctermfg = theme.ui.fg_0 },
		BlinkCmpMenuSelection = { ctermfg = theme.ui.fg_0, ctermbg = theme.ui.bg_1 },
		BlinkCmpMenuSearchMatch = { ctermfg = theme.ui.bg_1, ctermbg = theme.ui.bg_search },
		BlinkCmpLabel = { ctermfg = theme.ui.fg_0 },
		BlinkCmpLabelDetail = { ctermfg = theme.ui.bg_0 },
		BlinkCmpLabelDescription = { ctermfg = theme.ui.bg_1 },
		BlinkCmpLabelMatch = { ctermfg = theme.diag.success },
		BlinkCmpLabelDeprecated = { ctermfg = theme.ui.bg_1, cterm = { strikethrough = true } },
		BlinkCmpSignature = { ctermfg = theme.ui.fg_1, ctermbg = theme.ui.bg_1 },
		BlinkCmpSignatureBorder = { ctermfg = theme.ui.bg_1, ctermbg = theme.ui.bg_1 },
		BlinkCmpSignatureActiveParameter = { ctermfg = theme.syn.fun, ctermbg = theme.ui.bg_1 },
		BlinkCmpScrollbar = { ctermfg = theme.ui.fg_0, ctermbg = theme.ui.fg_0 },
		BlinkCmpScrollbarThumb = { ctermfg = theme.ui.fg_1, ctermbg = theme.ui.fg_0 },

		-- RenderMarkdown
		RenderMarkdownH1 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH2 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH3 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH4 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH5 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH6 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownCode = { ctermbg = "none" },
		RenderMarkdownCodeInline = { ctermfg = theme.syn.str },
		RenderMarkdownBullet = { ctermfg = "none" },
		RenderMarkdownTableHead = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownTableRow = { ctermfg = "none" },
		RenderMarkdownSuccess = { ctermfg = theme.diag.success },
		RenderMarkdownInfo = { ctermfg = theme.diag.info },
		RenderMarkdownHint = { ctermfg = theme.diag.hint },
		RenderMarkdownWarn = { ctermfg = theme.diag.warn },
		RenderMarkdownError = { ctermfg = theme.diag.error },
		RenderMarkdownQuote = { ctermfg = theme.syn.comment },
		RenderMarkdownLink = { ctermfg = "none", cterm = { underline = true } },
		RenderMarkdownImage = { ctermfg = theme.syn.special1 },
	},
}

local function set_hl(highlights)
	for k, v in pairs(highlights) do
		vim.api.nvim_set_hl(0, k, v)
	end
end

for _, v in pairs(bindings) do
	set_hl(v)
end
