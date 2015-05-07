" pathogen
execute pathogen#infect()

syntax on

set laststatus=2
set number
set shiftwidth=4 tabstop=4 textwidth=74
"set shiftwidth=2 tabstop=2 textwidth=74
set expandtab
set mouse=a
set incsearch
set so=999 " make search to the middle of the screen

so ~/.vim/color.vim
set autoindent
set smartindent

au BufRead,BufNewFile {GNUm,M,m}akefile so ~/.vim/confs/makefile.vim
au BufRead,BufNewFile *.{c,h,cc,cpp,nc,hh,hpp} so ~/.vim/confs/c-cpp.vim
au BufRead,BufNewFile *.java so ~/.vim/confs/java.vim
au BufRead,BufNewFile *.hs so ~/.vim/confs/haskell.vim
au BufRead,BufNewFile *.pin so ~/.vim/confs/pinpoint.vim
au BufRead,BufNewFile *.sh so ~/.vim/confs/shell.vim
au BufRead,BufNewFile *.rst so ~/.vim/confs/reStructured.vim
au BufRead,BufNewFile *.md so ~/.vim/confs/markdown.vim
au BufRead,BufNewFile *.go so ~/.vim/confs/go.vim

au BufRead,BufNewFile *.py so ~/.vim/confs/python.vim
au BufNewFile *.py 0r ~/.vim/skeletons/file.py

au BufRead,BufNewFile *.{tex} so ~/.vim/confs/latex.vim

au BufRead,BufNewFile *.nc so /home/dacav/var/nc.vim
au BufRead,BufNewFile *.wiki so /home/dacav/.vim/syntax/creole.vim

" Skeletons
autocmd BufNewFile *.c 0r ~/.vim/skeletons/file.c
autocmd BufNewFile *.h 0r ~/.vim/skeletons/file.h
autocmd BufNewFile *.{hpp,hh} 0r ~/.vim/skeletons/file.hpp
autocmd BufNewFile *.pl 0r ~/.vim/skeletons/file.pl
autocmd BufNewFile *.pm 0r ~/.vim/skeletons/file.pm
autocmd BufNewFile *.m 0r ~/.vim/skeletons/file.m
autocmd BufNewFile *.gnuplot 0r ~/.vim/skeletons/file.gnuplot
autocmd BufNewFile {{GNU,}M,m}akefile 0r ~/.vim/skeletons/Makefile

autocmd BufNewFile *.gnuplot set filetype=gnuplot

set notitle

" Perl Regex
set magic

"Remove storage of file marks (Hate that stuff!)
"set cursorline
set viminfo='0,:60

" My own shit
"map <F4> :read !xclip -o
map <F5> :set spell! <Enter>
map <F7> :set background=light <Enter>
map <F8> :set background=dark <Enter>

set cryptmethod=blowfish
