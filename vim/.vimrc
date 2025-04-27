"The .vimrc for Alexander Gharibian

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab textwidth=79
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.rst set textwidth=79

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases set tabstop=2           " number of spaces to represent tab
set softtabstop=2 
set shiftwidth=2        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line
set wrap                " Wrap lines
set smarttab            " Be smart when tabbing lol

" make backspaces more powerful
set backspace=indent,eol,start

set ruler               " show line and column number
syntax on               " syntax highlighting
set showcmd             " show (partial) command in status line
set nu                  " line number
set background=dark
set hlsearch

"VIM cursor settings if you want
"if has("autocmd")
"  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"  au InsertEnter,InsertChange *
"    \ if v:insertmode == 'i' | 
"    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"    \ elseif v:insertmode == 'r' |
"    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"    \ endif
"  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
"endif



" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"Plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
call plug#end()
colorscheme jellybeans
let g:airline_theme='onehalfdark'
