"{{{1 Path ============================
if neobundle#tap('vim-rooter') "{{{
  let g:rooter_manual_only = 1
  let g:rooter_disable_map = 1
  " let g:rooter_use_lcd = 1
  " let g:rooter_patterns = g:rooter_patterns + [ 'setup' ]
  " Change working directory to that of the current file
  nnoremap <silent><unique> [Frame]cd :Rooter<CR>
  call neobundle#untap()
endif
" STD:ALWAYS:
  nnoremap <silent><unique> [Frame]cw :lcd %:p:h \| pwd<CR>
  nnoremap <silent><unique> [Frame]cc :lcd ..    \| pwd<CR>
"}}}


if neobundle#tap('vim-altr') "{{{
  nmap <unique> ]f  <Plug>(altr-forward)
  nmap <unique> [f  <Plug>(altr-back)
  command! -bar -nargs=0  A  call altr#forward()
  fun! neobundle#hooks.on_source(bundle)
    " Additional rules
    call altr#define('%/src/%.c', '%/inc/%.h')
  endf
  call neobundle#untap()
else  " OR:STD:
  " Cycle through *.h/*.cpp
  nnoremap <unique> [f :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
endif "}}}


"{{{1 State ============================
if neobundle#tap('vim-stay') "{{{
  " set viewoptions=cursor,folds,slash,unix   " Recommended
  call neobundle#untap()
else  " OR:STD:
  " Open at last position
  au MyAutoCmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \|    exe "normal! g'\"" | endif
endif "}}}
