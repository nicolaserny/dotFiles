 "Get the defaults that most users want.
set nocompatible

let g:mapleader = "\<Space>"

" Plugins
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/bundle')
Plug 'dracula/vim', { 'as': 'dracula' }

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" JS TS TSX JSX {{{
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

Plug 'othree/html5.vim'
Plug 'sheerun/vim-polyglot'

Plug 'vim-airline/vim-airline'
call plug#end()

" basics
filetype plugin indent on
set number
set incsearch
set ignorecase
set smartcase
set nohlsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set nowrap
set ruler
set history=200
set backspace=indent,eol,start
set showcmd             " display incomplete commands
set wildmenu            " display completion matches in a status line
set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key
set scrolloff=5
if has('mouse')
  set mouse=a
endif
set hidden


" preferences
set pastetoggle=<F2>
set belloff=all

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Turn-on dracula color scheme
syntax on
color dracula

" NERDTree
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', 'node_modules']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" Deoplene
let g:deoplete#enable_at_startup = 1

" typescript
"" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" Use location list instead of quickfix
let g:LanguageClient_diagnosticsList = 'location'

augroup LanguageClientConfig
  autocmd!

  " <leader>ld to go to definition
  autocmd FileType javascript,typescript,json,css,less,html,reason nnoremap <buffer> <leader>ld :call LanguageClient_textDocument_definition()<cr>
  " <leader>lf to autoformat document
  autocmd FileType javascript,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lf :call LanguageClient_textDocument_formatting()<cr>
  " <leader>lh for type info under cursor
  autocmd FileType javascript,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lh :call LanguageClient_textDocument_hover()<cr>
  " <leader>lr to rename variable under cursor
  autocmd FileType javascript,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lr :call LanguageClient_textDocument_rename()<cr>
  " <leader>lc to switch omnifunc to LanguageClient
  autocmd FileType javascript,typescript,json,css,less,html,reason nnoremap <buffer> <leader>lc :setlocal omnifunc=LanguageClient#complete<cr>
  " <leader>ls to fuzzy find the symbols in the current document
  autocmd FileType javascript,typescript,json,css,less,html,reason nnoremap <buffer> <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>

  " Use as omnifunc by default
  autocmd FileType javascript,typescript,json,css,less,html,reason setlocal omnifunc=LanguageClient#complete
augroup END

let g:LanguageClient_serverCommands = {}

" Minimal LSP configuration for JavaScript
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands.html = ['html-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.css = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.less = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.json = ['json-languageserver', '--stdio']
endif

" Airline
let g:airline#extensions#tabline#enabled = 1

" vim-polyglot {{{
let g:polyglot_disabled = ['typescript']

" fzf
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>fb :FzfBuffers<cr>
nnoremap <leader>fh :FzfHistory<cr>
nnoremap <leader>ff :FzfFiles<cr>
nnoremap <leader>fg :FzfGFiles<cr>
nnoremap <leader>fa :FzfAg<cr>

" prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
let g:prettier#config#print_width = 120
let g:prettier#config#tab_width = 0
let g:prettier#config#single_quote = 'true'
