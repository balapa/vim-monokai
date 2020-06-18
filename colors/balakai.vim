" Maintainer	Bhakti Pasaribu
" Github			https://github.com/balapa/vim-monokai

" Init
if !has('gui_running') && &t_Co < 256
  finish
endif

if !exists('g:balakai_gui_italic')
  let g:balakai_gui_italic = 0
endif

if !exists('g:balakai_term_italic')
  let g:balakai_term_italic = 0
endif

let g:balakai_termcolors = 256 " does not support 16 color term right now.

hi clear
if exists('syntax_on')
  syntax reset
endif

let colors_name = 'balakai'

fun! s:h(group, style)
  let s:ctermformat = 'NONE'
  let s:guiformat = 'NONE'
  if has_key(a:style, 'format')
    let s:ctermformat = a:style.format
    let s:guiformat = a:style.format
  endif
  if g:balakai_term_italic == 0
    let s:ctermformat = substitute(s:ctermformat, ',italic', '', '')
    let s:ctermformat = substitute(s:ctermformat, 'italic,', '', '')
    let s:ctermformat = substitute(s:ctermformat, 'italic', '', '')
  endif
  if g:balakai_gui_italic == 0
    let s:guiformat = substitute(s:guiformat, ',italic', '', '')
    let s:guiformat = substitute(s:guiformat, 'italic,', '', '')
    let s:guiformat = substitute(s:guiformat, 'italic', '', '')
  endif
  if g:balakai_termcolors == 16
    let l:ctermfg = (has_key(a:style, 'fg') ? a:style.fg.cterm16 : 'NONE')
    let l:ctermbg = (has_key(a:style, 'bg') ? a:style.bg.cterm16 : 'NONE')
  else
    let l:ctermfg = (has_key(a:style, 'fg') ? a:style.fg.cterm : 'NONE')
    let l:ctermbg = (has_key(a:style, 'bg') ? a:style.bg.cterm : 'NONE')
  end
  execute 'highlight' a:group
    \ 'guifg='   (has_key(a:style, 'fg')      ? a:style.fg.gui   : 'NONE')
    \ 'guibg='   (has_key(a:style, 'bg')      ? a:style.bg.gui   : 'NONE')
    \ 'guisp='   (has_key(a:style, 'sp')      ? a:style.sp.gui   : 'NONE')
    \ 'gui='     (!empty(s:guiformat) ? s:guiformat   : 'NONE')
    \ 'ctermfg=' . l:ctermfg
    \ 'ctermbg=' . l:ctermbg
    \ 'cterm='   (!empty(s:ctermformat) ? s:ctermformat   : 'NONE')
endfunction

" Expose the more complicated style setting via a global function
fun! g:SublimebalakaiHighlight(group, style)
	return s:h(a:group, a:style)
endfun

" Palette

" Convenience function to have a convenient script variable name and an
" namespaced global variable
fun! s:create_palette_color(color_name, color_data)
	exec 'let s:' . a:color_name . ' = a:color_data'
	exec 'let g:sublime_balakai_' . a:color_name . ' = a:color_data'
endf

call s:create_palette_color('brightwhite',  { 'gui': '#FFFFFF', 'cterm': '255' })
call s:create_palette_color('white',        { 'gui': '#E8E8E3', 'cterm': '255' })
call s:create_palette_color('black',        { 'gui': '#272822', 'cterm': '234' })
call s:create_palette_color('lightblack',   { 'gui': '#2D2E27', 'cterm': '235' })
call s:create_palette_color('lightblack2',  { 'gui': '#383a3e', 'cterm': '236' })
call s:create_palette_color('darkblack',    { 'gui': '#211F1C', 'cterm': '233' })
call s:create_palette_color('grey',         { 'gui': '#8F908A', 'cterm': '243' })
call s:create_palette_color('lightgrey',    { 'gui': '#575b61', 'cterm': '237' })
call s:create_palette_color('darkgrey',     { 'gui': '#64645e', 'cterm': '239' })
call s:create_palette_color('warmgrey',     { 'gui': '#777777', 'cterm': '243' })
" tag <html>
call s:create_palette_color('pink',         { 'gui': '#f92772', 'cterm': '197' })
" function name
call s:create_palette_color('green',        { 'gui': '#a6e22d', 'cterm': '112' })
" const tl
call s:create_palette_color('aqua',         { 'gui': '#66d9ef', 'cterm': '81'  })
" string inside quotes 'yellow'
call s:create_palette_color('yellow',       { 'gui': '#e6db74', 'cterm': '186' })
call s:create_palette_color('orange',       { 'gui': '#fd9720', 'cterm': '208' })
call s:create_palette_color('purple',       { 'gui': '#ae81ff', 'cterm': '141' })
call s:create_palette_color('red',          { 'gui': '#e74c3c', 'cterm': '205' })
call s:create_palette_color('darkred',      { 'gui': '#c0392b', 'cterm': '196' })

