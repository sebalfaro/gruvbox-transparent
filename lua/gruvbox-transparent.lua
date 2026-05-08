local M = {}

M.defaults = {
  transparent = false,
  variant = "dark", -- "dark" or "light"
}

M.options = {}

local function invert_hex(hex)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  return string.format("#%02x%02x%02x", 255 - r, 255 - g, 255 - b)
end

local function get_palette(variant)
  local p = {
    ["gray-0"]    = "#eeeeee",
    ["gray-5"]    = "#cccccc",
    ["gray-10"]   = "#aaaaaa",
    ["gray-15"]   = "#a3a3a3",
    ["gray-25"]   = "#999999",
    ["gray-55"]   = "#555555",
    ["gray-80"]   = "#3a3a3a",
    ["gray-85"]   = "#333333",
    ["gray-95"]   = "#222222",
    ["gray-100"]  = "#111111",
    ["green-25"]  = "#B8BB26",
    ["yellow-25"] = "#FABD2F",
    ["orange-25"] = "#FE8019",
    ["red-25"]    = "#FB4934",
    ["purple-25"] = "#D3869B",
    ["blue-25"]   = "#83A598",
    ["aqua-25"]   = "#8EC07C",
  }
  if variant == "light" then
    for k, v in pairs(p) do p[k] = invert_hex(v) end
  end
  return p
end

