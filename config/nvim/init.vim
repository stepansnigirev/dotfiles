set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set relativenumber          " add line numbers
set number!                 " keep current line number
set wildmode=longest,list   " get bash-like tab completions
set cc=88                   " set an 80 column border for good coding style
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

" search from root folder recursively
set path+=**
set wildmenu
"
" Makefile should use tabs
autocmd FileType make setlocal noexpandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType proto setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType rust setlocal shiftwidth=2 softtabstop=2 expandtab

" Command to do ctags
command! MakeTags !ctags --exclude=".venv" -R .
command! Nolsp lua vim.diagnostic.disable(0)

let g:python3_host_prog = '/home/ss/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog = '/home/ss/.pyenv/versions/neovim3/bin/python'

au BufRead,BufNewFile *.pys set filetype=python
au BufRead,BufNewFile *.pys lua vim.diagnostic.disable(0)

call plug#begin('~/.local/share/nvim/plugged')

" Color schemes
 " Plug 'tomasiser/vim-code-dark'
 Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
 " Plug 'dracula/vim'
 Plug 'ryanoasis/vim-devicons'
 " Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter' " leader cc to comment
 Plug 'mhinz/vim-startify'
 "Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
 "Plug 'Xuyuanp/yanil'
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-lualine/lualine.nvim'
 " If you want to have icons in your statusline choose one of these
 "Plug 'kyazdani42/nvim-web-devicons'
 Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
 Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.6.*' }
 " cmdline goes up, nicer ui
 Plug 'folke/noice.nvim'
 Plug 'MunifTanjim/nui.nvim'
 Plug 'rcarriga/nvim-notify'
 " delete all buffers except current one
 Plug 'numtostr/BufOnly.nvim', { 'on': 'BufOnly' }
 " theme
 " Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

" color schemes
if (has("termguicolors"))
 set termguicolors
endif
" colorscheme evening
" colorscheme dracula
" colorscheme codedark
" colorscheme deep-space
colorscheme tokyonight-moon
" colorscheme catppuccin

" open new split panes to right and below
set splitright
set splitbelow

" Remap leader to space
let mapleader = " "

" NerdTree key bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Tabs bindings
nnoremap <C-Up> :tabprevious<CR>
nnoremap <C-Down> :tabnext<CR>
nnoremap <C-k> :tabprevious<CR>
nnoremap <C-j> :tabnext<CR>

" Split bindings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tab to switch between buffers
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
" kill all buffers except current
nnoremap <leader>w :BufOnly<CR>

:lua << EOF
    local opts = { noremap=true, silent=true }
    -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    -- Configure `ruff-lsp`.
    -- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
    -- For the default config, along with instructions on how to customize the settings
    require('lspconfig').ruff_lsp.setup {
      on_attach = on_attach,
    }
EOF

lua << END
require("noice").setup()
vim.notify = require("notify")

require("bufferline").setup{
    highlights = {
        buffer_selected = { italic = false },
        diagnostic_selected = { italic = false },
        hint_selected = { italic = false },
        pick_selected = { italic = false },
        pick_visible = { italic = false },
        pick = { italic = false },
    },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    --component_separators = { left = '', right = ''},
    --section_separators = { left = '', right = ''},
    --component_separators = { left = ' | ', right = ' | '},
    --section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END

