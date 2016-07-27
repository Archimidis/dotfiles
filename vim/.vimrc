"scriptencoding utf-8
"set encoding=utf-8

"------- Vundle Setup --------------------------------------------------------"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'FuzzyFinder'
Plugin 'L9'

Plugin 'easymotion/vim-easymotion' " A simpler way to use some motions in vim
Plugin 'benjifisher/matchit.zip' " Configure % to match other constructs as well
Plugin 'editorconfig/editorconfig-vim' " Requires installation of editorconfig-core-c

Plugin 'scrooloose/nerdcommenter' " Comment functions
Plugin 'scrooloose/nerdtree.git' " Tree explorer plugin
Plugin 'scrooloose/syntastic' " Syntastic is a syntax checking plugin

Plugin 'tpope/vim-endwise.git' " Help to end certain structures automatically
Plugin 'tpope/vim-fugitive.git' " Git wrapper
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired' " Complementary pairs of mappings
Plugin 'tpope/vim-repeat' " Enable repeating supported plugin maps with '.'

" The following 4 plugins must be installed together
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate.git'
Plugin 'honza/vim-snippets.git'

" Javascript, JSON
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'othree/javascript-libraries-syntax.vim' " Extends syntax for lodash, etc
Plugin 'moll/vim-node'
Plugin 'marijnh/tern_for_vim'
Plugin 'maksimr/vim-jsbeautify' " JS Style from .editorconfig

" Colour themes
Plugin 'altercation/vim-colors-solarized'
" Plugin 'morhetz/gruvbox'

Plugin 'airblade/vim-gitgutter' " Show git diff

" Plugins for html
" Plugin 'mattn/emmet-vim'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'Valloric/YouCompleteMe'
Plugin 'git://git.wincent.com/command-t.git'

call vundle#end()

"------- Functions -----------------------------------------------------------"
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

"------- General VIM setup ---------------------------------------------------"
set sessionoptions-=options
"set autoread  "Reload files changed outside vim

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

set nocompatible                " break away from old vi compatibility
set fileformats=unix,dos,mac    " support all three newline formats
set viminfo=                    " don't use or save viminfo files

" Backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Deactivate arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"------ Console UI & Text display --------------------------------------------"
set cmdheight=1                 " explicitly set the height of the command line
set showcmd                     " Show (partial) command in status line.
set number                      " yay line numbers
set ruler                       " show current position at bottom
set lazyredraw                  " don't redraw while in macros
set scrolloff=5                 " keep at least 5 lines around the cursor
set wrap                        " soft wrap long lines
" set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set report=0                    " report back on all changes
set shortmess=atI               " shorten messages and don't show intro
set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice

set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

syntax enable

if has('gui_running')
    set guifont=Hack\ 12
    set guioptions-=m " remove menu bar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove right-hand scroll bar
    set guioptions-=L " remove left-hand scroll bar
endif

set background=dark
colorscheme solarized

"set colorcolumn=80              " paints a column at 80
"highlight ColorColumn ctermbg=6

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"------ Fold -----------------------------------------------------------------"
set foldmethod=indent           " fold based on indent
set foldnestmax=3               " deepest fold is 3 levels
set nofoldenable                " don't fold by default

"------ Indents and tabs -----------------------------------------------------"
set autoindent                  " set the cursor at same indent as line above
set smartindent                 " try to be smart about indenting (C-style)
set smarttab
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set shiftwidth=4                " spaces for each step of (auto)indent
set softtabstop=4               " set virtual tab stop (compat for 8-wide tabs)
set tabstop=8                   " for proper display of files with tabs
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents
set preserveindent              " save as much indent structure as possible
filetype plugin indent on       " load filetype plugins and indent settings

set textwidth=80

set ignorecase
set smartcase
set incsearch

syntax on
set nocompatible               " be iMproved
filetype off                   " required!
filetype plugin on

"----- Plugins setup ---------------------------------------------------------"

"----- NERDTree setup ------"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <F9> :NERDTreeToggle %<CR>
" Close vim if the only windows left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

"------ Syntastic ------"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_debug=1

"------ YouCompleteMe ------"
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

"------ Tern for vim ------"
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

"------ editorconfig ------"
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"------ vim-javascript ----"
let g:javascript_plugin_jsdoc = 1

"------ vim-jsbeautify -"
map ,y :call JsBeautify()<cr>

"------ The Silver Searcher ------"
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

"----- Key bindings ----------------------------------------------------------"
" Tab navigation keys:
" Ctrl + l = move to the next tab
" Ctrl + h = move to the previous tab
" Ctrl + n = create a new tab
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>

" Pressing <F5> will list all opened buffers wil wait a number to be inserted as
" argument to :buffer. It the opens the associated buffer.
:nnoremap <F5> :buffers<CR>:buffer<Space>

noremap <leader>w :call DeleteTrailingWS()<CR>

" Bind K to grep word under cursor using the silver sarcher
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

let g:markdown_fenced_languages = ['javascript', 'html', 'vim', 'ruby', 'python', 'bash=sh']

"------ Filetypes ------------------------------------------------------------"
autocmd BufRead,BufNewFile,BufFilePre .babelrc        setfiletype json
autocmd BufRead,BufNewFile,BufFilePre .bowerrc        setfiletype json
autocmd BufRead,BufNewFile,BufFilePre .eslintrc       setfiletype json
autocmd BufRead,BufNewFile,BufFilePre .jscsrc         setfiletype json
autocmd BufRead,BufNewFile,BufFilePre .jshintrc       setfiletype json
autocmd BufRead,BufNewFile,BufFilePre .pug            setfiletype haml

autocmd BufRead,BufNewFile,BufFilePre *.md            setfiletype markdown.pandoc

" Vimscript
autocmd FileType vim setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Shell
autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Haskell
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" X?HTML & XML
autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" CSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" JavaScript
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let javascript_enable_domhtmlcss=1