call s:create_palette_color('addfg',        { 'gui': '#d7ffaf', 'cterm': '193' })
call s:create_palette_color('addbg',        { 'gui': '#5f875f', 'cterm': '65'  })
call s:create_palette_color('delbg',        { 'gui': '#f75f5f', 'cterm': '167' })
call s:create_palette_color('changefg',     { 'gui': '#d7d7ff', 'cterm': '189' })
call s:create_palette_color('changebg',     { 'gui': '#5f5f87', 'cterm': '60'  })

" Expose the foreground colors of the Sublime palette as a bunch of
" highlighting groups. This lets us (and users!) get tab completion for the `hi
" link` command, and use more semantic names for the colors we want to assign
" to groups

call s:h('SublimeBrightWhite', { 'fg': s:brightwhite  })
call s:h('SublimeWhite',       { 'fg': s:white        })
call s:h('SublimeBlack',       { 'fg': s:black        })
call s:h('SublimeLightBlack',  { 'fg': s:lightblack   })
call s:h('SublimeLightBlack2', { 'fg': s:lightblack2  })
call s:h('SublimeDarkBlack',   { 'fg': s:darkblack    })
call s:h('SublimeGrey',        { 'fg': s:grey         })
call s:h('SublimeLightGrey',   { 'fg': s:lightgrey    })
call s:h('SublimeDarkGrey',    { 'fg': s:darkgrey     })
call s:h('SublimeWarmGrey',    { 'fg': s:warmgrey     })

call s:h('SublimePink',        { 'fg': s:pink         })
call s:h('SublimeGreen',       { 'fg': s:green        })
call s:h('SublimeAqua',        { 'fg': s:aqua         })
call s:h('SublimeYellow',      { 'fg': s:yellow       })
call s:h('SublimeOrange',      { 'fg': s:orange       })
call s:h('SublimePurple',      { 'fg': s:purple       })
call s:h('SublimeRed',         { 'fg': s:red          })
call s:h('SublimeDarkRed',     { 'fg': s:darkred      })

" Default highlight groups (see ':help highlight-default' or http://vimdoc.sourceforge.net/htmldoc/syntax.html#highlight-groups)

hi! link ColorColumn SublimeLightBlack
hi! link Conceal SublimeLightGrey
call s:h('CursorLine',   { 'bg': s:lightblack2                                                })
call s:h('CursorColumn',   { 'bg': s:lightblack2                                                })
call s:h('CursorLineNr', { 'fg': s:orange,     'bg': s:lightblack                             })
call s:h('DiffAdd',      { 'fg': s:addfg,      'bg': s:addbg                                  })
call s:h('DiffChange',   { 'fg': s:changefg,   'bg': s:changebg                               })
call s:h('DiffDelete',   { 'fg': s:black,      'bg': s:delbg                                  })
call s:h('DiffText',     { 'fg': s:black,      'bg': s:aqua                                   })
hi! link Directory SublimeAqua
call s:h('ErrorMsg',     { 'fg': s:pink })
hi! link FoldColumn SublimeDarkBlack
call s:h('Folded',       { 'fg': s:warmgrey,   'bg': s:darkblack                              })
call s:h('Incsearch',    { 'fg': s:black, 'bg': s:white                                       })
call s:h('LineNr',       { 'fg': s:grey,       'bg': s:lightblack                             })
call s:h('MatchParen',   { 'bg': s:yellow, 'fg': s:black })
hi! link ModeMsg SublimeAqua
hi! link MoreMsg SublimeAqua
hi! link NonText SublimeLightGrey
call s:h('Normal',       { 'fg': s:white,      'bg': s:black                                  })
call s:h('Pmenu',        { 'fg': s:lightblack, 'bg': s:white                                  })
call s:h('PmenuSbar',    {                                                                    })
call s:h('PmenuSel',     { 'fg': s:aqua,       'bg': s:black,        'format': 'reverse,bold' })
call s:h('PmenuThumb',   { 'fg': s:lightblack, 'bg': s:grey                                   })
hi! link Question SublimeYellow
call s:h('Search',	 { 'bg': s:aqua,     'fg': s:black })
hi! link SignColumn SublimeLightBlack
hi! link SpecialKey SublimeLightBlack2
call s:h('StatusLine',   { 'fg': s:warmgrey,   'bg': s:black,        'format': 'reverse'      })
call s:h('StatusLineNC', { 'fg': s:darkgrey,   'bg': s:warmgrey,     'format': 'reverse'      })
call s:h('TabLine',      { 'fg': s:white,      'bg': s:darkgrey                               })
call s:h('TabLineFill',  { 'fg': s:grey,       'bg': s:darkgrey                               })
call s:h('TabLineSel',   { 'fg': s:brightwhite,      'bg': s:grey                             })
hi! link Title SublimeYellow
call s:h('VertSplit',    { 'fg': s:darkgrey,   'bg': s:darkblack                              })
call s:h('Visual',       { 'bg': s:lightgrey                                                  })
hi! link WarningMsg SublimeWhite

