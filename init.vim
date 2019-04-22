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

" Launguage support {{{
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

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

" Better display for messages
set cmdheight=2

" Encoding {{{
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
" }}}

" Turn-on dracula color scheme {{{
syntax on
color dracula
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
nnoremap <leader>fg :FzfGFiles<cr>
nnoremap <leader>fa :Ag<cr>
nnoremap <leader>fw :execute "FzfAg " . expand("<cword>")<cr>
"}}}

" remap help navigation {{{
nmap <C-T> <C-]>
" }}}

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

" Augroup {{{
augroup personal
    autocmd!
    " Filetype detection {{{
    autocmd BufRead,BufNewFile *.template set filetype=sh
    autocmd BufRead,BufNewFile *.xaml,*.cxml,*.xcml,App.config,NLog.config set filetype=xml
    " }}}

    " Filetype specific settings {{{
    autocmd FileType markdown setlocal wrap textwidth=0 colorcolumn=0 spell spelllang=fr,en
    autocmd FileType dockerfile setlocal textwidth=0
    autocmd FileType sh setlocal textwidth=0
    autocmd FileType xml setlocal textwidth=0
    autocmd FileType python setlocal textwidth=0
    " }}}
    
    autocmd FileType javascript,javascript.jsx inoremap <silent><expr> <c-n> coc#refresh()
    autocmd FileType typescript,typescript.tsx inoremap <silent><expr> <c-n> coc#refresh()
augroup END " }}}
" }}}
" cic-vim {{{
" Use <c-space> for trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> (c <Plug>(coc-diagnostic-prev)
nmap <silent> )c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensionsleader>c
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of culeader>cdocument
nnoremap <silent> <leader>fo  :<C-u>CocList outline<cr>
" Search workspace leader>fs
nnoremap <silent> <leader>fs  :<C-u>CocList -I symbols<cr>
" Do default actionleader>cext item.
nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
" Do default actionleader>crevious item.
nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest cocleader>c
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>
"}}}

" Prettier config
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
nmap <silent> gp :Prettier<CR>

" OmniSharp {{{
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'
set completeopt=longest,menuone,preview
let g:OmniSharp_timeout = 5
set previewheight=5
let g:OmniSharp_highlight_types = 1
inoremap <C-Space> <C-x><C-o>
augroup omnisharp_commands
    autocmd!
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
augroup END
" }}}

