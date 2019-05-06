" remove all existing autocmds
autocmd!

" pathogen plugin was installed to .vim/autoload
" load pathogen by sourcing it via runtime!
" if pathogen exists, then load other plugins in .vim/bundle
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif

" Vim-Plug - similar to pathogen, another plugin manager
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" update &runtimepath and initialize plugin system
call plug#end()

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
set number relativenumber  " show hybrid line numbers, relative and absolute
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set cursorline " highlight current line
" Always show tab bar at the top
set showtabline=2
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set showcmd  " display incomplete commands
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
let mapleader=","
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1
" Reset what vim thinks is part of a word, i.e., underscore
set iskeyword&

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BACKUPS & SESSIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup  " keep a backup file
set backupdir=~/.vim-temp
set directory=~/.vim-temp
if !isdirectory(&directory)
  call mkdir(&directory, "p")
endif

let sessiondir=$HOME."/vs"
if !isdirectory(sessiondir)
  call mkdir(sessiondir)
endif
" whenever you exit or quit vim, auto-create a session file
autocmd VimLeavePre * execute "mksession! ".sessiondir."/temp"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber,rake set ai sw=2 sts=2 et
  autocmd FileType python set sw=2 sts=2 et

  " javascript
  autocmd! FileType javascript set sw=2 sts=2 expandtab autoindent smartindent nocindent
augroup END

"highlight trailing whitespaces; http://vim.wikia.com/wiki/Highlight_unwanted_spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL
" :syntax list   " list all syntaxes
" :syntax clear ExtraWhitespace   " clear ExtraWhitespace group syntaxes

" show relative line numbers in normal mode, absolute line numbers in insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR/FONT/WINDOW SIZES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"avoid extra Shift key
map ; :
" Escape shortcut
imap jk <Esc>
" Shift+Enter to insert block 'end'; 'cc' smart indent inserts
imap <S-CR>  <CR><CR>end<Esc>-cc

"insert (,cc) and remove (,cu) comments in visual and normal mode
"6cc to comment 6 lines; cc is already mapped in Vim core
noremap   <silent> ,cc      :s,^\(\s*\)[^# \t]\@=,\1# ,e<CR>:nohls<CR>zvj
noremap   <silent> ,cu      :s,^\(\s*\)# \s\@!,\1,e<CR>:nohls<CR>zvj

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Cycling through buffers; :bd to delete current buffer:w
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" A user can press F5 to delete all trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" https://vim.fandom.com/wiki/Switching_case_of_characters
" visually select text then press ~ to convert the text to UPPER CASE, then to lower case, then to Title Case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SPECIFIC CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comment block, stuff I'm disabling
function! _blockcomment()

  " Command-t plugin
  map , \
  map <leader>C :CommandTFlush<cr>  " refresh file listing
  set g:CommandTAlwaysShowDotfiles=1
  set wildignore+=*/.git,*/.sn " exclude SCM metadata directories

  " FZF
  " https://github.com/junegunn/fzf.vim
  " https://github.com/junegunn/fzf/blob/master/README-VIM.md
  " :FZF to activate plugin
  map ,t :FZF<cr>
endfunction

" CtrlP Plugin
" more info in ctrlp readme.md
map ,t <c-p>
let g:ctrlp_show_hidden=1  " show dotfiles and not .git/
if executable('ag')
  " if ag command exists, fuzzy find files super fast using the silver surfer ag command
  "   --unrestricted option to ignore rules in .gitignore and .ignore, etc.
  let g:ctrlp_user_command='ag %s -l --hidden --nocolor -g ""'
endif
" clear to rescan index; ',C' or ,t + F5
map <leader>C :CtrlPClearCache<cr>

" NERDTree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=1 " show hidden/dot files
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Tips
" Use / search, gg and G liberally to move around faster.
" capital O to expand all folders, X to collapse all
" r to refresh current directory
" ? to toggle NerdTree Help page

