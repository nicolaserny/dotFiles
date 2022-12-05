set nocompatible

let g:mapleader = "\<Space>"
" let g:copilot_filetypes = { 'markdown': v:true }
let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0

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
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
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
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'haishanh/night-owl.vim'
" Plug 'github/copilot.vim'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'akinsho/toggleterm.nvim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

call plug#end()
" }}}

" basics {{{
set shortmess=ac
set preserveindent
filetype plugin indent on
set relativenumber
set number
set incsearch
set ignorecase smartcase
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
set cmdheight=1

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

" statusline {{{
set laststatus=2
set showtabline=0
" }}}

lua<< EOF

require('lualine').setup{};

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
require('nvim-ts-autotag').setup();
require("nvim-autopairs").setup {};

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
        "lua",
        "vim",
        "dockerfile",
        "dot",
        "scss",
        "bash",
        "c_sharp",
        "vue",
        "hcl",
        "markdown",
        },
    autotag = {
        enable = true,
        }
    }

require("treesitter-context").setup{
        enable = true,
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
            default = {
                "function",
                "method",
                "for",
                "while",
                "if",
                "switch",
                "case",
            },
            typescript = {
                "class_declaration",
                "abstract_class_declaration",
                "else_clause",
            },
        },
    }

local actions = require "telescope.actions"
require('telescope').setup{
defaults = {
    mappings = {
            i = {
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                },
            n = {
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                }
            },
file_ignore_patterns = {
            "node_modules",
            ".work/.*",
            ".cache/.*",
            ".idea/.*",
            "dist/.*",
            ".git/.*"
        },
    },
pickers = {
    live_grep = {
        additional_args = function(opts)
        return {"--hidden" }
        end
        },
    find_files = {
        find_command = { "rg", "--hidden", "--files"},
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

local saga = require('lspsaga')
saga.init_lsp_saga({
symbol_in_winbar = {
    in_custom = false,
    enable = true,
    separator = ' ',
    show_file = true,
    click_support = false,
}
})
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>)', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<leader>(', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gf', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- Use prettier for formatting
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
    else
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_command [[augroup Format]]
            vim.api.nvim_command [[autocmd! * <buffer>]]
            vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
            vim.api.nvim_command [[augroup END]]
        end
    end
    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
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

require'lspconfig'.eslint.setup{
  on_attach = on_attach,
    capabilities = capabilities,
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

nvim_lsp.vimls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.vuels.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
-- Do not forget to install prettier and eslint_d
-- npm i -g eslint_d prettier
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', "markdown", "vue" },
    init_options = {
        formatters = {
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
            markdown = 'prettier',
            vue = 'prettier',
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
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	luasnip = "[Snip]",
}

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
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end
	},
  })

  --    format = lspkind.cmp_format({maxwidth = 50, mode = 'symbol'})

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
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<leader>h)', function()
      if vim.wo.diff then return '<leader>h)' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '<leader>h(', function()
      if vim.wo.diff then return '<leader>h(' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
  end
})

local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function encode(str)
  if str == nil then
    return ""
  end
str = str:gsub("([/. @'~()\"])", char_to_hex)
  return str
end

function duckDuckGo()
  local url = 'https://duckduckgo.com/?q='
  local query = vim.fn.shellescape(encode(vim.fn.getreg('0')), 1)
  vim.cmd('silent exec "!open \'' .. url .. '".shellescape(' .. query .. ')."' .. '\'"')
end
vim.api.nvim_set_keymap('n', '<leader>s', '<Cmd>lua duckDuckGo()<CR>', {noremap = true})

function grepWithCurrentWord()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end
vim.api.nvim_set_keymap('n', '<leader>fw', '<Cmd>lua grepWithCurrentWord()<CR>', {noremap = true})

function commandHistory()
    require("telescope.builtin").command_history({sorter = require("telescope.sorters").get_substr_matcher()})
end
vim.api.nvim_set_keymap('n', '<leader>fr', '<Cmd>lua commandHistory()<CR>', {noremap = true})

-- Resize window
vim.keymap.set('n', '<C-w><left>', '<C-w><')
vim.keymap.set('n', '<C-w><right>', '<C-w>>')
vim.keymap.set('n', '<C-w><up>', '<C-w>+')
vim.keymap.set('n', '<C-w><down>', '<C-w>-')

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
nnoremap <leader>fp <cmd>Telescope resume<cr>

nnoremap <C-b> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <C-n> :ToggleTerm<CR>

nmap <leader>mp <Plug>MarkdownPreview
nmap <leader>ms <Plug>MarkdownPreviewStop

" remap help navigation {{{
nnoremap <C-)> <C-]>
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

" vimdiff {{{
nnoremap <leader>dd :Gvdiffsplit<CR>
nnoremap <leader>dl :diffget //2<CR>
nnoremap <leader>dr :diffget //3<CR>
nnoremap <leader>dn ]c
nnoremap <leader>dp [c
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
command! Gitg Git log --graph --decorate --oneline --all
nnoremap <leader>hf :Git fetch --all --prune<CR>
nnoremap <leader>ha :Git add -A<CR>

nnoremap <leader>es :EslintFixAll<CR>
nnoremap <leader>ess :silent exec "!yarn eslint --fix %"<CR> | redraw
nmap cp :let @" = expand("%:p")<cr>
" Close all other buffers
map <leader>o :%bd\|e#<cr>

" increment/decrement numbers
" g<C-a> to increment a list of numbers
nnoremap + <C-a>
nnoremap - <C-x>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

