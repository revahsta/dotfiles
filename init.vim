" Enable filetype detection
filetype plugin indent on

" Show line numbers
set number

" Tabbing and indentation
set autoindent
set expandtab
set formatoptions+=r
set shiftwidth=4
set smarttab
set tabstop=4

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

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/

" Plugin stuff
call plug#begin()

Plug 'ggandor/leap.nvim'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'

call plug#end()
" End plugin stuff

" Set up leap
lua require('leap').add_default_mappings()

" Configure Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

