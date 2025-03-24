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
let g:airline_theme = 'solarized'

" set leader key to space
nnoremap <SPACE> <Nop>
:let mapleader = " "
:let maplocalleader = " "

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
" different for python
autocmd FileType python setlocal shiftwidth=4 softtabstop=4
" replace tabs with spaces
set expandtab
" use shiftwidth when indenting blocks
set shiftround
" ignore case in search unless term has cases
set smartcase
" bigger history
set history=200
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
set listchars=tab:▸␣,trail:￮,nbsp:‿,eol:↲
" toggle paste mode
set pastetoggle=<F12>

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
" reload when changed on disk
set autoread
" disable folding on default
set nofoldenable
let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vim_markdown_folding_disabled = 1

" allow accidental use of shift
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" move cursor by display lines
inoremap <Down> <C-O>gj
inoremap <Up> <C-O>gk
noremap <Down> gj
noremap <Up> gk

" add custom runtime path
let &runtimepath  = '~/.dotsecrets/vim,' . &runtimepath

" syntastic rules for different languages
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_puppet_puppetlint_args='--no-80chars-check --no-class_inherits_from_params_class-check'
let g:syntastic_eruby_ruby_quiet_messages = {"regex": "possibly useless use of a variable in void context"}
let g:syntastic_tex_checkers = ['']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_enable_signs = 0
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open = 1

let g:godef_split = 0
let g:go_fmt_fail_silently = 1
let g:go_list_type = 'quickfix'
let g:syntastic_go_checkers = ['golint', 'gofmt']

" signify off by default (on in gvimrc)
let g:signify_disable_by_default = 1
" sginify ordered list of cvs
let g:signify_vcs_list= ['git','hg','svn']

" add fountain filetype manually
au BufRead,BufNewFile *.fountain set filetype=fountain

" enable spell-check for some files
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType fountain setlocal spell

set spelllang=en_GB-ise

" Strip whitespace {
" http://vim.spf13.com/
autocmd FileType puppet,python,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }

set rtp+=/usr/local/opt/fzf
