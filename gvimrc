" enable numbered lines in gvim
set number
" remove toolbar
set guioptions-=T
" enable popup choices
set guioptions+=c
" use mouse copy/paste
set mousemodel=popup
" bigger by default
set lines=40
set columns=120

" enable signify by default
let g:signify_disable_by_default = 0
" set the font explicitly for airline compatibility
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