" Generic Syntax Highlighting (see reference: 'NAMING CONVENTIONS' at http://vimdoc.sourceforge.net/htmldoc/syntax.html#group-name)

hi! link Comment SublimeWarmGrey
hi! link Constant SublimePurple
hi! link String SublimeYellow
hi! link Character SublimeYellow
hi! link Number SublimePurple
hi! link Boolean SublimePurple
hi! link Float SublimePurple
hi! link Identifier SublimeWhite
hi! link Function SublimeWhite
hi! link Type SublimeAqua
hi! link StorageClass SublimePink
hi! link Structure SublimePink
hi! link Typedef SublimeAqua
hi! link Statement SublimeWhite
hi! link Conditional SublimePink
hi! link Repeat SublimePink
hi! link Label SublimePink
hi! link Operator SublimePink
hi! link Keyword SublimePink
hi! link Exception SublimePink
call s:h('CommentURL',    { 'fg': s:grey, 'format': 'italic' })

hi! link PreProc SublimeGreen
hi! link Include SublimeWhite
hi! link Define SublimePink
hi! link Macro SublimeGreen
hi! link PreCondit SublimeWhite
hi! link Special SublimePurple
hi! link SpecialChar SublimePink
hi! link Tag SublimeGreen
hi! link Delimiter SublimePink
hi! link SpecialComment SublimeAqua
" call s:h('Debug'          {})
call s:h('Underlined',    { 'format': 'underline' })
" call s:h('Ignore',        {})
call s:h('Error',         { 'fg': s:red, 'bg': s:darkred })
hi! link Todo Comment

" Some highlighting groups custom to the Sublime balakai theme

call s:h('SublimeType',   { 'fg': s:aqua, 'format': 'italic' })
call s:h('SublimeContextParam',  { 'fg': s:orange, 'format': 'italic' })
hi! link SublimeDocumentation SublimeGrey
hi! link SublimeFunctionCall SublimeAqua
hi! link SublimeUserAttribute SublimeGrey

" Bash

hi! link shConditional Conditional
hi! link shDerefOff    SublimeWhite
hi! link shDerefSimple SublimeAqua
hi! link shDerefVar    SublimeAqua
hi! link shFunctionKey SublimePink
hi! link shLoop        Keyword
hi! link shQuote       String
hi! link shSet         Keyword

" C

hi! link cAnsiFunction SublimeFunctionCall
hi! link cDefine       SublimeGreen
hi! link cFormat       Special
hi! link cInclude      SublimePink
hi! link cLabel        SublimePink
hi! link cStorageClass SublimePink
hi! link cStructure    SublimeType
hi! link cType         SublimeType
" FIXME: Function definitions

" CSS

