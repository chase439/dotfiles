let file=$DOTFILES_PATH.'/runcom/common/.vimrc'
if filereadable(file)
  execute 'source '.file
endif

