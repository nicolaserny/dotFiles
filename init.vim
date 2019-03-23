set nocompatible

let g:mapleader = "\<Space>"

" Plugins {{{
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

" fzf {{{
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" }}}

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Launguage support {{{
" JS TS TSX JSX {{{
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
" }}}

" C# {{{
Plug 'maurelio1234/vim-csharp'
Plug 'sillyotter/t4-vim'
" }}}

" Misc {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'othree/html5.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'Nicoloren/vim-french-thesaurus'

call plug#end()
" }}}

" basics {{{
set shortmess=ac
set preserveindent
filetype plugin indent on
set relativenumber
set number
set incsearch
set noignorecase smartcase
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*/bin/**,*/obj/**
set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key
set scrolloff=5
set autoread
set autowrite
if has('mouse')
  set mouse=a
endif
set hidden
set bg=dark
set pastetoggle=<F2>
set belloff=all
" }}}

" Encoding {{{
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" }}}

" Turn-on dracula color scheme {{{
syntax on
color dracula
" }}}

" Deoplene {{{
let g:deoplete#enable_at_startup = 1
" }}}

" Airline {{{
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
let g:airline_solarized_bg='dark'
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2
set showtabline=0
" }}}

" vim-polyglot {{{
let g:polyglot_disabled = ['typescript']
" }}}

" cd - changedir {{{
nnoremap <leader>cdK :cd ~/Developer/koordinator<CR>
" }}}

" ag {{{
if executable("ag")
   set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --ignore\ node_modules\ --ignore\ dist
   set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
"}}}

" fzf{{{
let g:fzf_buffers_jump = 1
let g:fzf_command_prefix = 'Fzf'
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <leader>fb :FzfBuffers<cr>
nnoremap <leader>fh :FzfHistory<cr>
nnoremap <leader>ff :FzfFiles<cr>
nnoremap <leader>fa :Ag<cr>
nnoremap <leader>fw :execute "FzfAg " . expand("<cword>")<cr>
"}}}

" remap help navigation {{{
nmap <C-T> <C-]>
" }}}


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

    function! CallPrettier()
        mark m
        silent %!prettier --stdin  l:config_switch --stdin-filepath %
        normal! `m
    endfunction
    nnoremap gp :call CallPrettier()<CR>
    let &l:formatprg='prettier --stdin ' . l:config_switch . ' --stdin-filepath ' . expand('%')
endfunction

augroup personal
    autocmd!
    autocmd BufRead,BufNewFile *.ts,*.tsx,*.js,*.jsx,*.json,*.css  call SetupPrettier()
augroup END " }}}

" misc {{{
command! Vimrc edit ~/Developer/my-configs/init.vim
nmap Y y$
inoremap jj <Esc>
"}}}

" react snippets {{{
nmap <leader>ri iimport * as React from 'react';<CR><ESC>
nmap <leader>rr iimport { connect } from 'react-redux';<CR><ESC>
" }}}

" map buffer {{{
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>bd :bd<cr>
" }}}

" terminal mode {{{
tnoremap <C-c><C-c> <C-\><C-n>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
" }}}

" split naCavigation {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" }}}

set splitright
