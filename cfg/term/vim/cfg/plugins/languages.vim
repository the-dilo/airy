"{{{1 Python ============================
" WARNING: can't do them Lazy, as them will load on every
"         new *.py fileopen (,f) and reset my autocmd for jedi autocomplete
NeoBundle 'davidhalter/jedi-vim'
    " \, { 'autoload' : { 'filetypes' : [ 'python' ] }}

NeoBundle 'klen/python-mode'
    " \, { 'autoload' : { 'filetypes' : [ 'python' ] }}
" autocmd FileType python NeoBundleSource 'python-mode', 'jedi-vim',
" USAGE: ..[ai][fc]  {[]}p[fc] -- next/prev func/class
" https://github.com/bps/vim-textobj-python



"{{{1 Mark-up ============================
" ALT: http://tiddlywiki.com  -- one-page wiki
NeoBundleLazy 'vimoutliner/vimoutliner', {
    \ 'autoload' : { 'filetypes' : [ 'votl', 'txt' ], }}

NeoBundleLazy 'tpope/vim-markdown', {
    \ 'autoload' : { 'filetypes' : [ 'markdown' ] }}

NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', { 'autoload' : {
    \   'filetypes' : ['tex', 'bib', 'latex'] },
    \ 'external_commands': [ 'latexmk' ] }
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


"{{{1 Syntax ============================
NeoBundle 'octol/vim-cpp-enhanced-highlight'
" Syntax highlight
" https://github.com/Shirk/vim-gas
" https://github.com/beyondmarc/opengl.vim
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'Matt-Deacalion/vim-systemd-syntax'
NeoBundleLazy 'zaiste/tmux.vim', { 'autoload': {
      \ 'filename_patterns': [ 'tmux.*conf' ] }}
