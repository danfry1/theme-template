local M = {}

function M.get(p, config)
  local fg = p.foregrounds
  local ac = p.accents

  local italic = config.italics

  return {
    -- ── Legacy Vim syntax groups ─────────────────────────────────────────
    Comment = { fg = fg.comment, italic = italic },
    Constant = { fg = ac.type },
    String = { fg = ac.string },
    Character = { fg = ac.string },
    Number = { fg = ac.type },
    Float = { fg = ac.type },
    Boolean = { fg = ac.type },
    Identifier = { fg = fg.text },
    Function = { fg = fg.text },
    Statement = { fg = ac.keyword, italic = italic },
    Conditional = { fg = ac.operator },
    Repeat = { fg = ac.operator },
    Label = { fg = ac.operator },
    Operator = { fg = ac.operator },
    Keyword = { fg = ac.keyword, italic = italic },
    Exception = { fg = ac.operator },
    PreProc = { fg = ac.tag },
    Include = { fg = ac.keyword, italic = italic },
    Define = { fg = ac.keyword },
    Macro = { fg = ac.tag },
    PreCondit = { fg = ac.tag },
    Type = { fg = ac.type },
    StorageClass = { fg = ac.keyword, italic = italic },
    Structure = { fg = ac.type },
    Typedef = { fg = ac.type },
    Special = { fg = ac.tag },
    SpecialChar = { fg = ac.tag },
    Tag = { fg = ac.type },
    Delimiter = { fg = fg.overlay },
    SpecialComment = { fg = fg.overlay, italic = italic },
    Debug = { fg = ac.error },
    Underlined = { underline = true },
    Ignore = { fg = fg.overlay },
    Error = { fg = ac.error },
    Todo = { fg = ac.number, bold = true },

    -- ── Treesitter — variables ───────────────────────────────────────────
    ["@variable"] = { fg = fg.text },
    ["@variable.builtin"] = { fg = fg.text, italic = italic },
    ["@variable.parameter"] = { fg = fg.text },
    ["@variable.member"] = { fg = fg.text },

    -- ── Treesitter — constants ───────────────────────────────────────────
    ["@constant"] = { fg = ac.type },
    ["@constant.builtin"] = { fg = ac.keyword, italic = italic },
    ["@constant.macro"] = { fg = ac.tag },

    -- ── Treesitter — modules / namespaces ────────────────────────────────
    ["@module"] = { fg = fg.text },
    ["@module.builtin"] = { fg = fg.text, italic = italic },
    ["@label"] = { fg = ac.operator },

    -- ── Treesitter — literals ────────────────────────────────────────────
    ["@string"] = { fg = ac.string },
    ["@string.documentation"] = { fg = ac.string, italic = italic },
    ["@string.escape"] = { fg = ac.tag },
    ["@string.regexp"] = { fg = ac.tag },
    ["@string.regex"] = { link = "@string.regexp" },
    ["@string.special"] = { fg = ac.tag },
    ["@string.special.symbol"] = { fg = ac.type },
    ["@string.special.url"] = { fg = ac.func, underline = true },
    ["@character"] = { fg = ac.string },
    ["@character.special"] = { fg = ac.tag },
    ["@boolean"] = { fg = ac.type },
    ["@number"] = { fg = ac.number },
    ["@number.float"] = { fg = ac.number },

    -- ── Treesitter — types ───────────────────────────────────────────────
    ["@type"] = { fg = ac.type },
    ["@type.builtin"] = { fg = ac.keyword, italic = italic },
    ["@type.definition"] = { fg = ac.type },
    ["@attribute"] = { fg = ac.type },
    ["@attribute.builtin"] = { fg = ac.type, italic = italic },
    ["@property"] = { fg = fg.text },

    -- ── Treesitter — functions ───────────────────────────────────────────
    ["@function"] = { fg = fg.text },
    ["@function.builtin"] = { fg = ac.func, italic = italic },
    ["@function.call"] = { fg = ac.func },
    ["@function.macro"] = { fg = ac.tag },
    ["@function.method"] = { fg = fg.text },
    ["@function.method.call"] = { fg = ac.func },
    ["@constructor"] = { fg = ac.type },
    ["@operator"] = { fg = ac.operator },

    -- ── Treesitter — keywords ────────────────────────────────────────────
    ["@keyword"] = { fg = ac.keyword, italic = italic },
    ["@keyword.coroutine"] = { fg = ac.keyword, italic = italic },
    ["@keyword.function"] = { fg = ac.keyword, italic = italic },
    ["@keyword.operator"] = { fg = ac.operator },
    ["@keyword.import"] = { fg = ac.keyword, italic = italic },
    ["@keyword.storage"] = { fg = ac.keyword, italic = italic },
    ["@keyword.repeat"] = { fg = ac.operator },
    ["@keyword.return"] = { fg = ac.operator },
    ["@keyword.debug"] = { fg = ac.error },
    ["@keyword.exception"] = { fg = ac.operator },
    ["@keyword.conditional"] = { fg = ac.operator },
    ["@keyword.conditional.ternary"] = { fg = ac.operator },
    ["@keyword.directive"] = { fg = ac.tag },
    ["@keyword.directive.define"] = { fg = ac.tag },

    -- ── Treesitter — punctuation ─────────────────────────────────────────
    ["@punctuation.delimiter"] = { fg = fg.overlay },
    ["@punctuation.bracket"] = { fg = fg.overlay },
    ["@punctuation.special"] = { fg = ac.tag },

    -- ── Treesitter — comments ────────────────────────────────────────────
    ["@comment"] = { fg = fg.comment, italic = italic },
    ["@comment.documentation"] = { fg = fg.comment, italic = italic },
    ["@comment.error"] = { fg = ac.error, bold = true },
    ["@comment.warning"] = { fg = ac.number, bold = true },
    ["@comment.todo"] = { fg = ac.number, bold = true },
    ["@comment.note"] = { fg = ac.func, bold = true },

    -- ── Treesitter — markup ──────────────────────────────────────────────
    ["@markup.strong"] = { fg = ac.type, bold = true },
    ["@markup.italic"] = { fg = ac.operator, italic = true },
    ["@markup.strikethrough"] = { fg = fg.overlay, strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = ac.keyword, bold = true },
    ["@markup.heading.1"] = { fg = ac.keyword, bold = true },
    ["@markup.heading.2"] = { fg = ac.operator, bold = true },
    ["@markup.heading.3"] = { fg = ac.type, bold = true },
    ["@markup.heading.4"] = { fg = ac.string, bold = true },
    ["@markup.heading.5"] = { fg = ac.func, bold = true },
    ["@markup.heading.6"] = { fg = ac.tag, bold = true },
    ["@markup.quote"] = { fg = fg.subtext, italic = italic },
    ["@markup.math"] = { fg = ac.tag },
    ["@markup.environment"] = { fg = ac.type },
    ["@markup.link"] = { fg = ac.func, underline = true },
    ["@markup.link.label"] = { fg = ac.func },
    ["@markup.link.url"] = { fg = ac.func, underline = true },
    ["@markup.raw"] = { fg = ac.string },
    ["@markup.raw.block"] = { fg = ac.string },
    ["@markup.list"] = { fg = ac.operator },
    ["@markup.list.checked"] = { fg = ac.string },
    ["@markup.list.unchecked"] = { fg = fg.overlay },

    -- ── Treesitter — tags (HTML/JSX) ─────────────────────────────────────
    ["@tag"] = { fg = ac.type },
    ["@tag.builtin"] = { fg = ac.tag },
    ["@tag.attribute"] = { fg = ac.func, italic = italic },
    ["@tag.delimiter"] = { fg = fg.overlay },

    -- ── Treesitter — diff ────────────────────────────────────────────────
    ["@diff.plus"] = { fg = ac.string },
    ["@diff.minus"] = { fg = ac.error },
    ["@diff.delta"] = { fg = ac.func },
  }
end

return M
