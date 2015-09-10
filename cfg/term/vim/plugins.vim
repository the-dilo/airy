" vim:fdm=marker:fdl=1

"==========================================
" Use ',.' as preferable localleader
"==========================================
let maplocalleader=",."
noremap <unique> <LocalLeader> <Nop>

"==========================================
" Use '\' as leader for all plugins below
"==========================================
let mapleader="\\"
noremap <unique> <Leader> <Nop>


" Switch [c,cpp,cxx,cc] <-> [h,hpp]
NeoBundle 'kana/vim-altr'
" , { 'autoload': {
"     \ 'commands' : 'A', 'mappings': '<Plug>(altr-' }}

NeoBundle 'Valloric/ListToggle'

"OFF: " Ascii graph drawing in vim
" NeoBundleLazy 'vim-scripts/DrawIt' , { 'autoload' : {
"     \ 'commands' : 'DrawIt', 'mappings' : '<Plug>DrawItStart' }}

"==========================================
" Use ',' as leader for all plugins below
"==========================================
let mapleader=","
noremap <unique> <Leader> <Nop>


" Asynchronous execution plugin for Vim
NeoBundle 'Shougo/vimproc.vim', {
    \ 'external_commands' : 'make',
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \ }}

" Powerful shell implemented by Vim script
NeoBundleLazy 'Shougo/vimshell.vim', {
    \ 'depends' : 'Shougo/vimproc.vim',
    \ 'external_commands' : 'make',
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'VimShell',
    \                   'complete' : 'customlist,vimshell#complete'},
    \                 'VimShellExecute', 'VimShellInteractive',
    \                 'VimShellTerminal', 'VimShellPop',
    \              ],
    \   'mappings' : ['<Plug>(vimshell_'],
    \ }}

" Ultimate hex-editing system
" depends on hexript for some optional scripts
"   (now that repo 'rbtnn/hexript.vim' don't exists)
NeoBundle 'Shougo/vinarise.vim', { 'autoload': {
    \ 'commands' : ['Vinarise', 'VinariseDump'],
    \ 'explorer' : 1 }}


" Super-mega-replace for bunch of plugins
" See: http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
NeoBundle 'Shougo/unite.vim', { 'depends' : 'Shougo/vimproc.vim' }
NeoBundleLazy 'Shougo/unite-outline', { 'depends' : 'Shougo/unite.vim'
    \ , 'autoload' : { 'unite_sources' : 'outline' }}
NeoBundle 'Shougo/neomru.vim', { 'depends' : 'Shougo/unite.vim' }
" NeoBundleLazy 'thinca/vim-unite-history', { 'depends' : 'unite.vim'
"    \ , 'autoload' : { 'unite_sources' : 'history/command' 4}}


" ======================================
" Integration with neocomplete: for stdlib++, boost, etc (works on Windows)
" http://www.reddit.com/r/vim/comments/1x4mvg/vimmarching_with_neocomplete_doesnt_complete_c/
NeoBundle 'osyo-manga/vim-marching', { 'depends' : 'Shougo/vimproc.vim' }

" echo neobundle#tap('YouCompleteMe')

NeoBundle 'Shougo/neocomplete.vim', {
    \ 'depends' : [
    \   'Shougo/context_filetype.vim',
    \   'Shougo/vimproc.vim' ],
    \ 'disabled' : !has('lua'),
    \ 'vim_version' : '7.3.885'}

" SirVer/ultisnips
NeoBundle 'Shougo/neosnippet.vim', {
    \ 'depends' : [
    \   'Shougo/neocomplete.vim',
    \   'Shougo/neosnippet-snippets',
    \   'honza/vim-snippets' ],
    \ 'disabled' : !has('lua'),
    \ 'vim_version': '7.3.885'}


" ======================================

