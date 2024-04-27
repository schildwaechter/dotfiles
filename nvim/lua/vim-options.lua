vim.cmd("set encoding=utf-8 nobomb")
vim.cmd("set fileencoding=utf-8")

vim.cmd("set number")
vim.cmd("set relativenumber")

vim.cmd("set clipboard=unnamed,unnamedplus") --- regular clipboard integration
vim.cmd("set mouse=a")                      --- enable mouse

---vim.cmd("set showtabline=2")        --- always show tabs rows

vim.cmd("set shiftwidth=2") --- indent by two spaces
vim.cmd("set tabstop=2")    --- tab inserts two spaces
vim.cmd("autocmd FileType python setlocal shiftwidth=4 softtabstop=4") -- tab rules for python
vim.cmd("set expandtab")    --- replace tabs with spaces
vim.cmd("set shiftwidth=2") --- use shiftwidth when indenting blocks

vim.cmd("set hlsearch")     --- highlight search terms
vim.cmd("set incsearch")    --- search while typing
vim.cmd("set showmatch")    --- show matching parantheses/braces

vim.cmd("highlight NonText guifg=#4a4a59")
vim.cmd("highlight SpecialKey guifg=#4a4a59")
vim.cmd("set listchars=tab:▸␣,trail:￮,nbsp:‿,eol:¬")

vim.cmd("set scrolloff=3")  --- editing behaviour

vim.cmd("set ignorecase")   --- using smartcase
vim.cmd("set smartcase")    --- ignore case in search unless term has cases

--vim.cmd("set runtimepath=~/.dotsecrets/vim,$VIMRUNTIME") -- adding custom runtimepath
vim.cmd("let &runtimepath  = '~/.dotsecrets/vim,' . &runtimepath")