hi! link cssAttr              SublimeAqua
hi! link cssAttributeSelector Tag
" XXX: Not sure about this one; it has issues with the following:
"   - calc
"   - colors
hi! link cssAttrRegion      Normal
hi! link cssBraces          Normal
hi! link cssClassName       Keyword
hi! link cssColor           Constant
hi! link cssFunctionName    SublimeFunctionCall
hi! link cssIdentifier      Tag
hi! link cssPositioningAttr SublimeAqua
hi! link cssProp            SublimeAqua
" XXX: Variation: might be better as pink, actually
hi! link cssPseudoClassId   Normal
hi! link cssSelectorOp      Normal
hi! link cssStyle           cssAttr
hi! link cssTagName         Keyword
" TODO: Find a way to distinguish unit decorators from color hash
hi! link cssUnitDecorators  SpecialChar
hi! link cssURL             String
hi! link cssValueLength     Constant

" STYLUS
hi! link stylusProperty							Normal
hi! link stylusVariable							Normal
hi! link stylusAmpersand						Normal
hi! link stylusVariableAssignment		SublimePurple
hi! link stylusClass								SublimeYellow
hi! link stylusCssProperties				Normal
hi! link stylusCssValues						Normal
hi! link stylusId										SublimeGreen
hi! link stylusFunction							SublimeFunctionCall
hi! link stylusControl							PreProc
hi! link stylusInterpolation				Delimiter
hi! link stylusClassChar						Normal
hi! link stylusIdChar								Normal
hi! link stylusEscape								Special

" eRuby

" call s:h('erubyDelimiter',              {})
hi! link erubyRailsMethod SublimeAqua

" HTML
" This partially depends on XML -- make sure that groups in XML don't
" adversely affect this!

" XXX: This doesn't exclude things like colons like Sublime does
" FIXME: For some reason this is excluding a "key" attribute
hi! link htmlArg            Tag
" Variation: This is an interesting idea for
hi! link htmlLink           Normal
hi! link htmlSpecialTagName htmlTagName
hi! link htmlSpecialChar    Special
hi! link htmlTagName        Keyword

" JavaScript

hi! link jsArgsObj						SublimeAqua
hi! link jsArrowFunction			SublimePink
hi! link jsBuiltins						SublimeFunctionCall
hi! link jsCatch							Keyword
hi! link jsConditional				Keyword
call s:h('jsDocTags',					{ 'fg': s:aqua, 'format': 'italic' })
hi! link jsException					Keyword
" Variation: It's actually nice to get this italicized, to me
hi! link jsExceptions					Type
hi! link jsExport							Keyword
hi! link jsFinally						Keyword
hi! link jsFrom								Keyword
call s:h('jsFuncArgRest',			{ 'fg': s:purple, 'format': 'italic' })
hi! link jsFuncArgs						SublimeContextParam
hi! link jsFuncCall						SublimeFunctionCall
hi! link jsFuncName						Tag
hi! link jsFunctionKey				Tag
" FIXME: FutureKeys includes a bit too much. It had some type names, which should be aqua, but most of the keywords that might actually get used would be pink (keywords like public, abstract).
call s:h('jsGlobalObjects',		{ 'fg': s:aqua, 'format': 'italic' })
hi! link jsFutureKeys					Keyword
hi! link jsImport							Keyword
hi! link jsModuleAs						Keyword
hi! link jsModuleAsterisk			Keyword
hi! link jsNan								Constant
hi! link jsNull								Constant
hi! link jsObjectFuncName			Tag
hi! link jsPrototype					SublimeAqua
" Variation: Technically this is extra from Sublime, but it looks nice.
hi! link jsRepeat							Keyword
hi! link jsReturn							Keyword
hi! link jsStatement					Keyword
hi! link jsStatic							jsStorageClass
hi! link jsStorageClass				SublimeAqua
hi! link jsSuper							SublimeContextParam
hi! link jsThis								SublimeContextParam
hi! link jsTry								Keyword
hi! link jsUndefined					Constant

" JSON

hi! link jsonKeyword Normal

" LESS

hi! link lessVariable Tag

" Makefile

hi! link makeCommands    Normal
hi! link makeCmdNextLine Normal

" NERDTree

hi! link NERDTreeBookmarkName    SublimeYellow
hi! link NERDTreeBookmarksHeader SublimePink
hi! link NERDTreeBookmarksLeader SublimeBlack
hi! link NERDTreeCWD             SublimePink
hi! link NERDTreeClosable        SublimePurple
hi! link NERDTreeDir             SublimePurple
hi! link NERDTreeDirSlash        SublimeGrey
hi! link NERDTreeFlags           SublimeDarkGrey
hi! link NERDTreeHelp            SublimeYellow
hi! link NERDTreeOpenable        SublimePurple
hi! link NERDTreeUp              SublimeWhite

