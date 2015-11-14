set confirm       " ask user before aborting an action

set novisualbell  " don't flash the screen
set ruler
set showcmd "shows the last command entered in the very bottom right (not in powerline)
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildmenu        " visual tab-completion variants menu in command mode
set wildmode=list:longest,full          "instead of first-choosing

" Make tab char visible ">\\
exec "set listchars=tab:\\\\_,extends:>,precedes:<,trail:\uB7,nbsp:~"
set list            " display otherwise invisible characters
" tab:\uBB\uBB,nbsp:%,eol:¬

" Never use select(replace) mode by mouse/keyboard. Always use visual.
set selectmode=
set keymodel=


set shortmess=aIT   " No intro msg, etc
" set cmdheight=2   " No hit <CR> twice after :make (but lose one view line)
" If you accidentally hit or and you want to see the displayed text then use
" |g<|. This only works when 'more' is set.
"   To reduce the number of hit-enter prompts:
"       Set 'cmdheight' to 2 or higher.
"       Add flags to 'shortmess'.
"       Reset 'showcmd' and/or 'ruler'.
" If set nomore -> the prompts will be no more

" To be able safely save sessions and change settings between them
set sessionoptions-=options


set noshowmode
set lazyredraw        " don't redraw screen while macros are executing
set colorcolumn=+1    " show textwidth limit

set guicursor+=a:blinkwait0 " disable cursor blink in gvim

if has("gui_running")
  if has("gui_gtk2")
    set guifont=PragmataPro\ 12,DejaVu\ Sans\ Mono\ for\ Powerline\ 11,DejaVu\ Sans\ Mono\ 11
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  elseif has("win32") || has("win64")
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11,Courier_New:h12
  else
    set guifont=Courier_New:h10:cDEFAULT
    "set guifont=-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-1
  endif
endif

"set guiheadroom=0
" Custom command line when no airline or for it's bckgr splits
set statusline=%f\ %m\ %r\ line:%l/%L(%p%%)\ col:%c\ buf:%n\ (%b)(0x%B)
set laststatus=2    " always show status line
" set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Auto-show on launch
" autocmd vimenter * TagbarToggle
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif

" vim:ts=2:sw=2:sts=2