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
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'onsails/lspkind-nvim'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'haishanh/night-owl.vim'
Plug 'github/copilot.vim'
Plug 'akinsho/toggleterm.nvim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

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
set wildignore+=*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*/bin/**,*/obj/**,.git/**,*.DS_Store
set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key
set scrolloff=5
set autoread
set autowrite
set signcolumn=yes
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

" Turn-on color scheme {{{
syntax on
colorscheme night-owl
let g:lightline = { 'colorscheme': 'nightowl' }
set termguicolors
" }}}

" Airline {{{
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
let g:airline_solarized_bg='dark'
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
set laststatus=2
set showtabline=0
" }}}

lua<< EOF
require("nvim-lsp-installer").setup {
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {},
        },
    indent = {
        enable = true,
        disable = {},
        },
    ensure_installed = {
        "tsx",
        "typescript",
        "javascript",
        "toml",
        "json",
        "yaml",
        "html",
        "scss",
        "css",
        "markdown",
        "lua",
        "vim",
        "dockerfile",
        "dot",
        "scss",
        "bash",
        },
    autotag = {
        enable = true,
        }
    }


require('telescope').setup{
pickers = {
    live_grep = {
        additional_args = function(opts)
        return {"--hidden", "--ignore-file", ".gitignore"}
        end
        },
    find_files = {
        find_command = { "rg", "--ignore-file", ".gitignore", "--hidden", "--files"},
        prompt_prefix = "🔍 "
        },
    },
}

require'nvim-web-devicons'.setup {
    override = {
        };
    default = true;
    }

require'nvim-tree'.setup {
    }

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- Use prettier for formatting
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    else
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_command [[augroup Format]]
            vim.api.nvim_command [[autocmd! * <buffer>]]
            vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
            vim.api.nvim_command [[augroup END]]
        end
    end
    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<leader>(', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>)', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
    --...
end


local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', "typescript", "typescriptreact", "typescript.tsx" },
    capabilities = capabilities
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.tailwindcss.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.dockerls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.html.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.terraformls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Do not forget to install prettier and eslint_d
-- npm i -g eslint_d prettier
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss' },
    init_options = {
        linters = {
            eslint = {
                command = 'eslint_d',
                rootPatterns = { '.git' },
                debounce = 100,
                args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
                sourceName = 'eslint_d',
                parseJson = {
                    errorsRoot = '[0].messages',
                    line = 'line',
                    column = 'column',
                    endLine = 'endLine',
                    endColumn = 'endColumn',
                    message = '[eslint] ${message} [${ruleId}]',
                    security = 'severity'
                    },
                securities = {
                    [2] = 'error',
                    [1] = 'warning'
                    }
                },
            },
        filetypes = {
            javascript = 'eslint',
            javascriptreact = 'eslint',
            typescript = 'eslint',
            typescriptreact = 'eslint',
            },
        formatters = {
            eslint_d = {
                command = 'eslint_d',
                args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
                },
            prettier = {
                command = 'prettier',
                args = { '--stdin', '--stdin-filepath', '%filename' }
                }
            },
        formatFiletypes = {
            css = 'prettier',
            javascript = 'prettier',
            javascriptreact = 'prettier',
            json = 'prettier',
            scss = 'prettier',
            less = 'prettier',
            typescript = 'prettier',
            typescriptreact = 'prettier',
            json = 'prettier',
            }
        }
    }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
        spacing = 4,
        prefix = ''
        }
    }
)

local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' },
    }),
    formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
  })

vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]

require("toggleterm").setup{
  direction = 'horizontal',
  size = 15,
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

require("indent_blankline").setup {
}

require('telescope').load_extension('fzf')

require('gitsigns').setup({
  current_line_blame = true,
})

function duckDuckGo()
  local url = 'https://duckduckgo.com/?q='
  local query = vim.fn.getreg('0')
  vim.cmd('silent exec "!open \'' .. url .. query .. '\'"')
end
vim.api.nvim_set_keymap('n', '<leader>s', '<Cmd>lua duckDuckGo()<CR>', {noremap = true})

EOF

hi DiagnosticError guifg=#EF5350
hi DiagnosticWarn guifg=#b39554
hi DiagnosticInfo guifg=#0db9d7
hi DiagnosticHint guifg=#10B981


nnoremap <leader>ff <cmd>Telescope find_files <cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>

nnoremap <C-b> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <C-n> :ToggleTerm<CR>

" remap help navigation {{{
nmap <C-)> <C-]>
inoremap <C-x><C-)> <C-x><C-]>
" }}}

" misc {{{
nmap Y y$
inoremap jj <Esc>
"}}}

" react snippets {{{
nmap <leader>ri iimport * as React from 'react';<CR><ESC>
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

augroup END " }}}

set completeopt=menuone,noinsert,noselect
set previewheight=5

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'

command! Vimrc edit ~/.config/nvim/init.vim

nnoremap <leader>es mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F
" nnoremap <leader>ess :silent exec "!yarn eslint --fix %"<CR> | redraw
nmap cp :let @" = expand("%:p")<cr>