" NERDTree Git

hi! link NERDTreeGitStatusModified SublimeOrange
hi! link NERDTreeGitStatusRenamed SublimeOrange
hi! link NERDTreeGitStatusUntracked SublimeGreen

" Python

" This configuration assumed python-mode
hi! link pythonConditional Conditional
hi! link pythonException   Keyword
hi! link pythonFunction    Tag
hi! link pythonInclude     Keyword
" XXX: def parens are, for some reason, included in this group.
hi! link pythonParam       SublimeContextParam
" XXX: pythonStatement covers a bit too much...unfortunately, this means that
" some keywords, like `def`, can't be highlighted like in Sublime yet.
hi! link pythonStatement   Keyword
" FIXME: Python special regexp sequences aren't highlighted. :\

" Ruby

" call s:h('rubyInterpolationDelimiter',  {})
" call s:h('rubyInstanceVariable',        {})
" call s:h('rubyGlobalVariable',          {})
" call s:h('rubyClassVariable',           {})
" call s:h('rubyPseudoVariable',          {})
hi! link rubyFunction                 SublimeGreen
hi! link rubyStringDelimiter          SublimeYellow
hi! link rubyRegexp                   SublimeYellow
hi! link rubyRegexpDelimiter          SublimeYellow
hi! link rubySymbol                   SublimePurple
hi! link rubyEscape                   SublimePurple
hi! link rubyInclude                  SublimePink
hi! link rubyOperator                 Operator
hi! link rubyControl                  SublimePink
hi! link rubyClass                    SublimePink
hi! link rubyDefine                   SublimePink
hi! link rubyException                SublimePink
hi! link rubyRailsARAssociationMethod SublimeOrange
hi! link rubyRailsARMethod            SublimeOrange
hi! link rubyRailsRenderMethod        SublimeOrange
hi! link rubyRailsMethod              SublimeOrange
hi! link rubyConstant                 SublimeAqua
hi! link rubyBlockArgument            SublimeOrange
hi! link rubyBlockParameter           SublimeOrange

" SASS

hi! link sassAmpersand    Operator
hi! link sassClass        Tag
hi! link sassCssAttribute SublimeAqua
hi! link sassInclude      Keyword
" FIXME: No distinction between mixin definition and call
hi! link sassMixinName    SublimeAqua
hi! link sassMixing       Keyword
hi! link sassProperty     SublimeAqua
hi! link sassSelectorOp   Operator
hi! link sassVariable     Normal

" SQL
hi! link Quote        String
hi! link sqlFunction  SublimeFunctionCall
hi! link sqlKeyword   Keyword
hi! link sqlStatement Keyword

" Syntastic

hi! link SyntasticErrorSign Error
call s:h('SyntasticWarningSign',    { 'fg': s:lightblack, 'bg': s:orange })

" VimL

hi! link vimCommand       Keyword
" Variation: Interesting how this could vary...
hi! link vimCommentTitle  Comment
hi! link vimEnvvar        SublimeAqua
hi! link vimFBVar         SublimeWhite
hi! link vimFuncName      SublimeAqua
hi! link vimFuncNameTag   SublimeAqua
hi! link vimFunction      SublimeGreen
hi! link vimFuncVar       SublimeContextParam
hi! link vimHiGroup       Normal
hi! link vimIsCommand     SublimeAqua
hi! link vimMapModKey     SublimeAqua
hi! link vimMapRhs        SublimeYellow
hi! link vimNotation      SublimeAqua
hi! link vimOption        SublimeAqua
hi! link vimParenSep      SublimeWhite
hi! link vimScriptFuncTag SublimePink
hi! link vimSet           Keyword
hi! link vimSetEqual      Operator
hi! link vimUserFunc      SublimeAqua
hi! link vimVar           SublimeWhite

" XML

hi! link xmlArg             Tag
hi! link xmlAttrib          Tag
" XXX: This highlight the brackets and end slash too...which we don't want.
hi! link xmlEndTag          Keyword
" Variation: I actually liked it when this was faded
hi! link xmlProcessingDelim Normal
hi! link xmlTagName         Keyword
