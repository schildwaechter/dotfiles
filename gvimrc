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

" some special settings for mac
if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

if g:os == "Darwin"
  let g:Tex_ViewRule_pdf = 'open -a Skim'
endif

