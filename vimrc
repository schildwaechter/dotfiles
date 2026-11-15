" basics
set nocompatible
set encoding=utf-8 nobomb
set fileencoding=utf-8

" enable built-in filetype detection, plugins, and indentation
filetype plugin indent on
syntax enable

" leader
nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = " "

" indentation
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set shiftround
set smartindent
set autoindent

autocmd FileType python setlocal shiftwidth=4 softtabstop=4

" search
set hlsearch
set incsearch
set smartcase

" interface
set laststatus=2
set nonumber
set scrolloff=3
set history=200
set showmatch
set backspace=indent,eol,start
set autoread
set fileformat=unix
set background=dark
colorscheme habamax

" list chars
set listchars=tab:▸␣,trail:￮,nbsp:‿
set list

" no backups/swap
set nobackup
set nowritebackup
set noswapfile

" mode-aware statusline
" colours mirror config/nvim/lua/plugins/lualine.lua
highlight StatusLine         ctermfg=247 ctermbg=235  guifg=#93a1a1 guibg=#073642
highlight StatusLineNormal   ctermfg=15  ctermbg=24   guifg=#ffffff guibg=#33658A
highlight StatusLineInsert   ctermfg=15  ctermbg=168  guifg=#ffffff guibg=#DA627D
highlight StatusLineVisual   ctermfg=234 ctermbg=110  guifg=#002b36 guibg=#86BBD8
highlight StatusLineReplace  ctermfg=234 ctermbg=216  guifg=#002b36 guibg=#FCA17D
highlight StatusLineCommand  ctermfg=234 ctermbg=216  guifg=#002b36 guibg=#FCA17D
highlight StatusLineSectionY ctermfg=15  ctermbg=239  guifg=#ffffff guibg=#49404f
highlight StatusLineSectionZ ctermfg=15  ctermbg=30   guifg=#ffffff guibg=#047E84

function! StatusLineMode() abort
  let l:mode_map = {
    \ 'n':      [' NORMAL ',  'StatusLineNormal'],
    \ 'i':      [' INSERT ',  'StatusLineInsert'],
    \ 'v':      [' VISUAL ',  'StatusLineVisual'],
    \ 'V':      [' V-LINE ',  'StatusLineVisual'],
    \ "\<C-v>": [' V-BLOCK ', 'StatusLineVisual'],
    \ 'c':      [' COMMAND ', 'StatusLineCommand'],
    \ 'R':      [' REPLACE ', 'StatusLineReplace'],
    \ 's':      [' SELECT ',  'StatusLineVisual'],
    \ 'S':      [' S-LINE ',  'StatusLineVisual'],
    \ "\<C-s>": [' S-BLOCK ', 'StatusLineVisual'],
    \ 't':      [' TERMINAL ', 'StatusLineInsert'],
  \ }
  let [l:label, l:hl] = get(l:mode_map, mode(), [' UNKNOWN ', 'StatusLineNormal'])
  return '%#' . l:hl . '#' . l:label . '%*'
endfunction

function! StatusLine() abort
  return StatusLineMode()
    \ . ' %f'
    \ . ' %m%r%h%w'
    \ . ' %='
    \ . ' %{&filetype} '
    \ . '%#StatusLineSectionY# %p%% %*'
    \ . '%#StatusLineSectionZ# %l:%c %*'
endfunction

set statusline=%!StatusLine()

augroup StatusLineRedraw
  autocmd!
  autocmd ModeChanged * redrawstatus
augroup END

" shift-proof commands
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

" strip trailing whitespace
autocmd FileType python,yaml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
function! StripTrailingWhitespace()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

set pastetoggle=<F12>
