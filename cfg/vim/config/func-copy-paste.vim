" normal p is ':pu'

" show the command history (q:)
" Remap line-up and move-up
" on visual area it must copy instantly! and only in @+
function! CountCopyLines(msg)
    let l = split(@+, '^.\{-}\zs\n')  " -- w/o,  '\n\zs' -- with
    let h = a:msg . len(l) . 'L> '
    let maxlen = min([ len(l[0]), &columns - len(h) - 2 ])
    echo h . substitute(l[0][0:maxlen], "\t", " ", 'g')
endfunction

nnoremap <C-y> :let @+=@" \| :call CountCopyLines('Push:')<CR>
cnoremap <C-y> :<C-U>call setreg(''+'', getreg('':'')) \| call CountCopyLines(''Push:'')<CR><CR>
vnoremap <C-y> "+y \| :call CountCopyLines('Push:')<CR>
nnoremap <C-p> :let @"=@+ \| :call CountCopyLines('Pull:') <CR>
"" Don't use as I use C-n C-p for navigation in command line
" cnoremap <C-p> <C-U>exec 'call setreg('':'', getreg('':'') . getreg(''+'')) \| call CountCopyLines(''Pull:'')<CR>'<CR>
vnoremap <C-p> :call CountCopyLines('Pull:') \| normal "_d"+P <CR>
" Swap registry
noremap  <M-c> :let @a=@" \| let @"=@+ \| let @+=@a \| reg "+<CR><CR>

" Try it {{{
" nnoremap p "+p
" map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
" Prevent Paste loosing the register source:
" http://stackoverflow.com/a/7797434/1147859
xnoremap p pgvy
" Send shizzle to the black hole
vnoremap <Leader>x "_d
" }}}

noremap  zp "0p
noremap  zP "0P
vnoremap P  "_dP
vnoremap p  "_dP

" See: http://vim.wikia.com/wiki/Copy_search_matches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
" Usage:
" :let @a = ''
" :bufdo CopyMatches A
