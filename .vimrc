" pathogen plugin was installed to .vim/autoload
" load pathogen by sourcing it via runtime!
" if pathogen exists, then infect vim plugins in .vim/bundle
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif

"let file=$DOTFILES_PATH.'/common/.vimrc'
let file='common/.vimrc'
if filereadable(file)
  execute 'source '.file
endif

" Command-t
" map , \
" :CommandTFlush " refresh file listing
" set g:CommandTAlwaysShowDotfiles=1
" set wildignore+=*/.git,*/.sn " exclude SCM metadata directories

" CtrlP Plugin
map ,t <c-p>
let g:ctrlp_show_hidden=1  " show dotfiles and not .git/
" more info at ~/.vim/readme.md

" Solarized color theme, fonts, window sizes
if has("gui_running")
  syntax enable
  set background=dark
  colorscheme solarized
  
  if has("win32") " Windows
    set gfn=Consolas:h16
    au GUIEnter * simalt ~x  " maximize initial Vim windows
  else " for X11 on Linux, or Mac
    " set gfn=Monaco:h16 " Mac
    set guifont=Courier\ 10\ Pitch\ 18
    set lines=30 columns=100 " set initial sizes of gvim window
  endif
endif

" To set gvim menu fonts on CentOS 7, copy .gtkrc-2.0 files to ~/
" Its content doesn't work in ~/.vimrc
" $ cat .gtkrc-2.0
"    gtk-font-name="Sans 16"