if has('unix')
    " W3m from vim
    "NeoBundle 'yuratomo/w3m.vim'

    "Lazy loading like this
    "NeoBundleLazy 'Rip-Rip/clang_complete'
    "autocmd FileType c,cpp NeoBundleSource clang_complete

    " "" Autocompletion for Python and C-like languages. Need Python2 exclusively
    " NeoBundleLazy 'Valloric/YouCompleteMe', {
    "     \ 'augroup': 'youcompletemeStart',
    "     \ 'autoload': {
    "     \   'commands' : ['YcmDebugInfo'],
    "     \   'filetypes' : [ 'c', 'cpp' ],
    "     \ },
    "     \ 'build': {
    "     \   'linux': './install.sh --clang-completer',
    "     \ },
    "     \ 'disabled': !has('python'),
    "     \ 'vim_version': '7.3.584',
    "     \ }
    "     " \   'unix': './install.sh --clang-completer --system-libclang'

    " TODO FIX: resolve completion conflicts -- seems like isn't disabled?
    " autocmd FileType c,cpp if exists(':YcmCompleter') | NeoCompleteDisable | endif
    " neocomplete: 'autoload': { 'filetypes' : [ 'vim', 'sh', 'shell', 'votl' ], },

" {{{Build instruction for YCM : if [ ! -e './third_party/ycmd/ycm_core.so' ]
"   1. git submodule update --init --recursive
"   2. cd third_party/ycmd && mkdir -p build && cd build && cmake .. ../cpp
"   5a. (optional) ccmake . # configure
"   6. make
" For win: https://github.com/Valloric/YouCompleteMe/wiki/Windows-Installation-Guide
" }}}

else

" In unix terminal use snip-ranger-filechooser.vim
NeoBundleLazy 'Shougo/vimfiler.vim', {
    \ 'depends' : 'Shougo/unite.vim',
    \ 'disabled' : has('unix') && !has('gui_running'),
    \ 'autoload' : {
    \    'commands' : [{ 'name' : 'VimFiler',
    \                    'complete' : 'customlist,vimfiler#complete' },
    \                  'VimFilerExplorer',
    \                  'Edit', 'Read', 'Source', 'Write'],
    \    'mappings' : ['<Plug>(vimfiler_'],
    \    'explorer' : 1,
    \ }}

endif



"" Python =======================
" WARNING: can't do them Lazy, as them will load on every
"         new *.py fileopen (,f) and reset my autocmd for jedi autocomplete
NeoBundle 'davidhalter/jedi-vim'
    " \, { 'autoload' : { 'filetypes' : [ 'python' ] }}
NeoBundle 'klen/python-mode'
    " \, { 'autoload' : { 'filetypes' : [ 'python' ] }}
" autocmd FileType python NeoBundleSource 'python-mode', 'jedi-vim',
" USAGE: ..[ai][fc]  {[]}p[fc] -- next/prev func/class
" https://github.com/bps/vim-textobj-python


"{{{1 Motions ============================
" Two-letters find on whole screen scope
NeoBundle 'justinmk/vim-sneak'
" New motions [count]{ ,w ,b ,e } for n/o/v modes in camel_case
NeoBundle 'bkad/CamelCaseMotion'
" Readline style insertion
" http://www.vim.org/scripts/script.php?script_id=4359
NeoBundle 'tpope/vim-rsi'

"{{{1 Actions ============================
" Automatic not-persistent closing statements
NeoBundle 'tpope/vim-endwise'
" Extend support for '.' command
NeoBundle 'tpope/vim-repeat'
" Use CTRL-A/X to increment dates, times, and more
NeoBundle 'tpope/vim-speeddating'
" Exchange text: cx{motion} on first, then cx{motion} on other.
"   cxx -- current line, X -- in Visual mode,  cxc -- clear pending exchange.
NeoBundle 'tommcdo/vim-exchange'

"{{{1 Textobj ============================
NeoBundle 'kana/vim-operator-user'              " = Dependency: vim-clang-format
NeoBundle 'kana/vim-textobj-user'               " = Dependency: vim-textobj-*
NeoBundle 'kana/vim-textobj-entire'             " ..[ai]e -- instead ggVG
NeoBundle 'kana/vim-textobj-fold'               " ..[ai]z
NeoBundle 'kana/vim-textobj-function'           " ..[ai][fF] (C/Java/Vimscript)
NeoBundle 'kana/vim-textobj-indent'             " ..[ai][iI]
NeoBundle 'kana/vim-textobj-line'               " ..[ai]l
NeoBundle 'kana/vim-textobj-syntax'             " ..[ai]y
NeoBundle 'coderifous/textobj-word-column.vim'  " ..[ai][cC]<[IA]>
NeoBundle 'rhysd/vim-operator-surround'         "q..[ai]..
NeoBundle 'beloglazov/vim-textobj-quotes'       " ..[ai]q -- any nearest quotes (OR: ..q)
NeoBundle 'saihoooooooo/vim-textobj-space'      " ..[ai]Q -- space between words, etc
NeoBundle 'vimtaku/vim-textobj-sigil'           " ..[ai]G
" ALT: 'sgur/vim-textobj-parameter', 'PeterRincker/vim-argumentative'
NeoBundle 'AndrewRadev/sideways.vim'            " ..[ai], and [<>], -- shift

