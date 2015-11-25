filetype off
" disable compatiblility mode
set nocompatible
" load plugins via pathogen
execute pathogen#infect()
" default to utf8 without bom in display and file
set encoding=utf-8 nobomb
set fileencoding=utf-8
" generate all Helptags
Helptags
" filetype plugin
filetype plugin indent on
" enable 256 color mode
set t_Co=256
" vim-airline statusline always on
set laststatus=2
" vim-airline autopopulate fonts
let g:airline_powerline_fonts = 1

" syntax
syntax enable
" solarized theme in dark mode
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
" indent by two spaces
set shiftwidth=2
" tab inserts two spaces
set tabstop=2
" replace tabs with spaces
set expandtab
" use shiftwidth when indenting blocks
set shiftround
" ignore case in search unless term has cases
set smartcase
" turn off numbering (enbaled only in gvimrc)
set nonumber
" highlight search terms
set hlsearch
" search while typing
set incsearch
" show matching parantheses/braces
set showmatch
" define color and chars for tab and eol
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set listchars=tab:▸\ ,eol:¬

" editing behaviour
set scrolloff=3
" no backup file
set nobackup
set nowritebackup
" no swapfile
set noswapfile
set fileformat=unix
" enable backspacing across lines etc
set backspace=indent,eol,start
" disable folding on default
set nofoldenable
let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vim_markdown_folding_disabled = 1

" move cursor by display lines
inoremap <Down> <C-O>gj
inoremap <Up> <C-O>gk
noremap <Down> gj
noremap <Up> gk

" syntastic rules for different languages
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_puppet_puppetlint_args='--no-80chars-check --no-class_inherits_from_params_class-check'
let g:syntastic_eruby_ruby_quiet_messages = {"regex": "possibly useless use of a variable in void context"}
let g:syntastic_tex_checkers = ['']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_enable_signs = 0
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1

" signify off by default (on in gvimrc)
let g:signify_disable_by_default = 1
" sginify ordered list of cvs
let g:signify_vcs_list= ['git','hg','svn','bzr']

" add fountain filetype manually
au BufRead,BufNewFile *.fountain set filetype=fountain

