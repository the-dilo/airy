"{{{1 Common/Define =====================
fun! SMdef(nm, lhs, rhs, ...)
  call submode#enter_with(a:nm, get(a:, 1, 'n'), get(a:, 2, ''), a:lhs, a:rhs)
endf
fun! SMall(nm, ...)
  for c in a:000 | call submode#enter_with(a:nm, 'n', '', c, c) | endfor
endf
fun! SMmap(nm, lhs, rhs, ...)
  call submode#map(a:nm, get(a:, 1, 'n'), get(a:, 2, ''), a:lhs, a:rhs)
endf
fun! SMpar(nm, ...)
  for i in range(0, (a:0<2 ? 0 : a:0-1), 2)
    call submode#map(a:nm, 'n', '', a:000[i], a:000[i+1])
  endfor
endf

command! -nargs=+ SMDEF call SMdef(<f-args>)
command! -nargs=+ SMALL call SMall(<f-args>)
command! -nargs=+ SMmap call SMmap(<f-args>)
command! -nargs=+ SMpar call SMpar(<f-args>)


"{{{1 User-Submodes =====================
" «Smart» x with group undo (REF: http://haya14busa.com/improve-x-with-vim-submode/)
SMDEF fluent/x  x "_x
SMmap fluent/x  x <Plug>(fluent-x) n r
nnoremap <silent> <Plug>(fluent-x) :undojoin \| norm! "_x<CR>


" Undo (chronological) navigation by [g---...]/[g+++...]
SMALL undo/redo g- g+
SMmap undo/redo   -  g-
SMmap undo/redo   +  g+


" Switch gt / gT of tab pages by [gttt...]
SMALL jump/tab  gt gT
SMmap jump/tab  t  gt
SMmap jump/tab  T  gT


" Window resizing
SMALL winsize <C-w>> <C-w>< <C-w>- <C-w>+
SMmap winsize   >  <C-w>>
SMmap winsize   <  <C-w><
SMmap winsize   +  <C-w>-
SMmap winsize   -  <C-w>+


" Page navigation
SMALL bufscroll <C-f> <C-b> <C-u> <C-d>
SMpar bufscroll  f <C-f>  b <C-b>  u <C-u>  d <C-d>  e <C-e>  y <C-y>

" SMmap bufscroll   b  <C-b>
" SMmap bufscroll   u  <C-u>
" SMmap bufscroll   d  <C-d>
" SMmap bufscroll   e  <C-e>
" SMmap bufscroll   y  <C-y>



" " File cycling
" SMDEF nextfile r  <Leader>j <Plug>(nextfile-next)
" SMDEF nextfile r  <Leader>k <Plug>(nextfile-previous)
" SMmap nextfile r  j <Plug>(nextfile-next)
" SMmap nextfile r  k <Plug>(nextfile-previous)


" DEV: Jumping in last changes
SMALL jump/chg <C-o>
SMmap jump/chg   o  <C-o>
SMmap jump/chg   i  <C-i>
SMmap jump/chg   j  g;
SMmap jump/chg   k  g,


" Move a tab page in the <Space> gttt...
function! s:SIDP()
  return '<SNR>' . matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SIDP$') . '_'
endfunction
function! s:movetab(nr)
  execute 'tabmove' g:V.modulo(tabpagenr() + a:nr - 1, tabpagenr('$'))
endfunction
let s:movetab = ':<C-u>call ' . s:SIDP() . 'movetab(%d)<CR>'
call submode#enter_with('movetab', 'n', '', '<Space>gt', printf(s:movetab, 1))
call submode#enter_with('movetab', 'n', '', '<Space>gT', printf(s:movetab, -1))
call submode#map('movetab', 'n', '', 't', printf(s:movetab, 1))
call submode#map('movetab', 'n', '', 'T', printf(s:movetab, -1))
unlet s:movetab