function M.load()
  local opts = M.options
  local set_hl = vim.api.nvim_set_hl

  local variant = opts.variant or "dark"
  if os.getenv("THEME_VARIANT") == "light" then variant = "light" end

  local c = get_palette(variant)
  local transparent = opts.transparent
  local none = "none"

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.o.background = variant == "light" and "light" or "dark"
  vim.g.colors_name = "gruvbox-transparent"

  local bg = transparent and none or c["gray-100"]

  -- Base
  set_hl(0, "Normal",      { bg = bg, fg = c["gray-0"], ctermbg = transparent and "None" or nil })
  set_hl(0, "NormalNC",    { bg = bg, fg = c["gray-10"] })
  set_hl(0, "NormalFloat", { bg = none, ctermbg = "None" })
  set_hl(0, "SignColumn",  { bg = none })
  set_hl(0, "Pmenu",       { bg = none, ctermbg = "None" })
  set_hl(0, "NonText",     { fg = "gray", bg = none })
  set_hl(0, "EndOfBuffer", { fg = c["gray-85"] })
  set_hl(0, "Visual",      { bg = c["gray-80"] })
  set_hl(0, "Search",      { fg = "#000000", bg = c["yellow-25"] })
  set_hl(0, "IncSearch",   { fg = "#000000", bg = c["orange-25"] })
  set_hl(0, "MatchParen",  { fg = c["orange-25"], bold = true })
  set_hl(0, "LineNr",      { fg = c["gray-55"] })
  set_hl(0, "ColorColumn", { bg = c["gray-95"] })

  -- Syntax
  set_hl(0, "Statement",   { fg = c["red-25"] })
  set_hl(0, "Keyword",     { fg = c["red-25"], italic = true })
  set_hl(0, "Conditional", { fg = c["red-25"], italic = true })
  set_hl(0, "Repeat",      { fg = c["red-25"], italic = true })
  set_hl(0, "Exception",   { fg = c["red-25"] })
  set_hl(0, "Function",    { fg = c["green-25"], bold = true })
  set_hl(0, "Identifier",  { fg = c["blue-25"] })
  set_hl(0, "String",      { fg = c["aqua-25"] })
  set_hl(0, "Number",      { fg = c["purple-25"] })
  set_hl(0, "Float",       { fg = c["purple-25"] })
  set_hl(0, "Boolean",     { fg = c["purple-25"] })
  set_hl(0, "Constant",    { fg = c["purple-25"] })
  set_hl(0, "Type",        { fg = c["yellow-25"] })
  set_hl(0, "StorageClass",{ fg = c["orange-25"], italic = true })
  set_hl(0, "Structure",   { fg = c["aqua-25"] })
  set_hl(0, "Operator",    { fg = c["orange-25"] })
  set_hl(0, "PreProc",     { fg = c["aqua-25"] })
  set_hl(0, "Include",     { fg = c["aqua-25"] })
  set_hl(0, "Define",      { fg = c["aqua-25"] })
  set_hl(0, "Macro",       { fg = c["aqua-25"] })
  set_hl(0, "Special",     { fg = c["orange-25"] })
  set_hl(0, "SpecialChar", { fg = c["orange-25"] })
  set_hl(0, "Tag",         { fg = c["orange-25"] })
  set_hl(0, "Delimiter",   { fg = c["gray-5"] })
  set_hl(0, "Underlined",  { underline = true })
  set_hl(0, "Error",       { fg = c["red-25"], bold = true })
  set_hl(0, "Todo",        { fg = "#000000", bg = c["yellow-25"], bold = true })
  set_hl(0, "Comment",     { bg = none, fg = c["gray-55"], italic = true })

  -- Spelling
  set_hl(0, "SpellBad",   { undercurl = true })
  set_hl(0, "SpellRare",  { undercurl = true })
  set_hl(0, "SpellCap",   { undercurl = true })
  set_hl(0, "SpellLocal", { undercurl = true })

  -- HTML
  set_hl(0, "htmlArg",        { italic = true })
  set_hl(0, "htmlBold",       { bold = true })
  set_hl(0, "htmlItalic",     { italic = true })
  set_hl(0, "htmlBoldItalic", { bold = true, italic = true })

  -- CursorLine
  set_hl(0, "CursorLine",   { bg = c["gray-95"] })
  set_hl(0, "CursorLineNr", { bg = c["gray-95"], fg = c["orange-25"] })

  -- Folds
  set_hl(0, "Folded",     { bg = none, fg = c["gray-85"], ctermbg = "None", bold = false, nocombine = true })
  set_hl(0, "FoldColumn", { bg = none, fg = c["gray-85"], ctermbg = "None", bold = false, nocombine = true })

  -- Pane separators / borders
  set_hl(0, "VertSplit",    { bg = none, fg = c["gray-95"] })
  set_hl(0, "WinSeparator", { bg = none, fg = c["gray-95"] })
  set_hl(0, "PmenuBorder",  { fg = c["gray-85"], ctermfg = "gray", bg = none, ctermbg = "None" })
  set_hl(0, "FloatBorder",  { fg = c["gray-85"], ctermfg = "gray", bg = none, ctermbg = "None" })
  set_hl(0, "LspInfoBorder",{ fg = c["gray-95"], ctermfg = "gray", bg = none, ctermbg = "None" })

  -- Status / tabs / winbar
  set_hl(0, "TabLine",      { bg = none, ctermbg = "None" })
  set_hl(0, "TabLineSel",   { fg = c["gray-5"], bg = none, ctermbg = "None" })
  set_hl(0, "TabLineFill",  { bg = none, ctermbg = "None" })
  set_hl(0, "StatusLine",   { fg = c["gray-55"], bg = none, ctermbg = "None" })
  set_hl(0, "StatusLineNC", { fg = c["gray-55"], bg = none, ctermbg = "None" })
  set_hl(0, "WinBar",       { bg = none, ctermbg = "None" })
  set_hl(0, "WinBarNC",     { fg = c["gray-55"], bg = none, ctermbg = "None" })

  -- Lualine transparent transitions
  set_hl(0, "lualine_transitional_lualine_a_replace_to_StatusLine", { bg = none })
  set_hl(0, "lualine_transitional_lualine_a_insert_to_StatusLine",  { bg = none })
  set_hl(0, "lualine_transitional_lualine_a_normal_to_StatusLine",  { bg = none })
  set_hl(0, "lualine_transitional_lualine_a_command_to_StatusLine", { bg = none })
  set_hl(0, "lualine_transitional_lualine_a_visual_to_StatusLine",  { bg = none })

  -- LSP Diagnostics
  set_hl(0, "DiagnosticError", { fg = "red",    bg = none })
  set_hl(0, "DiagnosticWarn",  { fg = "orange", bg = none })
  set_hl(0, "DiagnosticInfo",  { fg = "teal",   bg = none })
  set_hl(0, "DiagnosticHint",  { fg = "white",  bg = none })

  -- Bufferline
  set_hl(0, "BufferLineNumbersSelected",            { bg = none, fg = "white" })
  set_hl(0, "BufferLineBufferSelected",             { fg = "#ffffff", bg = none })
  set_hl(0, "BufferLineDiagnosticSelected",         { bg = none })
  set_hl(0, "BufferLineHintSelected",               { bg = none })
  set_hl(0, "BufferLineHintDiagnosticSelected",     { bg = none })
  set_hl(0, "BufferLineInfoSelected",               { bg = none })
  set_hl(0, "BufferLineInfoDiagnosticSelected",     { bg = none })
  set_hl(0, "BufferLineWarningSelected",            { bg = none })
  set_hl(0, "BufferLineWarningDiagnosticSelected",  { bg = none })
  set_hl(0, "BufferLineErrorSelected",              { bg = none })
  set_hl(0, "BufferLineErrorDiagnosticSelected",    { bg = none })
  set_hl(0, "BufferLineModifiedSelected",           { bg = none })
  set_hl(0, "BufferLineModifiedDiagnosticSelected", { bg = none })
  set_hl(0, "BufferLineDuplicateSelected",          { bg = none })
  set_hl(0, "BufferLineSeparatorSelected",          { fg = "#000000", bg = none })

  -- GitSigns
  set_hl(0, "GitSignsAdd",            { fg = "SpringGreen2",  bg = none })
  set_hl(0, "GitSignsAddLn",          { fg = "SpringGreen2",  bg = none })
  set_hl(0, "GitSignsAddNr",          { fg = "SpringGreen2",  bg = none })
  set_hl(0, "GitSignsChange",         { fg = "MediumPurple2", bg = none })
  set_hl(0, "GitSignsChangeLn",       { fg = "MediumPurple2", bg = none })
  set_hl(0, "GitSignsChangeNr",       { fg = "MediumPurple2", bg = none })
  set_hl(0, "GitSignsChangeDelete",   { fg = "Orange1",       bg = none })
  set_hl(0, "GitSignsChangeDeleteLn", { fg = "Orange1",       bg = none })
  set_hl(0, "GitSignsChangeDeleteNr", { fg = "Orange1",       bg = none })
  set_hl(0, "GitSignsUntracked",      { fg = "SkyBlue1",      bg = none })
  set_hl(0, "GitSignsUntrackedLn",    { fg = "SkyBlue1",      bg = none })
  set_hl(0, "GitSignsUntrackedNr",    { fg = "SkyBlue1",      bg = none })
  set_hl(0, "GitSignsTopDelete",      { fg = "Red1",          bg = none })
  set_hl(0, "GitSignsTopDeleteLn",    { fg = "Red1",          bg = none })
  set_hl(0, "GitSignsTopDeleteNr",    { fg = "Red1",          bg = none })
  set_hl(0, "GitSignsDelete",         { fg = "Red1",          bg = none })
  set_hl(0, "GitSignsDeleteLn",       { fg = "Red1",          bg = none })
  set_hl(0, "GitSignsDeleteNr",       { fg = "Red1",          bg = none })

  -- Markview
  set_hl(0, "MarkviewCode",              { bg = c["gray-100"] })
  set_hl(0, "MarkviewCodeInfo",          { fg = c["gray-55"],   bg = c["gray-100"] })
  set_hl(0, "MarkviewInlineCode",        { fg = c["orange-25"], bg = c["gray-95"] })
  set_hl(0, "MarkviewHeading1",          { fg = "#000000", bg = c["green-25"] })
  set_hl(0, "MarkviewHeading2",          { fg = "#000000", bg = c["yellow-25"] })
  set_hl(0, "MarkviewHeading3",          { fg = "#000000", bg = c["orange-25"] })
  set_hl(0, "MarkviewHeading4",          { fg = "#000000", bg = c["red-25"] })
  set_hl(0, "MarkviewHeading5",          { fg = "#000000", bg = c["purple-25"] })
  set_hl(0, "MarkviewHeading6",          { fg = "#000000", bg = c["blue-25"] })
  set_hl(0, "@markup.heading.1.markdown",{ link = "MarkviewHeading1" })
  set_hl(0, "@markup.heading.2.markdown",{ link = "MarkviewHeading2" })
  set_hl(0, "@markup.heading.3.markdown",{ link = "MarkviewHeading3" })
  set_hl(0, "@markup.heading.4.markdown",{ link = "MarkviewHeading4" })
  set_hl(0, "@markup.heading.5.markdown",{ link = "MarkviewHeading5" })
  set_hl(0, "@markup.heading.6.markdown",{ link = "MarkviewHeading6" })

  -- DevIcons (tab bar icons with transparent bg)
  local dev_icons = {
    DevIconDiffCurrent            = "#41535b", DevIconElmCurrent              = "#519aba",
    DevIconJlCurrent              = "#a270ba", DevIconDockerfileCurrent       = "#458ee6",
    DevIconXcPlaygroundCurrent    = "#e37933", DevIconSlnCurrent              = "#854cc7",
    DevIconTclCurrent             = "#1e5cb3", DevIconFsxCurrent              = "#519aba",
    DevIconTexCurrent             = "#3d6117", DevIconLuaCurrent              = "#51a0cf",
    DevIconJsxCurrent             = "#20c2e3", DevIconWasmCurrent             = "#5c4cdb",
    DevIconValaCurrent            = "#7239b3", DevIconGemfileCurrent          = "#701516",
    DevIconNPMrcCurrent           = "#e8274b", DevIconPlCurrent               = "#519aba",
    DevIconMlCurrent              = "#e37933", DevIconMarkdownCurrent         = "#519aba",
    DevIconCpCurrent              = "#519aba", DevIconLogCurrent              = "#ffffff",
    DevIconPycCurrent             = "#ffe291", DevIconCppCurrent              = "#519aba",
    DevIconEppCurrent             = "#ffa61a", DevIconGitConfigCurrent        = "#41535b",
    DevIconDesktopEntryCurrent    = "#563d7c", DevIconClojureCurrent          = "#8dc149",
    DevIconLiquidCurrent          = "#95bf47", DevIconHppCurrent              = "#a074c4",
    DevIconKotlinScriptCurrent    = "#7f52ff", DevIconBrewfileCurrent         = "#701516",
    DevIconExCurrent              = "#a074c4", DevIconMliCurrent              = "#e37933",
    DevIconEexCurrent             = "#a074c4", DevIconGitModulesCurrent       = "#41535b",
    DevIconEdnCurrent             = "#519aba", DevIconGodotProjectCurrent     = "#6d8086",
    DevIconSvgCurrent             = "#ffb13b", DevIconXulCurrent              = "#e37933",
    DevIconDartCurrent            = "#03589c", DevIconCMakeCurrent            = "#6d8086",
    DevIconOrgModeCurrent         = "#77aa99", DevIconTextSceneCurrent        = "#a074c4",
    DevIconHxxCurrent             = "#a074c4", DevIconBazelCurrent            = "#89e051",
    DevIconCobolCurrent           = "#005ca5", DevIconCxxCurrent              = "#519aba",
    DevIconGitLogoCurrent         = "#f14c28", DevIconJpegCurrent             = "#a074c4",
    DevIconWebpackCurrent         = "#519aba", DevIconTomlCurrent             = "#6d8086",
    DevIconDocCurrent             = "#185abd", DevIconLessCurrent             = "#563d7c",
    DevIconPptCurrent             = "#cb4a32", DevIconBmpCurrent              = "#a074c4",
    DevIconSqlCurrent             = "#dad8d8", DevIconGitCommitCurrent        = "#41535b",
    DevIconPrismaCurrent          = "#ffffff", DevIconRlibCurrent             = "#dea584",
    DevIconBzlCurrent             = "#89e051", DevIconEnvCurrent              = "#faf743",
    DevIconFsharpCurrent          = "#519aba", DevIconReScriptInterfaceCurrent= "#f55385",
    DevIconLicenseCurrent         = "#cbcb41", DevIconYmlCurrent              = "#6d8086",
    DevIconXmlCurrent             = "#e37933", DevIconGvimrcCurrent           = "#019833",
    DevIconTwigCurrent            = "#8dc149", DevIconMjsCurrent              = "#f1e05a",
    DevIconSmlCurrent             = "#e37933", DevIconCjsCurrent              = "#cbcb41",
    DevIconHeexCurrent            = "#a074c4", DevIconCsonCurrent             = "#cbcb41",
    DevIconDsStoreCurrent         = "#41535b", DevIconVagrantfileCurrent      = "#1563ff",
    DevIconMixLockCurrent         = "#a074c4", DevIconDropboxCurrent          = "#0061fe",
    DevIconCMakeListsCurrent      = "#6d8086", DevIconExsCurrent              = "#a074c4",
    DevIconBinaryGLTFCurrent      = "#ffb13b", DevIconTypeScriptReactSpecCurrent="#1354bf",
    DevIconDumpCurrent            = "#dad8d8", DevIconZshprofileCurrent       = "#89e051",
    DevIconPsbCurrent             = "#519aba", DevIconTextResourceCurrent     = "#cbcb41",
    DevIconSuoCurrent             = "#854cc7", DevIconNimCurrent              = "#f3d400",
    DevIconWebmanifestCurrent     = "#f1e05a", DevIconPackageLockJsonCurrent  = "#7a0d21",
    DevIconEslintrcCurrent        = "#4b32c3", DevIconLeexCurrent             = "#a074c4",
    DevIconMintCurrent            = "#87c095", DevIconTestJsCurrent           = "#cbcb41",
    DevIconWebpCurrent            = "#a074c4", DevIconVHDLCurrent             = "#019833",
    DevIconSystemVerilogCurrent   = "#019833", DevIconPsdCurrent              = "#519aba",
    DevIconBabelrcCurrent         = "#cbcb41", DevIconHrlCurrent              = "#b83998",
    DevIconRbCurrent              = "#701516", DevIconGitlabCICurrent         = "#e24329",
    DevIconMakefileCurrent        = "#6d8086", DevIconBashProfileCurrent      = "#89e051",
    DevIconGitAttributesCurrent   = "#41535b", DevIconClojureCCurrent         = "#8dc149",
    DevIconTerraformCurrent       = "#5f43e9", DevIconPrologCurrent           = "#e4b854",
    DevIconFennelCurrent          = "#fff3d7", DevIconJson5Current            = "#cbcb41",
    DevIconTxtCurrent             = "#89e051", DevIconRCurrent                = "#358a5b",
    DevIconZshrcCurrent           = "#89e051", DevIconDocxCurrent             = "#185abd",
    DevIconJsonCurrent            = "#cbcb41", DevIconGifCurrent              = "#a074c4",
    DevIconRmdCurrent             = "#519aba", DevIconXlsxCurrent             = "#207245",
    DevIconZshCurrent             = "#89e051", DevIconVerilogCurrent          = "#019833",
    DevIconCrystalCurrent         = "#c8c8c8", DevIconJpgCurrent              = "#a074c4",
    DevIconSpecJsCurrent          = "#cbcb41", DevIconBazelBuildCurrent       = "#89e051",
    DevIconJavaScriptReactTestCurrent="#20c2e3",DevIconFsscriptCurrent        = "#519aba",
    DevIconSigCurrent             = "#e37933", DevIconZigCurrent              = "#f69a1b",
    DevIconSvelteCurrent          = "#ff3e00", DevIconCCurrent                = "#599eff",
    DevIconEjsCurrent             = "#cbcb41", DevIconGruntfileCurrent        = "#e37933",
    DevIconZshenvCurrent          = "#89e051", DevIconBazelWorkspaceCurrent   = "#89e051",
    DevIconCPlusPlusCurrent       = "#f34b7d", DevIconSettingsJsonCurrent     = "#854cc7",
    DevIconImportConfigurationCurrent="#ececec",DevIconVimrcCurrent           = "#019833",
    DevIconHtmlCurrent            = "#e44d26", DevIconSwiftCurrent            = "#e37933",
    DevIconClojureDartCurrent     = "#519aba", DevIconStylCurrent             = "#8dc149",
    DevIconLhsCurrent             = "#a074c4", DevIconScalaCurrent            = "#cc3e44",
    DevIconTerminalCurrent        = "#31b53e", DevIconGulpfileCurrent         = "#cc3e44",
    DevIconCoffeeCurrent          = "#cbcb41", DevIconSolidityCurrent         = "#519aba",
    DevIconPsScriptModulefileCurrent="#6975c4",DevIconHamlCurrent             = "#eaeae1",
    DevIconNPMIgnoreCurrent       = "#e8274b", DevIconXlsCurrent              = "#207245",
    DevIconAwkCurrent             = "#4d5a5e", DevIconGoCurrent               = "#519aba",
    DevIconScssCurrent            = "#f55385", DevIconTFVarsCurrent           = "#5f43e9",
    DevIconRsCurrent              = "#dea584", DevIconPhpCurrent              = "#a074c4",
    DevIconHtmCurrent             = "#e34c26", DevIconTsCurrent               = "#519aba",
    DevIconPngCurrent             = "#a074c4", DevIconMotokoCurrent           = "#9772fb",
    DevIconReScriptCurrent        = "#cc3e44", DevIconDefaultCurrent          = "#6d8086",
    DevIconsbtCurrent             = "#cc3e44", DevIconProcfileCurrent         = "#a074c4",
    DevIconRssCurrent             = "#fb9d3b", DevIconCsCurrent               = "#596706",
    DevIconFsCurrent              = "#519aba", DevIconKotlinCurrent           = "#7f52ff",
    DevIconBatCurrent             = "#c1f12e", DevIconHbsCurrent              = "#f0772b",
    DevIconJsCurrent              = "#cbcb41", DevIconMdxCurrent              = "#519aba",
    DevIconHsCurrent              = "#a074c4", DevIconKshCurrent              = "#4d5a5e",
    DevIconGraphQLCurrent         = "#e535ab", DevIconBashrcCurrent           = "#89e051",
    DevIconOPUSCurrent            = "#f88a02", DevIconCshCurrent              = "#4d5a5e",
    DevIconCssCurrent             = "#42a5f5", DevIconFortranCurrent          = "#734f96",
    DevIconConfigurationCurrent   = "#ececec", DevIconGemspecCurrent          = "#701516",
    DevIconPmCurrent              = "#519aba", DevIconConfigRuCurrent         = "#701516",
    DevIconTestTsCurrent          = "#519aba", DevIconPackageJsonCurrent      = "#e8274b",
    DevIconErlCurrent             = "#b83998", DevIconDroolsCurrent           = "#ffafaf",
    DevIconQueryCurrent           = "#90a850", DevIconSchemeCurrent           = "#000000",
    DevIconDbCurrent              = "#dad8d8", DevIconPyCurrent               = "#ffbc03",
    DevIconMaterialCurrent        = "#b83998", DevIconIniCurrent              = "#6d8086",
    DevIconDCurrent               = "#427819", DevIconOpenTypeFontCurrent     = "#ececec",
    DevIconRakeCurrent            = "#701516", DevIconLockCurrent             = "#bbbbbb",
    DevIconClojureJSCurrent       = "#519aba", DevIconBashCurrent             = "#89e051",
    DevIconIcoCurrent             = "#cbcb41", DevIconAiCurrent               = "#cbcb41",
    DevIconRprojCurrent           = "#358a5b", DevIconVueCurrent              = "#8dc149",
    DevIconGDScriptCurrent        = "#6d8086", DevIconGitIgnoreCurrent        = "#41535b",
    DevIconJavaCurrent            = "#cc3e44", DevIconFaviconCurrent          = "#cbcb41",
    DevIconHCurrent               = "#a074c4", DevIconPdfCurrent              = "#b30b00",
    DevIconPydCurrent             = "#ffe291", DevIconNodeModulesCurrent      = "#e8274b",
    DevIconSassCurrent            = "#f55385", DevIconNixCurrent              = "#7ebae4",
    DevIconLuauCurrent            = "#51a0cf", DevIconYamlCurrent             = "#6d8086",
    DevIconPsScriptfileCurrent    = "#4273ca", DevIconSpecTsCurrent           = "#519aba",
    DevIconHhCurrent              = "#a074c4", DevIconCsvCurrent              = "#89e051",
    DevIconPyoCurrent             = "#ffe291", DevIconVimCurrent              = "#019833",
    DevIconMdCurrent              = "#ffffff", DevIconPsManifestfileCurrent   = "#6975c4",
    DevIconSlimCurrent            = "#e34c26", DevIconFishCurrent             = "#4d5a5e",
    DevIconJavaScriptReactSpecCurrent="#20c2e3",DevIconMustacheCurrent        = "#e37933",
    DevIconFsiCurrent             = "#519aba", DevIconTorCurrent              = "#519aba",
    DevIconRakefileCurrent        = "#701516", DevIconTypeScriptReactTestCurrent="#1354bf",
    DevIconPackedResourceCurrent  = "#6d8086", DevIconErbCurrent              = "#701516",
    DevIconShCurrent              = "#4d5a5e", DevIconConfCurrent             = "#6d8086",
    DevIconPpCurrent              = "#ffa61a", DevIconTsxCurrent              = "#1354bf",
  }
  for name, fg in pairs(dev_icons) do
    set_hl(0, name, { bg = none, ctermbg = "None", fg = fg })
  end

  -- CursorLine toggle in insert mode
  local group = vim.api.nvim_create_augroup("MythemeCursorLine", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = group,
    pattern = "*",
    command = "set cul!",
  })

  -- LSP sign column icons
  vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  vim.fn.sign_define("DiagnosticSignWarn",  { text = "", texthl = "DiagnosticWarn",  linehl = "", numhl = "" })
  vim.fn.sign_define("DiagnosticSignInfo",  { text = "", texthl = "DiagnosticInfo",  linehl = "", numhl = "" })
  vim.fn.sign_define("DiagnosticSignHint",  { text = "", texthl = "DiagnosticHint",  linehl = "", numhl = "" })
end

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
