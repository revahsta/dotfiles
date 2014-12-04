" Enable filetype detection
filetype plugin indent on

" Show line numbers
set number

" Not sure what this does
set formatoptions+=r

" Tabbing
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" When editing a file, always jump to the last cursor position
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" Except, don't remember the cursor position in git commits
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Treat arduino source files a C source files
au BufNewFile,BufRead *.ino set filetype=c
