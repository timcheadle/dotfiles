" Colors
"if $TERM =~ "xterm-256color"
"    set t_Co=256
"else
"    set t_Co=16
"endif
set background=dark
color Tomorrow-Night

" Syntax
syntax enable

" Encoding
set encoding=utf-8

" Spaces & Tabs
set tabstop=2       " number of visual spaces per TAB
set shiftwidth=2    " number of spaces in << shift
set expandtab       " tabs are spaces

" backspace through everything in insert mode
set backspace=indent,eol,start

" Invisble Characters
set list                 " Show invisible characters

" List chars
set listchars=""              " Reset the listchars
set listchars=tab:\ \         " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.        " show trailing spaces as dots
set listchars+=extends:>      " The character to show in the last column when wrap is
                              " off and the line continues beyond the right of the screen
set listchars+=precedes:<     " The character to show in the last column when wrap is
                              " off and the line continues beyond the left of the screen

" UI Config
set nowrap              " don't wrap lines
set number              " show line numbers
set showcmd             " show command in bottom bar
"set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <silent> <C-N> :nohlsearch<CR>

" Shortcuts
let mapleader=","       " leader is comma

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" save session (open again with vim -S)
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag 

" CtrlP
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Pathogen
call pathogen#infect()                      " use pathogen

" Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Autogroups
augroup configgroup
  autocmd FileType ruby autocmd BufWritePre <buffer> StripWhitespace
augroup END

" Custom functions

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
set laststatus=2
let g:airline_theme='tomorrow'