" ======================================
":Make cover for long-running tasks asynchronous (as like by ssh)
NeoBundle 'tpope/vim-dispatch'
NeoBundleLazy 'tpope/vim-markdown', {
    \ 'autoload' : { 'filetypes' : [ 'markdown' ] }}

" VCS Integration
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-fugitive', {'autoload': {
    \ 'augroup' : 'fugitive',
    \ 'commands' : [ 'Git', 'Gstatus', 'Gdiff', 'Glog', 'Gbrowse' ] }}
NeoBundleLazy 'gregsexton/gitv', { 'depends' : 'tpope/vim-fugitive',
    \ 'autoload' : { 'commands' : 'Gitv' }}
" {{{ GitV hotkeys
" \gv -> full repo view, \gV -> file view
" <cr> -> view commit, <C-n>/<C-p> jump to next/previous commit and <cr>.
" o -> <cr> with split, O -> tab, s -> vsplit
" co -> checkout
" S -> diffstat
" yc -> copy SHA
" x/X -> next/previous branching point
" Folds are enabled
" }}}

" ======================================

" View highlight groups under cursor
"NeoBundle 'gerw/vim-HiLinkTrace'    ", { \ 'lazy': 1, \}

" View relative line-numbers in operator-pending mode
"NeoBundle 'vim-scripts/RelOps'

" Change your root working dir to nearest .git on file_open or <Leader>cd
NeoBundleLazy 'airblade/vim-rooter', {'autoload': {'commands': 'Rooter'}}
" ======================================

" Undo tree
NeoBundleLazy 'mbbill/undotree', {
    \ 'autoload' : { 'commands' : 'UndotreeToggle' } }
NeoBundleLazy 'godlygeek/tabular', {
    \ 'autoload' : { 'commands' : [ 'Tab', 'Tabularize' ] } }
NeoBundleLazy 'majutsushi/tagbar', {
    \ 'autoload' : { 'commands' : 'TagbarToggle' } }

" NeoBundle 'tomtom/tcomment_vim'
" ALT:
NeoBundle 'tpope/vim-commentary'


"{{{1 Std vim/macros/ =====================
" Bring back opened window instead of dull msg about swapfile
"NeoBundle 'svintus/vim-editexisting'
"ERROR: conflicting
NeoBundle 'matchit.zip'

" Alt: 'bb:abudden/taghighlight' "(small and fast) from bitbucket
" NOTE: easytags can make CursorMove very slow
"   https://github.com/xolox/vim-easytags/issues/68#issuecomment-28480981
"NeoBundle 'xolox/vim-easytags', { 'depends' : [ 'xolox/vim-misc' ] }
"NeoBundle 'xolox/vim-misc'

" Focus on line/selection/window in new buffer. ALT to LineDiff?
NeoBundleLazy 'chrisbra/NrrwRgn' , { 'autoload' : {
    \ 'commands' : ['NR', 'NW', 'NRV', 'NUD', 'NRP', 'NRM', 'NRL'],
    \ 'mappings' : ['<Plug>NrrwrgnDo', '<Plug>NrrwrgnBangDo'],
    \ }}

NeoBundle 'AndrewRadev/linediff.vim'

" No Lazy -- vim will pause 'ENTER' on file open
NeoBundle 'lyokha/vim-xkbswitch', { 'autoload' : {
    \ 'filetypes' : [ 'tex', 'latex', 'bib', 'markdown', 'votl', 'txt' ],
    \ 'commands' : 'EnableXkbSwitch'
    \ }, 'name' : 'vim-xkbswitch' }


" ======================================
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', { 'autoload' : {
    \ 'filetypes' : [ 'tex', 'bib', 'latex' ]
    \ }, 'external_commands': [ 'latexmk' ] }
