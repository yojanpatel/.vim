set nocompatible              " be iMproved, required
filetype off                  " required

" call pathogen#infect()
" call pathogen#helptags()

set cursorline
set incsearch
set hlsearch

" type 'za' inside a method to open and close a fold
set foldmethod=indent
set foldlevel=99

let g:pep8_map='<leader>8'

" bind Ctrl+<movement> keys to move around the window
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" disable arrow keys for best practice
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" map tab to Ctrl + tab
map <c-v>tab <c-tab>

" tab sizes
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'jelera/vim-javascript-syntax'

autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4

" context sensitive tab completion
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
" enable menu and pydoc preview
set completeopt=menuone,longest,preview

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'")
set term=builtin_ansi
syntax enable
syntax on
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Add highlighting for function definition in C++
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction

" map <C-I> :pyf ~/clang-format/clang-format.py<cr>
" imap <C-I> <c-o>:pyf ~/clang-format/clang-format.py<cr>

autocmd Syntax cpp call EnhanceCppSyntax()

:set number

" Indent Python in the Google way.
setlocal indentexpr=GetGooglePythonIndent(v:lnum)
let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
       \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
       \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')" 
       \ . " =~ '\\(Comment\\|String\\)$'")
    if par_line > 0
      call cursor(par_line, 1)
      if par_col != col("$") - 1
        return par_col
      endif
    endif 
  return GetPythonIndent(a:lnum)
endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
