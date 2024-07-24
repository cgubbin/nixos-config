local luasnip = require("luasnip")
local extras = require("luasnip.extras")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local d = luasnip.dynamic_node
local f = luasnip.function_node
local rep = extras.rep
local fmta = require("luasnip.extras.fmt").fmta
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
	return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
	local is_inside = vim.fn["vimtex#env#is_inside"](name)
	return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
	return tex_utils.in_env("equation")
end
tex_utils.in_itemize = function() -- itemize environment detection
	return tex_utils.in_env("itemize")
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
	return tex_utils.in_env("tikzpicture")
end

return {
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}),
	s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, fmta("\\texttt{<>}", { i(1) })),

	s(
		{ trig = "eq", snippetType = "autosnippet", dscr = "A LaTeX equation environment" },
		fmta( -- The snippet code actually looks like the equation environment it produces.
			[[
            \begin{equation}
                <>
            \end{equation}
            ]],
			-- The insert node is placed in the <> angle brackets
			{ i(0) }
		),
		{ condition = line_begin }
	),

	s(
		{ trig = "h1", dscr = "Top-level section" },
		fmta([[\section{<>}]], { i(1) }),
		{ condition = line_begin } -- set condition in the `opts` table
	),

	s(
		{ trig = "new", dscr = "A generic new environmennt" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1),
			}
		),
		{ condition = line_begin }
	),

	s(
		{ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
		fmta([[\href{<>}{<>}]], {
			i(1, "url"),
			i(2, "display name"),
		})
	),

	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		})
	),

	s(
		{
			trig = "([^%a])mm",
			wordTrig = false,
			regTrig = true,
			desc = "Make mm expand to $ $ (inline math), but not in words like comment, command, etc",
		},
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	s(
		{
			trig = "([^%a])ee",
			regTrig = true,
			wordTrig = false,
			desc = "Make ee expand to e^{} (Euler’s number raised to a power) after spaces, delimiters, and so on, but not in words like see, feel, etc…",
		},
		fmta("<>e^{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),

	s(
		{ trig = "ff" },
		fmta("\\frac{<>}{<>}", {
			i(1),
			i(2),
		}),
		{ condition = tex_utils.in_mathzone } -- `condition` option passed in the snippet `opts` table
	),

	s(
		{ trig = "dd" },
		fmta("\\draw [<>] ", {
			i(1, "params"),
		}),
		{ condition = tex_utils.in_tikz }
	),
	s({ trig = "df", snippetType = "autosnippet" }, { t("\\diff") }, { condition = tex_utils.in_mathzone }),

	s(
		{ trig = "sd", snippetType = "autosnippet", wordTrig = false },
		fmta("_{\\mathrm{<>}}", { d(1, get_visual) }),
		{ condition = tex_utils.in_mathzone }
	),
}
