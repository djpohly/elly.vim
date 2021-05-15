" Initialisation:"{{{
" ----------------------------------------------------------------------------
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "elly"

let s:termmode = "gui"
if (exists("g:elly_termmode") && g:elly_termmode == "cterm")
  set notermguicolors
  let s:termmode = "cterm"
endif

let s:colormode = "dark"
if (exists("g:elly_colormode") && g:elly_colormode == "light")
  let s:colormode = "light"
endif
"}}}


" Palettes:"{{{
" ----------------------------------------------------------------------------
let s:palette = {}
let s:palette.bg        = {"gui": {"dark": "#111a1f", "light": "#111a1f"}, "cterm": {"dark": "232", "light": "232"}}
let s:palette.comment   = {"gui": {"dark": "#545759", "light": "#545759"}, "cterm": {"dark": "240", "light": "240"}}
let s:palette.markup    = {"gui": {"dark": "#8D7856", "light": "#8D7856"}, "cterm": {"dark": "101", "light": "101"}}
let s:palette.constant  = {"gui": {"dark": "#738C9C", "light": "#738C9C"}, "cterm": {"dark": "23",  "light": "23"}}
let s:palette.operator  = {"gui": {"dark": "#738C9C", "light": "#738C9C"}, "cterm": {"dark": "23",  "light": "23"}}
let s:palette.tag       = {"gui": {"dark": "#8D7856", "light": "#8D7856"}, "cterm": {"dark": "101", "light": "101"}}
let s:palette.regexp    = {"gui": {"dark": "#6998B3", "light": "#6998B3"}, "cterm": {"dark": "75",  "light": "75"}}
let s:palette.string    = {"gui": {"dark": "#798362", "light": "#798362"}, "cterm": {"dark": "66",  "light": "66"}}
let s:palette.function  = {"gui": {"dark": "#8D7856", "light": "#8D7856"}, "cterm": {"dark": "101", "light": "101"}}
let s:palette.special   = {"gui": {"dark": "#9B9257", "light": "#9B9257"}, "cterm": {"dark": "100", "light": "100"}}
let s:palette.keyword   = {"gui": {"dark": "#8D7856", "light": "#8D7856"}, "cterm": {"dark": "101", "light": "101"}}
let s:palette.error     = {"gui": {"dark": "#810002", "light": "#810002"}, "cterm": {"dark": "1",   "light": "1"}}
let s:palette.accent    = {"gui": {"dark": "#9B9257", "light": "#9B9257"}, "cterm": {"dark": "100", "light": "100"}}
let s:palette.panel     = {"gui": {"dark": "#14191F", "light": "#14191F"}, "cterm": {"dark": "234", "light": "234"}}
let s:palette.guide     = {"gui": {"dark": "#2D3640", "light": "#2D3640"}, "cterm": {"dark": "235", "light": "235"}}
let s:palette.line      = {"gui": {"dark": "#151A1E", "light": "#151A1E"}, "cterm": {"dark": "234", "light": "234"}}
let s:palette.selection = {"gui": {"dark": "#253340", "light": "#253340"}, "cterm": {"dark": "235", "light": "235"}}
let s:palette.fg        = {"gui": {"dark": "#ACB3B5", "light": "#ACB3B5"}, "cterm": {"dark": "248", "light": "248"}}
let s:palette.fg_idle   = {"gui": {"dark": "#3E4B59", "light": "#3E4B59"}, "cterm": {"dark": "237", "light": "237"}}
let s:palette.termblue  = {"gui": {"dark": "#63768A", "light": "#63768A"}, "cterm": {"dark": "117", "light": "117"}}
let s:palette.termgray  = {"gui": {"dark": "#868b8d", "light": "#868b8d"}, "cterm": {"dark": "245", "light": "245"}}
let s:palette.diffg     = {"gui": {"dark": "#012800", "light": "#012800"}, "cterm": {"dark": "232", "light": "232"}}
let s:palette.diffr     = {"gui": {"dark": "#340001", "light": "#340001"}, "cterm": {"dark": "52",  "light": "52"}}
let s:palette.cdiffg    = {"gui": {"dark": "#037500", "light": "#037500"}, "cterm": {"dark": "2",   "light": "2"}}
let s:palette.cdiffy    = {"gui": {"dark": "#817e00", "light": "#817e00"}, "cterm": {"dark": "3",   "light": "3"}}
let s:palette.cdiffr    = {"gui": {"dark": "#810002", "light": "#810002"}, "cterm": {"dark": "1",   "light": "1"}}
"}}}


" Highlighting Primitives:"{{{
" ----------------------------------------------------------------------------
function! s:build_prim(hi_elem, field)
  let l:vname = "s:" . a:hi_elem . "_" . a:field "
  let l:gui_assign = s:termmode . a:hi_elem . "=" . s:palette[a:field][s:termmode][s:colormode]
  exe "let " . l:vname . " = ' " . l:gui_assign . "'"
endfunction
let s:bg_none = " ".s:termmode."bg=NONE"
let s:fg_none = " ".s:termmode."fg=NONE"
for [key_name, d_value] in items(s:palette)
  call s:build_prim('bg', key_name)
  call s:build_prim('fg', key_name)
endfor
" }}}


" Formatting Options:"{{{
" ----------------------------------------------------------------------------
let s:none   = "NONE"
let s:t_none = "NONE"
let s:n      = "NONE"
let s:c      = ",undercurl"
let s:r      = ",reverse"
let s:s      = ",standout"
let s:b      = ",bold"
let s:u      = ",underline"
let s:i      = ",italic"
exe "let s:fmt_none = ' gui=NONE".          " cterm=NONE".          " term=NONE"        ."'"
exe "let s:fmt_bold = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_bldi = ' gui=NONE".s:b.      " cterm=NONE".s:b.      " term=NONE".s:b    ."'"
exe "let s:fmt_undr = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_undb = ' gui=NONE".s:u.s:b.  " cterm=NONE".s:u.s:b.  " term=NONE".s:u.s:b."'"
exe "let s:fmt_undi = ' gui=NONE".s:u.      " cterm=NONE".s:u.      " term=NONE".s:u    ."'"
exe "let s:fmt_curl = ' gui=NONE".s:c.      " cterm=NONE".s:c.      " term=NONE".s:c    ."'"
exe "let s:fmt_ital = ' gui=NONE".s:i.      " cterm=NONE".s:i.      " term=NONE".s:i    ."'"
exe "let s:fmt_stnd = ' gui=NONE".s:s.      " cterm=NONE".s:s.      " term=NONE".s:s    ."'"
exe "let s:fmt_revr = ' gui=NONE".s:r.      " cterm=NONE".s:r.      " term=NONE".s:r    ."'"
exe "let s:fmt_revb = ' gui=NONE".s:r.s:b.  " cterm=NONE".s:r.s:b.  " term=NONE".s:r.s:b."'"
"}}}


" Vim Highlighting: "{{{
" ----------------------------------------------------------------------------
exe "hi! Normal"        .s:fg_fg          .s:bg_bg          .s:fmt_none
exe "hi! ColorColumn"   .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! Constant"      .s:fg_accent      .s:bg_line        .s:fmt_none
exe "hi! CursorColumn"  .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! CursorLine"    .s:fg_none        .s:bg_line        .s:fmt_none
exe "hi! CursorLineNr"  .s:fg_accent      .s:bg_line        .s:fmt_none
exe "hi! LineNr"        .s:fg_guide       .s:bg_none        .s:fmt_none
exe "hi! Directory"     .s:fg_fg_idle     .s:bg_none        .s:fmt_none
exe "hi! DiffAdd"       .s:fg_string      .s:bg_panel       .s:fmt_none
exe "hi! DiffChange"    .s:fg_tag         .s:bg_panel       .s:fmt_none
exe "hi! DiffText"      .s:fg_fg          .s:bg_panel       .s:fmt_none
exe "hi! ErrorMsg"      .s:fg_error       .s:bg_none        .s:fmt_none
exe "hi! EndOfBuffer"   .s:fg_bg          .s:bg_none        .s:fmt_none
exe "hi! VertSplit"     .s:fg_comment     .s:bg_none        .s:fmt_none
exe "hi! Folded"        .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
exe "hi! FoldColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
exe "hi! SignColumn"    .s:fg_none        .s:bg_bg          .s:fmt_none
exe "hi! MatchParen"    .s:fg_fg          .s:bg_bg          .s:fmt_undr
exe "hi! ModeMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! MoreMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! NonText"       .s:fg_guide       .s:bg_none        .s:fmt_none
exe "hi! Pmenu"         .s:fg_fg          .s:bg_selection   .s:fmt_none
exe "hi! PmenuSel"      .s:fg_fg          .s:bg_selection   .s:fmt_revr
exe "hi! Question"      .s:fg_string      .s:bg_none        .s:fmt_none
exe "hi! Search"        .s:fg_bg          .s:bg_special     .s:fmt_none
exe "hi! SpecialKey"    .s:fg_selection   .s:bg_none        .s:fmt_none
exe "hi! SpellCap"      .s:fg_tag         .s:bg_none        .s:fmt_undr
exe "hi! SpellLocal"    .s:fg_keyword     .s:bg_none        .s:fmt_undr
exe "hi! SpellBad"      .s:fg_error       .s:bg_none        .s:fmt_undr
exe "hi! SpellRare"     .s:fg_regexp      .s:bg_none        .s:fmt_undr
exe "hi! StatusLine"    .s:fg_fg          .s:bg_panel       .s:fmt_none
exe "hi! StatusLineNC"  .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
exe "hi! WildMenu"      .s:fg_bg          .s:bg_markup      .s:fmt_none
exe "hi! TabLine"       .s:fg_fg          .s:bg_panel       .s:fmt_revr
exe "hi! Title"         .s:fg_constant    .s:bg_none        .s:fmt_none
exe "hi! Visual"        .s:fg_accent      .s:bg_guide       .s:fmt_none
exe "hi! WarningMsg"    .s:fg_error       .s:bg_none        .s:fmt_none
"}}}


" Generic Syntax Highlighting: "{{{
" ----------------------------------------------------------------------------
exe "hi! Comment"           .s:fg_comment   .s:bg_none        .s:fmt_none
exe "hi! String"            .s:fg_string    .s:bg_none        .s:fmt_none
exe "hi! Identifier"        .s:fg_tag       .s:bg_none        .s:fmt_none
exe "hi! Function"          .s:fg_function  .s:bg_none        .s:fmt_none
exe "hi! Statement"         .s:fg_keyword   .s:bg_none        .s:fmt_none
exe "hi! Operator"          .s:fg_fg        .s:bg_none        .s:fmt_none
exe "hi! Keyword"           .s:fg_operator  .s:bg_none        .s:fmt_none
exe "hi! PreProc"           .s:fg_special   .s:bg_none        .s:fmt_none
exe "hi! Type"              .s:fg_accent    .s:bg_none        .s:fmt_none
exe "hi! Structure"         .s:fg_special   .s:bg_none        .s:fmt_none
exe "hi! Special"           .s:fg_operator  .s:bg_none        .s:fmt_none
exe "hi! Underlined"        .s:fg_tag       .s:bg_none        .s:fmt_undr
exe "hi! Ignore"            .s:fg_none      .s:bg_none        .s:fmt_none
exe "hi! Error"             .s:fg_fg        .s:bg_error       .s:fmt_none
exe "hi! Todo"              .s:fg_markup    .s:bg_none        .s:fmt_none
exe "hi! qfLineNr"          .s:fg_keyword   .s:bg_none        .s:fmt_none
exe "hi! Conceal"           .s:fg_guide     .s:bg_none        .s:fmt_none
exe "hi! CursorLineConceal" .s:fg_guide     .s:bg_line        .s:fmt_none
exe "hi! DiffAdd"           .s:fg_none      .s:bg_diffg       .s:fmt_none
exe "hi! DiffText"          .s:fg_none      .s:bg_diffg       .s:fmt_none
exe "hi! DiffChange"        .s:fg_none      .s:bg_diffg       .s:fmt_none
exe "hi! DiffDelete"        .s:fg_diffr     .s:bg_diffr       .s:fmt_none
"}}}


" Terminal: "{{{
" ----------------------------------------------------------------------------
if has("nvim")
  let g:terminal_color_0  = s:palette.bg
  let g:terminal_color_1  = s:palette.markup
  let g:terminal_color_2  = s:palette.string
  let g:terminal_color_3  = s:palette.accent
  let g:terminal_color_4  = s:palette.termblue
  let g:terminal_color_5  = s:palette.constant
  let g:terminal_color_6  = s:palette.regexp
  let g:terminal_color_7  = s:palette.fg
  let g:terminal_color_8  = s:palette.termgray
  let g:terminal_color_9  = s:palette.markup
  let g:terminal_color_10 = s:palette.string
  let g:terminal_color_11 = s:palette.accent
  let g:terminal_color_12 = s:palette.termblue
  let g:terminal_color_13 = s:palette.constant
  let g:terminal_color_14 = s:palette.regexp
  let g:terminal_color_15 = s:palette.fg
  let g:terminal_color_backround = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_7
else
  let g:terminal_ansi_colors =  [s:palette.bg,       s:palette.markup]
  let g:terminal_ansi_colors += [s:palette.string,   s:palette.accent]
  let g:terminal_ansi_colors += [s:palette.termblue, s:palette.constant]
  let g:terminal_ansi_colors += [s:palette.regexp,   s:palette.fg]
  let g:terminal_ansi_colors += [s:palette.termgray, s:palette.markup]
  let g:terminal_ansi_colors += [s:palette.string,   s:palette.accent]
  let g:terminal_ansi_colors += [s:palette.termblue, s:palette.constant]
  let g:terminal_ansi_colors += [s:palette.regexp,   s:palette.fg]
endif
" }}}


" Plugins: "{{{
" ----------------------------------------------------------------------------
" NerdTree
" ---------
exe "hi! NERDTreeOpenable"      .s:fg_fg_idle    .s:bg_none        .s:fmt_none
exe "hi! NERDTreeClosable"      .s:fg_accent     .s:bg_none        .s:fmt_none
exe "hi! NERDTreeUp"            .s:fg_fg_idle    .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDir"           .s:fg_function   .s:bg_none        .s:fmt_none
exe "hi! NERDTreeFile"          .s:fg_none       .s:bg_none        .s:fmt_none
exe "hi! NERDTreeDirSlash"      .s:fg_accent     .s:bg_none        .s:fmt_none

" GitGutter
" ---------
exe "hi! GitGutterAdd"          .s:fg_string     .s:bg_none        .s:fmt_none
exe "hi! GitGutterChange"       .s:fg_tag        .s:bg_none        .s:fmt_none
exe "hi! GitGutterDelete"       .s:fg_markup     .s:bg_none        .s:fmt_none
exe "hi! GitGutterChangeDelete" .s:fg_function   .s:bg_none        .s:fmt_none

" ale
" ---------
exe "hi! ALEError"              . s:fg_none      .s:bg_none        .s:fmt_curl
exe "hi! ALEErrorSign"          . s:fg_none      .s:bg_error       .s:fmt_none
exe "hi! ALEWarning"            . s:fg_none      .s:bg_none        .s:fmt_curl
exe "hi! ALEWarningSign"        . s:fg_none      .s:bg_accent      .s:fmt_none

" coc-git
" ---------
exe "hi! CocDiffAdd"            . s:fg_cdiffg    .s:bg_none        .s:fmt_none
exe "hi! CocDiffChange"         . s:fg_cdiffy    .s:bg_none        .s:fmt_none
exe "hi! CocDiffDelete"         . s:fg_cdiffr    .s:bg_none        .s:fmt_none
