"Plugs ------------------------------------
call plug#begin()
Plug 'nvim-pack/nvim-spectre' "code style search
Plug 'klen/nvim-test' "test runner
Plug 'dmmulroy/tsc.nvim' " Type check with TSC
Plug 'adelarsq/vim-matchit' " % works with html tags n stuff
Plug 'mlaursen/vim-react-snippets' "snip snip
Plug 'vim-airline/vim-airline' " Bottom bar
Plug 'vim-airline/vim-airline-themes'
Plug 'lewis6991/gitsigns.nvim' "git blamme
Plug 'nvim-lua/plenary.nvim' "lua helpers
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'smithbm2316/centerpad.nvim' " Center buffer
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'norcalli/nvim-colorizer.lua' "#00FFFF <colored
Plug 'jiangmiao/auto-pairs' "{ gives {}
Plug 'rust-lang/rust.vim'
Plug 'alvan/vim-closetag' "auto close tag
Plug 'AndrewRadev/tagalong.vim' "rename tag
Plug 'tpope/vim-surround' "surround with {  } etc
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-unimpaired' "[n
Plug 'tpope/vim-fugitive'         " :G stuff
Plug 'tommcdo/vim-fubitive'         " Bitbucket
Plug 'tpope/vim-rhubarb'          " :GBrowse
Plug 'tpope/vim-commentary' "gcc
Plug 'rmagatti/auto-session', { 'config': 'AutoSessionConfig' } "continue where left
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree' "better undo and undo files
Plug 'nvim-tree/nvim-web-devicons'
Plug 'neoclide/coc-yaml'
Plug 'neoclide/coc-html',
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


function! AutoSessionConfig()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    }
EOF
endfunction

"Theming ----------------------------
":set autochdir
colorscheme catppuccin
source $HOME/.config/nvim/themes/airline.vim

"Config -----------------------------

set nocompatible " be iMproved, required

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Numbers
set number
set numberwidth=4
set ruler

" Indentation
set autoindent
set cindent
set smartindent

" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

set ignorecase " Ignore case when searching
set smartcase  " When searching try to be smart about cases
set nohlsearch " Don't highlight search term
set incsearch  " Jumping search

" Always show the status line
set laststatus=2

" Allow copy and paste from system clipboard
set clipboard+=unnamedplus

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

command ByeClassNames %s/className={\_.\{-}}/

"CoC extensions
let g:coc_global_extensions = ['coc-tsserver', "coc-emmet", 'coc-json', 'coc-eslint', 'coc-prettier', 'coc-snippets', 'coc-yaml', 'coc-html']

"Format on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

set undodir=~/.vim/undo-dir
set undofile

"rust format on save
let g:rustfmt_autosave = 1

":set autochdir
set scrolloff=8
set number
set expandtab
set relativenumber

"set the default encoding to utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Spellcheck for features and markdown
au BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.md.erb setlocal spell
au BufRead,BufNewFile *.feature setlocal spell

" Delete characters outside of insert area
set backspace=indent,eol,start

" If fzf installed using git
set rtp+=~/.fzf

" Optionally reset the cursor on start:
augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\e[6 q"
augroup END

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

" Tab Options
set shiftwidth=2
set tabstop=2
set softtabstop=2 " Number of spaces a tab counts when editing
set expandtab

" Fix syntax highlight for Coc plugin floating errors
hi CocErrorFloat guifg=Magenta guibg=Magenta

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

let g:user_emmet_leader_key=","

let g:closetag_filenames = '*.html,*.xhtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ 'typescriptreact': 'jsxRegion,tsxRegion',
      \ 'javascriptreact': 'jsxRegion',
      \ }



" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300



"Keybinds ------------------------------------
let mapleader = " " " map leader to Space

let g:user_emmet_mode="n"
let g:user_emmet_leader_key=","

nnoremap <leader>p :e#n<CR>
nnoremap <leader>e `.<CR>

"Force coc to confirm on enter when the suggestions are visible
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
nnoremap <F5> :UndotreeToggle<CR>
"console.log visually selected to the next line
:vmap <leader>c y<esc>oconsole.log(<c-r>");<esc>

"search for visual select
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"center code
nnoremap <silent><leader>z <cmd>Centerpad<cr>

nmap <leader>t :tabnew<CR>
nmap <A-h> :tabprev<CR>
nmap <A-l> :tabprev<CR>


"CoC stuff xxx
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent><leader>v :vsplit<CR><C-w>l

" Faster saving and exiting
nnoremap <silent><leader>w :w!<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>x :x<CR>

" Open Vim configuration file for editing
nnoremap <silent><leader>2 :e ~/.vimrc<CR>

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

nnoremap <silent><leader>f <Plug>(coc-codeaction)

" vim-test shortcut for running tests
nnoremap <silent><leader>; :TestNearest<CR>
nnoremap <silent><leader>tf :TestFile<CR>

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"yank the whole file
nnoremap <leader>Y gg"+yG


"yy without line break
nnoremap <leader>y _v$y

nnoremap <leader>ff <cmd>Telescope find_files<cr>	nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <C-p> :Telescope file_browser path=%:p:h <cr>	nnoremap <C-p> :Telescope file_browser path=%:p:h hidden=true <cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>	nnoremap <leader>fg <cmd>Telescope live_grep hidden=true<cr>
nnoremap <leader>t :Telescope treesitter <cr>	nnoremap <leader>t :Telescope treesitter hidden=true <cr>

nnoremap <S-m> <C-d>zz
nnoremap <S-j> <C-u>zz
vnoremap <S-m> <C-d>zz
vnoremap <S-j> <C-u>zz

"move visual up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"select current line
nnoremap <leader>l _v$

"Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ga <Plug>(coc-codeaction-selected)
xmap <silent> ga <Plug>(coc-codeaction-selected)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)



" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
":nnoremap <Space> @q
"
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
nnoremap <C-E> :copen<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <C-w>:noa w<CR>

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


nnoremap <Leader>c :call CreateFile()<CR>

function! CreateFile()
  let filename = input('Enter file name: ')
  let dirname = expand('%:p:h')
  let fullpath = dirname . '/' . filename
  execute 'silent! !touch ' . fullpath
  execute 'e ' . fullpath
endfunction
"replace visually selected text in the file
vnoremap <leader>r "hy:%s/<C-r>h//gc<left><left><left>

nnoremap <leader>gd :Gvdiffsplit!<CR>

nnoremap gsh :diffget //2<CR>
nnoremap gsj :diffget //3<CR>
nnoremap gso :Git checkout --ours -- %<CR>
nnoremap gst :Git checkout --theirs -- %<CR>


"Harpoon
nmap <leader>m :lua require("harpoon.mark").add_file()<CR>
nmap <C-h> :Telescope harpoon marks<CR>

nnoremap <leader>g :Git<CR>

"Current file history
nnoremap <leader>gh :Git log -- %<CR>
