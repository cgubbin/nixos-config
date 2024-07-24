require("luasnip.session.snippet_collection").clear_snippets("markdown")

local ls = require("luasnip")

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local sn = ls.snippet_node
local d = ls.dynamic_node
-- local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

ls.add_snippets("markdown", {
	s("tk", fmt("- [{}] {}", { c(2, { t(" "), t("-"), t("x") }), i(1, "task") })),
	s(
		{ trig = "eq", snippetType = "autosnippet", dscr = "A LaTeX equation environment" },
		fmta( -- The snippet code actually looks like the equation environment it produces.
			[[
            $$
                \begin{equation}
                    <>
                \end{equation}
            $$
            ]],
			-- The insert node is placed in the <> angle brackets
			{ i(0) }
		)
	),

	s(
		{ trig = "al", snippetType = "autosnippet", dscr = "A LaTeX align environment" },
		fmta( -- The snippet code actually looks like the equation environment it produces.
			[[
            $$
                \begin{align}
                    <> $= <>,
                \end{align}
            $$
            ]],
			-- The insert node is placed in the <> angle brackets
			{ i(1), i(2) }
		)
	),

	s(
		{ trig = "crs", snippetType = "autosnippet", dscr = "A rust code environment" },
		fmta( -- The snippet code actually looks like the equation environment it produces.
			[[
            ```rust
                <>
            ```
            ]],
			-- The insert node is placed in the <> angle brackets
			{ i(0) }
		)
	),

	s(
		{ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
		fmta([[ [<>](<>) ]], {
			i(1, "display name"),
			i(2, "url"),
		})
	),

	s(
		{
			trig = "([^%a])mm",
			wordTrig = false,
			regTrig = true,
			snippetType = "autosnippet",
			desc = "Make mm expand to $ $ (inline math), but not in words like comment, command, etc",
		},
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
})
