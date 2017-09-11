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

" Write temp and backup files to /tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <silent> <C-N> :nohlsearch<CR>

" Shortcuts
let mapleader=","       " leader is comma

" save session (open again with vim -S)
nnoremap <leader>s :mksession<CR>

" open ag.vim
set runtimepath^=~/.vim/bundle/ag
nnoremap <leader>a :Ag 

" CtrlP
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0
endif

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
let g:airline_theme = 'tomorrow'
let g:airline_powerline_fonts = 1
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Buffergator
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
"let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>
