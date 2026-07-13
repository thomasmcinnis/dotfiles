-- This theme maps the 16 ansi terminal colours to nvim highlight groups.
-- No other color values are used. This enables the appearance of nvim to reflect
-- the current selected terminal theme (dark or light) without coordination.
--
-- The theme assumes that black (0) is intended as the background color, bright white (15) is the
-- foreground color. A light mode ansi theme should set black to be the brightest white, and 
-- bright white to be the darkest black, so as to invert the surfaces.
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

local surface = {
    top = palette.white_br,
    mid = palette.white,
    low = palette.black_br,
    base = palette.black,
}

local theme = {
	diff = {
		add = palette.green,
		delete = palette.red,
		change = palette.blue,
		text = palette.yellow,
	},
	diagnistic = {
		ok = palette.green_br,
		error = palette.red_br,
		warning = palette.yellow_br,
		info = palette.blue_br,
		hint = palette.cyan_br,
	},
	syntax = {
		str = palette.green_br,
		var = palette.blue_br,
		number = palette.green_br,
		constant = palette.white_br,
		identifier = palette.white_br,
		parameter = palette.white_br,
		func_dec = palette.magenta_br,
		method = palette.white_br,
		statement = palette.blue_br,
		keyword = palette.white_br,
		operator = palette.white_br,
		preproc = palette.white,
		type = palette.white,
		regex = palette.green_br,
		deprecated = palette.white,
		comment = palette.yellow,
		punct = palette.white,
		special1 = palette.cyan_br,
		special2 = palette.red_br,
	}
}