" {{{ LaTeX-Box
" C-xC-o completion
" [[ -> \begin
" ]] -> \end / \right / whatever
" n-f5 -- */ no-*
" v-f7 -- wrap into command
" ([ -- eqref
" (( -- \left(
" )) -- \item
" }}} LaTeX-Box

" ======================================

"NeoBundleLazy 'docunext/closetag.vim', {
"   \ 'autoload' : { 'filetypes' : ['html', 'xml'] } }
" NeoBundle 'vim-scripts/DoxygenToolkit.vim'
" NeoBundle 'hsanson/vim-android'
" Web
" NeoBundle 'mattn/emmet-vim'
" NeoBundle 'cakebaker/scss-syntax.vim'
" NeoBundle 'gorodinskiy/vim-coloresque'

NeoBundle 'vim-perl/vim-perl'
NeoBundle 'scrooloose/syntastic'

" Autoformatting with one button, can use custom (like clang-styler)
NeoBundle 'Chiel92/vim-autoformat'
" Auto-formatter for c/cpp/obj-c
NeoBundle 'rhysd/vim-clang-format'

" Documentation online finder in one button for word under cursor
" Keithbsmiley/investigate.vim
" powerman/vim-plugin-viewdoc

NeoBundle 'octol/vim-cpp-enhanced-highlight'
" Syntax highlight
" https://github.com/Shirk/vim-gas
" https://github.com/beyondmarc/opengl.vim

" DESIDE: Highlight choosen
NeoBundle 't9md/vim-quickhl'

" JSON Highlight and indent plugin
NeoBundleLazy 'elzr/vim-json', {
    \ 'autoload': { 'filetypes': [ 'json' ] },
    \}

NeoBundleLazy 'zaiste/tmux.vim', {
    \ 'autoload': { 'filename_patterns': [ 'tmux.*conf' ] },
    \}

" ======================================
NeoBundle 'bling/vim-airline'
" Alt: 'airblade/vim-gitgutter' "Only for git, but much faster file save
NeoBundle 'mhinz/vim-signify'
" TEST: Plugin to toggle, display and navigate marks
NeoBundle 'kshenoy/vim-signature'

" When swap exists, it show process id, or you can diff swp with file on disk
NeoBundle 'chrisbra/Recover.vim'

" Highlight first space of tab columns
NeoBundle 'nathanaelkane/vim-indent-guides'

" Substitution: {{{
" The Silver searcher
NeoBundle 'rking/ag.vim', {
    \ 'external_commands' : 'ag',
    \ 'autoload': { 'commands' : [
    \   'Ag', 'AgAdd', 'AgBuffer', 'AgFile', 'AgFromSearch',
    \   'AgHelp', 'LAg', 'LAgAdd', 'LAgBuffer', 'LAgHelp'
    \ ], }, }
" Multiple hl for searching by / ? or g/
NeoBundle 'haya14busa/incsearch.vim'  ", 'incsearch-preload'

" Smart highlight (don't do lazy -- I use it almost always)
NeoBundle 'haya14busa/vim-asterisk'
" Index for search results
NeoBundle 'osyo-manga/vim-anzu'
" Preview :substitute patterns
NeoBundle 'osyo-manga/vim-over', {
    \ 'autoload': { 'commands' : ['OverCommandLine'], }}

" Delete entries from qf/loc wdws (or edit them as text) and save to apply
" Useful for interactive replacing in many files found by :Ag, skiping needless.
NeoBundle 'stefandtw/quickfix-reflector.vim'

" }}} ======================================

NeoBundle 'amerlyq/vim-focus-autocmd', {
    \ 'disabled' : !has('unix'),
    \ 'build': { 'linux': 'bash ./res/setup' }
    \ }

" Viewing man in vim: good, but no colors in git lg1, need to investigate
" NeoBundleLazy 'rkitover/vimpager'

NeoBundle 'szw/vim-dict'

" ALT: http://tiddlywiki.com  -- one-page wiki
NeoBundleLazy 'vimoutliner/vimoutliner', {
    \ 'autoload' : { 'filetypes' : [ 'votl', 'txt' ], }}

" ======================================
" Colorschemes
" NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
