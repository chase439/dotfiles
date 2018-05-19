" vim:set ts=2 sts=2 sw=2 expandtab:

" remove all existing autocmds
autocmd!

" pathogen plugin was installed to .vim/autoload
" load pathogen by sourcing it via runtime!
" if pathogen exists, then load other plugins in .vim/bundle
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable old vi compatibility, enable Vi Improved features
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=100  " keep 100 lines of command line history
set ruler        " show the cursor position at all time
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch  " show matching bracket
set incsearch  " do incremental searching
set hlsearch   " highlight search results
set wrapscan   " wrap around file when searching
set number     " show line numbers
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set cursorline " highlight current line
set cmdheight=1
set switchbuf=useopen
" Always show tab bar at the top
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
set backup  " keep a backup file
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp
if !isdirectory(&directory)
  call mkdir(&directory, "p")
endif

let sessiondir=$HOME."/vs"
if !isdirectory(sessiondir)
  call mkdir(sessiondir)
endif
" whenever you exit or quit vim, auto-create a session file
autocmd VimLeavePre * execute "mksession! ".sessiondir."/temp"

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set showcmd  " display incomplete commands
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber,rake set ai sw=2 sts=2 et
  autocmd FileType python set sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces
  autocmd! FileType slim set sw=2 sts=2 et

  " javascript
  autocmd! FileType javascript set sw=2 sts=2 expandtab autoindent smartindent nocindent

  " Expand tabs in Go
  autocmd! FileType go set sw=4 sts=4 expandtab | retab
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR/FONT/Window Sizes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
silent! colorscheme solarized " load colorscheme, silent if it's nonexistent
  
if has("gui_macvim")
  set guifont=Monaco:h16
  set lines=999 columns=9999 " max initial mvim window
elseif has("gui_running")
  if has("win32") " Windows
    set gfn=Consolas:h16
    au GUIEnter * simalt ~x  " maximize initial gvim window
  else " for X11 on Linux
    set guifont=Courier\ 10\ Pitch\ 18
    set lines=30 columns=100 " set initial sizes of gvim window
  endif
endif

" To set gvim menu fonts on CentOS 7, copy .gtkrc-2.0 files to ~/
" Its content doesn't work in ~/.vimrc
" $ cat .gtkrc-2.0
"    gtk-font-name="Sans 16"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ; :
map , \
imap jk <Esc>
"insert (cc) and remove (cu) comments in visual and normal mode
noremap   <silent> cc      :s,^\(\s*\)[^# \t]\@=,\1# ,e<CR>:nohls<CR>zvj
noremap   <silent> cu      :s,^\(\s*\)# \s\@!,\1,e<CR>:nohls<CR>zvj
   "Hit cc to comment the current line.
   "6cc to comment 6 lines.
   "K in visual mode comments the whole selection.
   "Everything can be uncommented in the same way using CTRL-K
   "If lines are already commented, they won't have an additional # added to the start.
   "If a # is followed by a space, it is considered a text comment and doesn't get touched.
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Cycling through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-t
" map , \
" :CommandTFlush " refresh file listing
" set g:CommandTAlwaysShowDotfiles=1
" set wildignore+=*/.git,*/.sn " exclude SCM metadata directories

" CtrlP Plugin
map ,t <c-p>
let g:ctrlp_show_hidden=1  " show dotfiles and not .git/
" more info at ~/.vim/readme.md
