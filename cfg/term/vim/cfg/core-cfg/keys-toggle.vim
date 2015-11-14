" vim:ts=2:sw=2:sts=2:fdm=marker:fdl=1


" Local buffer
nnoremap <unique> <Leader>th :setl hlsearch! hls?<CR>
nnoremap <unique> <Leader>ts :setl spell! spelllang=en_us,ru_yo,uk spell?<CR>

" UI
nnoremap <unique> <Leader>tc :set cursorcolumn! cuc?<CR>
nnoremap <unique> <Leader>tC :set cursorline! cul?<CR>
" Toggle status line only
nnoremap <unique> <Leader>tA :let &laststatus=(&ls?0:2) \| :AirlineToggle<CR>
" Toggle all UI elements NEED DEV save/restore current state instead hardcode!
""showcmd! ruler!
nnoremap <unique> <Leader>tf :set number! showmode!
      \\| let &foldcolumn=(&fdc?0:2) \| let &laststatus=(&ls?0:2)
      \\| SignifyToggle \| AirlineToggle \| SignatureToggleSigns<CR><CR>

" Toggle between number and relativenumber
set number
nnoremap <unique> <Leader>tn :set relativenumber! \| set rnu?<CR>


noremap <unique> <Leader>tN :<C-u>NeoCompleteToggle<CR>
noremap <unique> <Leader>tx :<C-u>SyntasticToggleMode<CR>
"\| :SyntasticCheck<CR>

" Syntax highlighting
noremap <unique> <Leader>tS :<C-u>exe 'syn' exists("g:syntax_on")?'off':'enable'<CR>