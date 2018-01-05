set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'rstacruz/sparkup'
Plugin 'nanotech/jellybeans.vim'
Plugin 'gregsexton/MatchTag'
Plugin 'nvie/vim-flake8'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'mxw/vim-jsx'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'pangloss/vim-javascript'
Plugin 'rust-lang/rust.vim'
Plugin 'leafo/moonscript-vim'
Plugin 'quabug/vim-gdscript'
Plugin 'Shougo/vimproc.vim'
Plugin 'posva/vim-vue'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"Colorshceme
colorscheme jellybeans 
highlight LineNr ctermfg=grey

"General settings
filetype on                  
filetype indent on
filetype plugin on
syntax on
set hidden
set lazyredraw
set showmode
set wildmenu
set number
au BufLeave * set nocursorline nocursorcolumn
au BufEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
set t_Co=256

" Ignore some file
set wildignore=*.swp,*.bak,*.pyc,*.class
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set smarttab
set expandtab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
set runtimepath^=~/.vim/bundle/ctrlp.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
"Py Flake settings
let g:flake8_show_quickfix=0

" Airline settings
let g:airline_powerline_fonts = 1
"let g:airline_theme='powerlineish'

"NerdTree 
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
autocmd FileType nerdtree noremap <buffer> <Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <S-Tab> <nop>
"autocmd VimEnter * NERDTree


"Python indentaion
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

"Syntatic confs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args = "--ignore=E501"
let g:syntastic_javascript_checkers = ['eslint']

"YCM settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" MiniBufExpl Colors
"i MBENormal               guifg=#808080 guibg=fg
"i MBEChanged              guifg=#CD5907 guibg=fg
"i MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
"i MBEVisibleChanged       guifg=#F1266F guibg=fg
"i MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
"i MBEVisibleActiveChanged guifg=#F1266F guibg=fg

"Cycle through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"Moving through windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"jsx settings
let g:jsx_ext_required = 1

"js-pretty-template settings
autocmd FileType typescript JsPreTmpl markdown
autocmd FileType typescript syn clear foldBraces

"tsuquyomi settings
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

"vim ts settings


python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)sipdb.set_trace() %(space)s %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import ipdb":
            break
    else:
        vim.current.buffer.append('import ipdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <f9> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == 'import ipdb' or strLine.lstrip().startswith('ipdb.set_trace()'):
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( 'normal %dG' % nCurrentLine)

vim.command( 'map <f10> :py RemoveBreakpoints()<cr>')
EOF

python << EOF


