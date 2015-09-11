" vim:ts=2:sw=2:sts=2:fdm=marker:fdl=1
" Name: Notches
" Fast highlighting: match Error /ENOMEM/
" CHECK: http://andrewradev.com/2011/08/06/making-vim-pretty-with-custom-colors/
" FIXME: background for labels don't match, when cursor is on same line

if !has("autocmd") || v:version <= 701 | finish | endif

" Black
" DarkBlue
" DarkGreen
" DarkCyan
" DarkRed
" DarkMagenta
" Brown, DarkYellow
" LightGray, LightGrey, Gray, Grey
" DarkGray, DarkGrey
" Blue, LightBlue
" Green, LightGreen
" Cyan, LightCyan
" Red, LightRed
" Magenta, LightMagenta
" Yellow, LightYellow
" White

let g:everywhere_activated = 1
" UNUSED: 6 - light blue, 7,15 - whites, 0,8 - blacks, 11,12,14 - grays
let s:colors = { 'Err': 1, 'Fix': 9, 'Add': 2, 'Did': 10,
      \ 'Dev': 4, 'Msg': 13, 'Tbd': 5, 'Alt': 3 }
let s:patterns = {
      \ 'Err': 'ERR%(OR)=|BUG',
      \ 'Fix': 'FIX%(ME)=|WARNING|ATTENTION|REMOVE',
      \ 'Add': 'ADD|SEE|NEED|FIND',
      \ 'Did': 'DONE|FIXED|EXPL',
      \ 'Dev': 'DEV|HACK',
      \ 'Msg': 'NOTE|OPT%(ION)=%(S)=',
      \ 'Tbd': 'TODO|CHECK|TRY',
      \ 'Alt': 'ALT|OR|THINK|CHG',
      \ }


function! s:everywhere_print(patts)
  for [k,v] in items(a:patts)
    echo k .': '. v
  endfor
endfunction


function! s:everywhere_define(cols)
  for [k,v] in items(a:cols)  "term=bold,underline guifg=#E01B1B
    exec 'hi! Note'. k .' term=bold cterm=bold ctermbg=None guibg=None ctermfg='. v
  endfor
endfunction


function! s:everywhere_matches(patts)
  for [k,v] in items(a:patts)
    call matchadd('Note'. k, '\v<('. v .')>:=', -1)
  endfor
endfunction


function! s:everywhere_enable(mode)
  let g:everywhere_activated = a:mode
  augroup everywhere_colors
    autocmd!
    if g:everywhere_activated
      au ColorScheme * call s:everywhere_define(s:colors)
    endif
  augroup END

  augroup everywhere_notes
    autocmd!
    if g:everywhere_activated
      au Syntax * call s:everywhere_matches(s:patterns)
    endif
  augroup END
endfunction


call s:everywhere_define(s:colors)
call s:everywhere_enable(1)
" autocmd WinEnter,VimEnter * call s:everywhere_enable(1)

command! -bar -bang -nargs=0 EverywhereNotchesToggle
      \ call s:everywhere_enable(!g:everywhere_activated)
      \ | syntax off | syntax on

command! -bar -bang -nargs=0 EverywhereNotchesList
      \ call s:everywhere_print(s:patterns)
      \ | syntax off | syntax on

nnoremap <unique> <Leader>tT :EverywhereNotchesToggle<CR>
