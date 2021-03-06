let g:pathogen_disabled = ['supertab','makegreen']

call pathogen#infect()

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=300		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  filetype plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" Turn on line numbers:
set number
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

"Настройки табов для Python, согласно рекоммендациям
set expandtab       "ставим табы пробелами
set tabstop=4       "ширина таба (в пробелах)
set shiftwidth=4    "ширина отступов и сдвигов
set softtabstop=4   "4 пробела в табе
set smarttab
""Автоотступ
set autoindent
"Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
""Включаем 256 цветов в терминале, мы ведь работаем из иксов?
"Нужно во многих терминалах, например в gnome-terminal
set t_Co=256


"Всякие приятные мелочи
set synmaxcol=0 "Maximum column in which to search for syntax items.
set cursorline
set cursorcolumn
set scrolloff=3
set showcmd
set ttyfast
set undofile
set gdefault
set hidden "возможность переключать буфер в фон

set textwidth=79
set colorcolumn=+1,+40
hi ColorColumn ctermbg=lightred guibg=lightred
set formatoptions=rl

set foldmethod=indent
set foldlevel=99

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <leader>l <Plug>TaskList

map <leader>g :GundoToggle<CR>
let g:gundo_preview_bottom = 1

nnoremap <silent> <Leader>f :CommandT<CR>

map <leader>t :TagbarToggle<CR>

let g:jedi#goto_command = "<leader>j"


"let g:pyflakes_use_quickfix = 1

"let g:pep8_map='<leader>8'

"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview

map <leader>m :NERDTreeToggle<CR>

"map <leader>j :RopeGotoDefinition<CR>

vnoremap < <gv
vnoremap > >gv

"нормальный переход к нижней строке
"если строка слишком длинная
nmap j gj
nmap k gk

"поиск, отключение подстветки
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap <leader><space> :nohlsearch<CR>

"открыть предыдущий просмотреный буфер
nmap <C-e> :e#<CR>

"предыдцщий, следующий буфер
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

"настройки для syntactic
let g:syntastic_check_on_open=1
let g:syntastic_python_checker="flake8"
let g:syntastic_always_populate_loc_list=1

colorscheme wombat256

nmap <leader>a <Esc>:Ack!

"let DJANGO_SETTINGS_MODULE='./settings'

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, './bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

