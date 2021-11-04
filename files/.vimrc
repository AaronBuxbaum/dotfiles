" Pathogen
execute pathogen#infect()

" Appearance
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
filetype plugin indent on

" File behavior
set smarttab
set linebreak

" Install and run vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
so ~/.vim/plugins.vim

" Relative line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Lightline
set laststatus=2

" Ale
let g:ale_fix_on_save=1
let g:ale_fixers=['prettier', 'eslint']