local bindings = {
	editor = {
		CursorLine = { ctermfg = surface.base, ctermbg = surface.mid },
		CurSearch = { ctermfg = palette.red_br, ctermbg = surface.low },
		Search = { link = "CurSearch" },
		NormalFloat = { ctermfg = surface.top, ctermbg = surface.low },
        FloatBorder = { ctermbg = surface.mid },
		Pmenu = { ctermfg = surface.top, ctermbg = surface.low },
		PmenuSel = { ctermfg = surface.base, ctermbg = surface.mid },
        PmenuSbar = { ctermbg = surface.mid },
        PmenuMatch = { ctermfg = palette.red, cterm = { bold = true } },
        PmenuMatchSel = { ctermfg = surface.base, cterm = { bold = true } } ,

		DiagnosticError = { ctermfg = theme.diagnistic.error },
		DiagnosticWarn = { ctermfg = theme.diagnistic.warning },
		DiagnosticInfo = { ctermfg = theme.diagnistic.info },
		DiagnosticHint = { ctermfg = theme.diagnistic.hint },
		DiagnosticOk = { ctermfg = theme.diagnistic.ok },

		DiagnosticFloatingError = { ctermfg = theme.diagnistic.error },
		DiagnosticFloatingWarn = { ctermfg = theme.diagnistic.warning },
		DiagnosticFloatingInfo = { ctermfg = theme.diagnistic.info },
		DiagnosticFloatingHint = { ctermfg = theme.diagnistic.hint },
		DiagnosticFloatingOk = { ctermfg = theme.diagnistic.ok },

		DiagnosticSignError = { ctermfg = theme.diagnistic.error },
		DiagnosticSignWarn = { ctermfg = theme.diagnistic.warning },
		DiagnosticSignInfo = { ctermfg = theme.diagnistic.info },
		DiagnosticSignHint = { ctermfg = theme.diagnistic.hint },

		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },

		DiffAdd = { ctermfg = theme.diff.add },
		DiffChange = { ctermfg = theme.diff.change },
		DiffDelete = { ctermfg = theme.diff.delete },
		DiffText = { ctermfg = theme.diff.text },

		ErrorMsg = { ctermfg = theme.diagnistic.error },
		WarningMsg = { ctermfg = theme.diagnistic.warning },
		LineNr = { ctermfg = surface.mid },
		MatchParen = { ctermfg = theme.diagnistic.error, cterm = { bold = true } },
		NonText = { ctermfg = surface.low },

        QuickFixLine = { ctermfg = surface.base, ctermbg = surface.mid },

		StatusLine = { ctermfg = surface.top, ctermbg = surface.low, cterm = {} },
		StatusLineNC = { ctermfg = surface.mid, ctermbg = surface.low, cterm = {} },

		SpellBad = { ctermfg = theme.diagnistic.warning, cterm = { underline = true } },
		SpellCap = { ctermfg = theme.diagnistic.warning, cterm = { underline = true } },
		SpellLocal = { ctermfg = theme.diagnistic.hint, cterm = { underline = true } },
		SpellRare = { ctermfg = theme.diagnistic.info, cterm = { underline = true } },

		WinSeparator = { ctermfg = surface.low },
		VertSplit = { link = "WinSeparator" },

		LspCodeLens = { ctermfg = surface.low },
		LspCodeLensSeparator = { ctermfg = surface.low },
		LspInlayHint = { ctermfg = surface.low, ctermbg = surface.base },
		LspSignatureActiveParameter = { ctermfg = theme.diagnistic.success, cterm = { bold = true } },

	},
	syntax = {
		Comment = { ctermfg = theme.syntax.comment },
		Constant = { ctermfg = theme.syntax.constant },
		String = { ctermfg = theme.syntax.str },
		Character = { ctermfg = theme.syntax.str },
		Boolean = { ctermfg = theme.syntax.regex},
		Number = { ctermfg = theme.syntax.number },
		Float = { link = "Number" },
		Identifier = { ctermfg = theme.syntax.identifier },
		Function = { ctermfg = theme.syntax.func_dec },
		Statement = { ctermfg = theme.syntax.keyword },
		-- Conditional
		-- Repeat
		-- Label
		Operator = { ctermfg = theme.syntax.operator },
		Keyword = { ctermfg = theme.syntax.keyword },
		Exception = { ctermfg = theme.syntax.special1 },
		PreProc = { ctermfg = theme.syntax.preproc },
		-- Include
		-- Define
		-- Macro
		-- PreCondit
		Type = { ctermfg = theme.syntax.type },
		-- StorageClass
		-- Structure
		-- Typedef
		Special = { ctermfg = theme.syntax.special1 },
		-- SpecialChar
		-- Tag
		Delimiter = { ctermfg = theme.syntax.punct },
		Error = { ctermfg = theme.diagnistic.error },
		Todo = { ctermfg = surface.base, ctermbg = theme.diagnistic.info, cterm = { bold = true } },
	},
	treesitter = {
		-- @variable                       various variable names
		["@variable"] = { ctermfg = theme.syntax.var },
		-- @variable.builtin (Special)     built-in variable names (e.g. `this`, `self`)
		["@variable.builtin"] = { ctermfg = theme.syntax.constant },
		-- @variable.parameter             parameters of a function
		["@variable.parameter"] = { ctermfg = theme.syntax.parameter },
		-- @variable.parameter.builtin     special parameters (e.g. `_`, `it`)
		-- @variable.member                object and struct fields
		["@variable.member"] = { ctermfg = theme.syntax.identifier },
		--
		-- @constant (Constant)              constant identifiers
		-- @constant.builtin       built-in constant values
		["@constant.builtin"] = { ctermfg = theme.syntax.var },
		-- @constant.macro         constants defined by the preprocessor
		--
		-- @module (Structure)      modules or namespaces
		-- @module.builtin         built-in modules or namespaces
		-- @label                  `GOTO` and other labels (e.g. `label:` in C), including heredoc labels
		--
		-- @string                 string literals
		-- @string.documentation   string documenting code (e.g. Python docstrings)
		-- @string.regexp          regular expressions
		["@string.regexp"] = { ctermfg = theme.syntax.regex },
		-- @string.escape          escape sequences
		["@string.escape"] = { ctermfg = theme.syntax.regex, cterm = { bold = true } },
		-- @string.special         other special strings (e.g. dates)
		-- @string.special.symbol  symbols or atoms
		["@string.special.symbol"] = { ctermfg = theme.syntax.identifier },
		-- @string.special.path    filenames
		-- @string.special.url (Underlined)     URIs (e.g. hyperlinks)
		["@string.special.url"] = { ctermfg = theme.syntax.str, cterm = { underline = true } },
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
		["@function.call"] = { ctermfg = theme.syntax.method },
		--
		-- @function.macro         preprocessor macros
		--
		-- @function.method        method definitions
		-- @function.method.call   method calls
		["@function.method.call"] = { link = "@function.call" },
		--
		-- @constructor            constructor calls and definitions
		["@constructor"] = { ctermfg = theme.syntax.method },
		["@constructor.lua"] = { ctermfg = theme.syntax.punct },
		-- @operator               symbolic operators (e.g. `+`, `*`)
		["@operator"] = { link = "Operator" },
		--
		-- @keyword                keywords not fitting into specific categories
		-- @keyword.coroutine      keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		-- @keyword.function       keywords that define a function (e.g. `func` in Go, `def` in Python)
		-- @keyword.operator       operators that are English words (e.g. `and`, `or`)
		["@keyword.operator"] = { ctermfg = theme.syntax.operator },
		-- @keyword.import         keywords for including modules (e.g. `import`, `from` in Python)
		["@keyword.import"] = { link = "PreProc" },
		-- @keyword.type           keywords defining composite types (e.g. `struct`, `enum`)
		-- @keyword.modifier       keywords defining type modifiers (e.g. `const`, `static`, `public`)
		-- @keyword.repeat         keywords related to loops (e.g. `for`, `while`)
		-- @keyword.return         keywords like `return` and `yield`
		["@keyword.return"] = { ctermfg = theme.syntax.special2 },
		-- @keyword.debug          keywords related to debugging
		-- @keyword.exception      keywords related to exceptions (e.g. `throw`, `catch`)
		["@keyword.exception"] = { ctermfg = theme.diagnistic.error },

		["@keyword.luap"] = { link = "@string.regex" },
		--
		-- @keyword.conditional         keywords related to conditionals (e.g. `if`, `else`)
		-- @keyword.conditional.ternary ternary operator (e.g. `?`, `:`)
		--
		-- @keyword.directive           various preprocessor directives and shebangs
		-- @keyword.directive.define    preprocessor definition directives
		--
		-- @punctuation.delimiter  delimiters (e.g. `;`, `.`, `,`)
		["@punctuation.delimiter"] = { ctermfg = theme.syntax.punct },
		-- @punctuation.bracket    brackets (e.g. `()`, `{}`, `[]`)
		["@punctuation.bracket"] = { ctermfg = theme.syntax.punct },
		-- @punctuation.special    special symbols (e.g. `{}` in string interpolation)
		["@punctuation.special"] = { ctermfg = theme.syntax.special1 },
		--
		-- @comment                line and block comments
		-- @comment.documentation  comments documenting code
		--
		-- @comment.error          error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
		["@comment.error"] = { ctermfg = surface.top, bg = theme.diagnistic.error, cterm = { bold = true } },
		-- @comment.warning        warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
		["@comment.warning"] = { ctermfg = surface.base, bg = theme.diagnistic.warning, cterm = { bold = true } },
		-- @comment.todo           todo-type comments (e.g. `TODO`, `WIP`)
		-- @comment.note           note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
		["@comment.note"] = { ctermfg = surface.base, bg = theme.diagnistic.hint, cterm = { bold = true } },
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
		["@tag.attribute"] = { ctermfg = theme.syntax.identifier },
		-- @tag.delimiter          XML-style tag delimiters
		["@tag.delimiter"] = { ctermfg = theme.syntax.punct },
	},
	lsp = {
		-- ["@lsp.type.class"] = { link = "Structure" },
		-- ["@lsp.type.decorator"] = { link = "Function" },
		-- ["@lsp.type.enum"] = { link = "Structure" },
		-- ["@lsp.type.enumMember"] = { link = "Constant" },
		-- ["@lsp.type.function"] = { link = "Function" },
		-- ["@lsp.type.interface"] = { link = "Structure" },
		-- ["@lsp.type.macro"] = { link = "Macro" },
		-- ["@lsp.type.method"] = { link = "@function.method" }, -- Function
		["@lsp.type.method.javascript"] = { link = "@function.method.call" }, -- Function
		-- ["@lsp.type.namespace"] = { link = "@module" }, -- Structure
		["@lsp.type.parameter.javascript"] = { link = "@variable.parameter" }, -- Identifier
		-- ["@lsp.type.property"] = { link = "Identifier" },
		-- ["@lsp.type.struct"] = { link = "Structure" },
		-- ["@lsp.type.type"] = { link = "Type" },
		-- ["@lsp.type.typeParameter"] = { link = "TypeDef" },
		-- ["@lsp.type.variable"] = { link = "@variable.parameter" }, -- Identifier
		-- ["@lsp.type.comment"] = { link = "Comment" }, -- Comment
		-- ["@lsp.type.const"] = { link = "Constant" },
		-- ["@lsp.type.comparison"] = { link = "Operator" },
		-- ["@lsp.type.bitwise"] = { link = "Operator" },
		-- ["@lsp.type.punctuation"] = { link = "Delimiter" },
		-- ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
		-- ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
		-- ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
		-- ["@lsp.type.magicFunction"] = { link = "@function.builtin" },
		-- ["@lsp.mod.readonly"] = { link = "Constant" },
		-- ["@lsp.mod.typeHint"] = { link = "Type" },
		-- ["@lsp.mod.defaultLibrary"] = { link = "Special" },
		-- ["@lsp.mod.builtin"] = { link = "Special" },
		-- ["@lsp.typemod.operator.controlFlow"] = { link = "@keyword.exception" }, -- rust ? operator
		-- ["@lsp.type.lifetime"] = { link = "Operator" },
		-- ["@lsp.typemod.keyword.documentation"] = { link = "Special" },
		-- ["@lsp.type.decorator.rust"] = { link = "PreProc" },
		-- ["@lsp.typemod.variable.global"] = { link = "Constant" },
		-- ["@lsp.typemod.variable.static"] = { link = "Constant" },
		-- ["@lsp.typemod.variable.defaultLibrary"] = { link = "Special" },
		-- ["@lsp.typemod.function.builtin"] = { link = "@function.builtin" },
		-- ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		-- ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
		-- ["@lsp.typemod.variable.injected"] = { link = "@variable" },
		-- ["@lsp.typemod.function.readonly"] = { ctermfg = theme.syn.func_dec, bold = true },
		["@lsp.typemod.method.declaration"] = { link = "Function" },
	},
	plugins = {
		-- RenderMarkdown
		RenderMarkdownH1 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH2 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH3 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH4 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH5 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownH6 = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownCode = { ctermbg = surface.base },
		RenderMarkdownCodeInline = { ctermfg = theme.syntax.str },
		RenderMarkdownBullet = { ctermfg = "none" },
		RenderMarkdownTableHead = { ctermfg = "none", cterm = { bold = true } },
		RenderMarkdownTableRow = { ctermfg = "none" },
		RenderMarkdownSuccess = { ctermfg = theme.diagnistic.success },
		RenderMarkdownInfo = { ctermfg = theme.diagnistic.info },
		RenderMarkdownHint = { ctermfg = theme.diagnistic.hint },
		RenderMarkdownWarn = { ctermfg = theme.diagnistic.warn },
		RenderMarkdownError = { ctermfg = theme.diagnistic.error },
		RenderMarkdownQuote = { ctermfg = theme.syntax.comment },
		RenderMarkdownLink = { ctermfg = "none", cterm = { underline = true } },
		RenderMarkdownImage = { ctermfg = theme.syntax.special1 },
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
