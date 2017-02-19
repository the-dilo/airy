if &cp||exists('g:loaded_trailing')|finish|else|let g:loaded_trailing=1|endif
" SEE Remove trailing spaces before saving text files
"   http://vim.wikia.com/wiki/Remove_trailing_spaces
" SEIZE
"   https://github.com/search?q=vim+strip
"   https://github.com/search?q=vim+trail

"{{{1 MAPS ====================
noremap <unique> [Toggle]l :<C-u>set list! list?<CR>
noremap <unique> [Toggle]L :<C-u>ToggleTrailingHighlight<CR>
noremap <unique> [Toggle]t :<C-u>ToggleEmptyLinesStripEnd<CR>

noremap <unique> [Replace]E :<C-u>EmptyLinesCompress<CR>

let s:sp = '[ \t\xa0\u3000]'

"{{{1 CMDS ====================
command! -bar -nargs=0 -range=% EmptyLinesCompress
    \ call UnobtrusiveSubF('%s,%s s/%s//', <line1>, <line2>,
    \   '\v'.'%(%^|\_^('.s:sp.')*\n\zs)%(\1*\n)+')
    \| EmptyLinesStripEnd

" USAGE:(after receiving mail): Unix-Win-Unix when excessive newlines doubled
command! -bar -nargs=0 -range=% EmptyLinesReduce
    \ call UnobtrusiveSubF('%s,%s s///', <line1>, <line2>,
    \   '\v'.'\S\n\zs\n')

command! -bar -nargs=0 -range=% EmptyLinesRemove
    \ call UnobtrusiveSubF('%s,%s g/%s/d_', <line1>, <line2>,
    \   '^'.s:sp.'*$')

command! -bar -nargs=0 -range=% EmptyLinesStripEnd
    \ call UnobtrusiveSubF('/%s/,%sd_', '\v^%(\_[\n'.s:sp[1:-2].']*\S)@!',
    \ <line2>)

command! -bar -nargs=0 -range ToggleEmptyLinesStripEnd
    \ call ToggleVariable('g:strip_empty_end_lines')

" DEV: if &ft==mail  =>  don't touch line '^--\s$'
command! -bar -nargs=0 -range=% StripTrailingSpace
    \ call UnobtrusiveSubF('%s,%s v/%s/s/%s//ge', <line1>, <line2>
    \, get(b:, 'strip_trailing_skip', g:strip_trailing_skip)
    \, '\v'.s:sp.'+$|[ \xa0\u3000]+\ze\t$')

command! -bar -nargs=0 -range ToggleStripTrailingSpace
    \ call ToggleVariable('g:strip_trailing_space')

" DEV THINK make independent from solarized high-contrast
command! -bar -nargs=0 -range ToggleTrailingHighlight
    \ let g:solarized_visibility=("low"==g:solarized_visibility?"high": "low")
    \| colorscheme solarized


"{{{1 IMPL ====================
fun! UnobtrusiveSubF(...)
  let l:pos = (exists('*getcurpos') ? getcurpos() : getpos('.'))
  silent! exe call(function("printf"), a:000)
  call histdel("search", -1)
  let @/ = histget("search", -1)
  call setpos('.', l:pos)
endf

fun! ToggleVariable(name)
  let {a:name} = !{a:name}
  echo '  '.a:name.' = '.({a:name} ? 'on' : 'off')
endf

" ALT: join('|', map('%('.v:val.')'))
let g:strip_trailing_skip = '\v%(\S$)'
let g:strip_empty_end_lines = 1
let g:strip_trailing_space  = 1
augroup TrailingStrip
  au!
  au BufWritePre *
      \ if g:strip_trailing_space |StripTrailingSpace|en
      \|if g:strip_empty_end_lines|EmptyLinesStripEnd|en
augroup END