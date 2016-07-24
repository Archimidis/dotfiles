"scriptencoding utf-8
"set encoding=utf-8

"------ Pathogen ------"
execute pathogen#infect()

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
set noerrorbells                " don't whine
set visualbell t_vb=            " and don't make faces
set lazyredraw                  " don't redraw while in macros
set scrolloff=5                 " keep at least 5 lines around the cursor
set wrap                        " soft wrap long lines
" set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set report=0                    " report back on all changes
set shortmess=atI               " shorten messages and don't show intro
set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice

syntax enable
if !has('gui_running')
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
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

"----- Rainbow Parentheses plugin ------"
"let g:rbpt_colorpairs = [
    "\ ['brown',       'RoyalBlue3'],
    "\ ['Darkblue',    'SeaGreen3'],
    "\ ['darkgray',    'DarkOrchid3'],
    "\ ['darkgreen',   'firebrick3'],
    "\ ['darkcyan',    'RoyalBlue3'],
    "\ ['darkred',     'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['brown',       'firebrick3'],
    "\ ['gray',        'RoyalBlue3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['Darkblue',    'firebrick3'],
    "\ ['darkgreen',   'RoyalBlue3'],
    "\ ['darkcyan',    'SeaGreen3'],
    "\ ['darkred',     'DarkOrchid3'],
    "\ ['red',         'firebrick3'],
    "\ ]

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces


"----- Reek plugin ------"
"let g:reek_on_loading = 0

"----- Vim-Session setup ------"
":let g:session_autosave = 'yes'

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

call NERDTreeHighlightFile('hs', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

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

"------ The Silver Searcher ------"
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

"------ Airline ------"
"let g:airline_inactive_collapse=0
"set laststatus=2

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

map ,y :call JsBeautify()<cr>
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

" PHP
autocmd FileType php setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" X?HTML & XML
autocmd FileType html,xhtml,xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" coffeescript
autocmd FileType coffee setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" CSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" JavaScript
" autocmd BufRead,BufNewFile *.json setfiletype javascript
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let javascript_enable_domhtmlcss=1

" Elixir
autocmd FileType ex,exs setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Vundle Setup
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle !!required!!
" nelstrom/vim-textobj-rubyblock depends on kana/vim-textobj-user
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-pathogen.git'
Bundle 'tpope/vim-endwise.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-unimpaired'
Bundle 'edsono/vim-matchit'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate.git'
Bundle 'honza/vim-snippets.git'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree.git'
Bundle 'scrooloose/syntastic'
Bundle 'mattn/emmet-vim'
Bundle 'marijnh/tern_for_vim'

"Bundle 'git://git.wincent.com/command-t.git'

"Bundle 'vim-airline/vim-airline'
"Bundle 'edkolev/promptline.vim'
"Bundle 'vim-airline/vim-airline-themes'

Plugin 'jelera/vim-javascript-syntax'
Bundle 'mxw/vim-jsx'

Plugin 'maksimr/vim-jsbeautify'
Plugin 'editorconfig/editorconfig-vim'
"Plugin 'einars/js-beautify'

" Bundle 'airblade/vim-gitgutter'

Bundle 'Valloric/YouCompleteMe'
"Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'Lokaltog/powerline'

Bundle 'L9'
Bundle 'FuzzyFinder'
"Bundle 'elixir-lang/vim-elixir'

" colorschemes
Bundle 'altercation/vim-colors-solarized'
call vundle#end()

filetype plugin indent on
"params[:doc_file_upload_form][:file]
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
