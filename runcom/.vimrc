let file=$DOTFILES_PATH.'/common/.vimrc'
if filereadable(file)
  execute 'source '.file
endif

