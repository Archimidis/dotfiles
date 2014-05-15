"------- Functions -----------------------------------------------------------"
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

"------- General VIM setup ---------------------------------------------------"
set sessionoptions-=options

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
set list                        " show invisible characters
set listchars=tab:>·,trail:·    " but only show tabs and trailing whitespace
set report=0                    " report back on all changes
set shortmess=atI               " shorten messages and don't show intro
set wildmenu                    " turn on wild menu :e <Tab>
set wildmode=list:longest       " set wildmenu to list choice
"colorscheme desert
set colorcolumn=80              " paints a column at 80
highlight ColorColumn ctermbg=6

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"------ Fold -----------------------------------------------------------------"
set foldmethod=indent           " fold based on indent
set foldnestmax=3               " deepest fold is 3 levels
set nofoldenable                " don't fold by default

"------ Indents and tabs -----------------------------------------------------"
set autoindent                  " set the cursor at same indent as line above
set smartindent                 " try to be smart about indenting (C-style)
set expandtab                   " expand <Tab>s with spaces; death to tabs!
set smarttab
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

"----- Reek plugin ------"
let g:reek_on_loading = 0

"----- Vim-Session setup ------"
:let g:session_autosave = 'yes'

"----- NERDTree setup ------"
autocmd vimenter * NERDTree
map <F9> :NERDTreeToggle %<CR>
" Close vim if the only windows left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"------ Pathogen ------"
execute pathogen#infect()

"------ Syntastic ------"
let g:syntastic_check_on_open=1

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

" RSpec.vim mappings
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

"------ Filetypes ------------------------------------------------------------"
" Vimscript
autocmd FileType vim setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Shell
autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" Ruby
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

" Vundle Setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle !!required!!
" nelstrom/vim-textobj-rubyblock depends on kana/vim-textobj-user
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'vim-ruby/vim-ruby'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'lucapette/vim-ruby-doc'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-pathogen.git'
Bundle 'tpope/vim-endwise.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/gem-ctags.git'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-unimpaired'
Bundle 'thoughtbot/vim-rspec'
Bundle 'edsono/vim-matchit'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate.git'
Bundle 'honza/vim-snippets.git'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'tpope/vim-haml'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree.git'
Bundle 'scrooloose/syntastic'
Bundle 'Bogdanp/rbrepl.vim'
Bundle 'jQuery'
Bundle 'vim-scripts/dbext.vim.git'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ngmy/vim-rubocop'
Bundle 'mattn/emmet-vim'
Bundle 'rainerborene/vim-reek'
Bundle 'Valloric/YouCompleteMe'
Bundle 'marijnh/tern_for_vim'
"Bundle 'Lokaltog/powerline'

Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'git://git.wincent.com/command-t.git'

" colorschemes
" Bundle 'jpo/vim-railscasts-theme'
" Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on
"params[:doc_file_upload_form][:file]
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
