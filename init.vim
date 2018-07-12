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

Plug 'othree/html5.vim'
Plug 'sheerun/vim-polyglot'

Plug 'vim-airline/vim-airline'
Plug 'townk/vim-autoclose'
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
set autoread
set autowrite
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
map <leader>nt :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>
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

  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <F5> :call LanguageClient_contextMenu()<cr>
  " <leader>ld to go to definition
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <leader>ld :call LanguageClient_textDocument_definition()<cr>
  " <leader>lf to autoformat document
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <leader>lf :call LanguageClient_textDocument_formatting()<cr>
  " <leader>lh for type info under cursor
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <leader>lh :call LanguageClient_textDocument_hover()<cr>
  " <leader>lr to rename variable under cursor
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <leader>lr :call LanguageClient_textDocument_rename()<cr>
  " <leader>lc to switch omnifunc to LanguageClient
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <leader>lc :setlocal omnifunc=LanguageClient#complete<cr>
  " <leader>ls to fuzzy find the symbols in the current document
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason nnoremap <buffer> <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>

  " Use as omnifunc by default
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,css,less,html,reason setlocal omnifunc=LanguageClient#complete
augroup END

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascriptreact': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescriptreact': ['javascript-typescript-stdio'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'css': ['css-languageserver', '--stdio'],
    \ 'less': ['css-languageserver', '--stdio'],
    \ 'json': ['json-languageserver', '--stdio']
    \ }

" Airline
let g:airline#extensions#tabline#enabled = 1

" vim-polyglot {{{
let g:polyglot_disabled = ['typescript']

" fzf
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = 'Fzf'
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <leader>fb :FzfBuffers<cr>
nnoremap <leader>fh :FzfHistory<cr>
nnoremap <leader>ff :FzfFiles<cr>
nnoremap <leader>fg :FzfGFiles<cr>
nnoremap <leader>fa :Ag<cr>
" remap
nmap <C-T> <C-]>


function! s:FindFolder(folder)
    let current_dir = expand("%:p:h") 

    let i = 0
    while i <= 10
        " echo "Looking for folder " . a:folder . " at " . current_dir
        let found = globpath(current_dir, a:folder, 0, 1)

        if len(found) > 0
            " echom "Found folder " . found[0]
            let l:folder = found[0]
            python3 << EOF
import os
import vim
vim.command('let l:folder = \'' + os.path.abspath(vim.eval('l:folder')) + '\'')
EOF
            return l:folder
        endif

        let i = i + 1
        let current_dir = current_dir . '/..'
    endwhile
endfunction

function! SetupPrettier()
    let l:config_path = s:FindFolder(".prettierrc")
    let l:config_switch = '--config ' . config_path

    if strlen(config_path) == 0
        let l:config_switch = ''
    endif

    nnoremap gp :silent %!prettier --stdin  l:config_switch --stdin-filepath %<CR>
endfunction

augroup personal
    autocmd!
    autocmd BufRead,BufNewFile *.ts,*.tsx,*.js,*.jsx  call SetupPrettier()
augroup END " }}}
