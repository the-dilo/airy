""" Motions

"" STD plugin for matching pairs/triples of block expr {{{1
call dein#add('vim-scripts/matchit.zip', {
  \ 'on_map': [['nvo', '%', 'g%', '[%', ']%'], ['v', 'a%']],
  \ 'hook_post_source': 'sil! exe "doautocmd Filetype" &filetype'})



"" Readline style motions in insert and cmdline {{{1
" SEE: http://www.vim.org/scripts/script.php?script_id=4359
" DEV:TODO: replace by own -- to confront with ZSH, <C-f>, etc
" NOTE: Direct key mappings have no sense of being lazy
call dein#add('tpope/vim-rsi')



"" Motions in _camel_case_ or CamelCase for all modes {{{1
" ALT:CHECK: - (compare code) https://github.com/machakann/vim-textobj-delimited
" ALT: https://github.com/Julian/vim-textobj-variable-segment
" NOT:(needless loading): camelcasemotion#CreateMotionMappings('<leader>')
" DEPRECATED:
"   - (inferior) lucapette/vim-textobj-underscore
call dein#add('bkad/CamelCaseMotion', {
  \ 'on_map': [['nxo', '<Plug>CamelCaseMotion_']],
  \ 'hook_add': "
\\n   for c in split('w b e ge')
\\n     call Map_nxo('<Leader>'.c, '<Plug>CamelCaseMotion_'.c)
\\n     call Map_nxo('i<Leader>'.c, '<Plug>CamelCaseMotion_i'.c, 'ox')
\\n   endfor
\"})



"" Two-letters find on whole screen scope {{{1
" ALT: saihoooooooo/glowshi-ft.vim
" FIND: load plugin also on 'i_CTRL-o'
" DEPRECATED:
"   - (bloated) Lokaltog/vim-easymotion
"   - (altered) https://github.com/rhysd/clever-f.vim
call dein#add('justinmk/vim-sneak', {
  \ 'on_map': [['nxo', '<Plug>Sneak']],
  \ 'depends': 'vim-repeat',
  \ 'hook_source': _hcat('vim-sneak.src'),
  \ 'hook_add': _hcat('vim-sneak.add')})



"" Jump to line with -/=/+ indent
call dein#add('jeetsukumaran/vim-indentwise', {
  \ 'on_map': [['nxo', '<Plug>(IndentWise']],
  \ 'hook_add': "
\\n   map <silent><unique>  [,  <Plug>(IndentWisePreviousLesserIndent)
\\n   map <silent><unique>  [/  <Plug>(IndentWisePreviousEqualIndent)
\\n   map <silent><unique>  [.  <Plug>(IndentWisePreviousGreaterIndent)
\\n   map <silent><unique>  ],  <Plug>(IndentWiseNextLesserIndent)
\\n   map <silent><unique>  ]/  <Plug>(IndentWiseNextEqualIndent)
\\n   map <silent><unique>  ].  <Plug>(IndentWiseNextGreaterIndent)
\\n   map <silent><unique>  [_  <Plug>(IndentWisePreviousAbsoluteIndent)
\\n   map <silent><unique>  ]_  <Plug>(IndentWiseNextAbsoluteIndent)
\\n   map <silent><unique>  [<Space> <Plug>(IndentWiseBlockScopeBoundaryBegin)
\\n   map <silent><unique>  ]<Space> <Plug>(IndentWiseBlockScopeBoundaryEnd)
\"})
