" Begin Plugins

call plug#begin()

Plug 'tpope/vim-surround' " Surrounding ysw)

Plug 'preservim/nerdtree' " NerdTree

Plug 'preservim/nerdcommenter' " Nerd Commenting

Plug 'tpope/vim-commentary' " For Commenting gcc & gc

Plug 'vim-airline/vim-airline' " Status bar

Plug 'vim-airline/vim-airline-themes' " Extension Of Main Airline plugin

Plug 'lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim

Plug 'ap/vim-css-color' " CSS Color Preview

Plug 'rafi/awesome-vim-colorschemes' " Retro Scheme

Plug 'neoclide/coc.nvim', { 'branch' : 'release' } " Auto Completion

let g:coc_global_extensions = [
	\ 'coc-clangd',
	\ 'coc-eslint',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-pairs',
	\ 'coc-prettier',
	\ 'coc-pyright',
	\ 'coc-python',
	\ 'coc-sh',
	\ 'coc-spell-checker',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
\ ]

Plug 'ryanoasis/vim-devicons' " Developer Icons

Plug 'tc50cal/vim-terminal' " Vim Terminal

Plug 'preservim/tagbar' " Tagbar for code navigation

Plug 'terryma/vim-multiple-cursors' " CTRL + N for multiple cursors

Plug 'psliwka/vim-smoothie' " Smooth Scrolling For Vim

Plug 'dense-analysis/ale' " Linting For Vim

Plug 'Shougo/echodoc.vim' " Echo function doc

Plug 'metakirby5/codi.vim' " Live scratchpad

Plug 'sheerun/vim-polyglot' " Glob Files Thing For Vim

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Vim Fuzzyfinder

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkpd#util#install() }, 'for': ['markdown', 'vim-plug'] }

Plug 'lervag/vimtex' " LaTeX Plugin for Vim

call plug#end()

" Terminal Vim Config

if (empty($TMUX))
	if (has('nvim'))
		let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	endif
	if (has('termguicolors'))
		set termguicolors
	endif
endif

" Vim Configurations

set number wrap
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set scroll=0
set encoding=UTF-8
set completeopt+=preview " For Previews
set noshowmode

filetype plugin on
syntax enable
colorscheme jellybeans
hi Normal guibg=NONE ctermbg=NONE	" To Make Neovim Transparent For Any Terminal With Truecolors

" Add Mapleader key

let mapleader = ","

" Enable Folding

set foldmethod=syntax
set foldlevel=99
nnoremap <Space> za

" Search pattern across repository files
" https://github.com/junegunn/fzf.vim/issues/338#issuecomment-751500234
function! FzfExplore(...)
	let inpath = substitute(a:1, "'", '', 'g')
	if inpath == "" || matchend(inpath, '/') == strlen(inpath)
        execute "cd" getcwd() . '/' . inpath
		let cwpath = getcwd() . '/'
		call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': cwpath, 'sink': 'FZFExplore', 'options': ['--prompt', cwpath]})))
    else
        let file = getcwd() . '/' . inpath
        execute "e" file
    endif
endfunction

command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))

" Prettier command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Detection For Finding NerdTree Only, if so it will terminate neovim

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Use tab for trigger completion with characters ahead and navigate.
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Navigate with Tab / Shift Tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Make <CR> confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ale
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:rustfmt_autosave = 1

" Markdown preview
nmap <leader>p <Plug>MarkdownPreviewToggle

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Conqueror Of Code
nnoremap <silent> <leader>l :call CocActionAsync('jumpDefinition')<CR>
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" Use tab for trigger completion with characters ahead and navigate.
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Navigate with Tab / Shift Tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Make <CR> confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Vim-Smoothie
nnoremap <unique> <silent> <C-D> <cmd>call smoothie#downwards() <CR>
nnoremap <unique> <silent> <C-F> <cmd>call smoothie#upwards() <CR>
" Open new files
noremap <C-n> :execute("FZF")<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" Shortcuts to reload and edit this file
nnoremap <silent> <leader><leader> :source $MYVIMRC<CR>
nnoremap <silent> <leader>e :tabnew $MYVIMRC<CR>

" NERDTree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
nnoremap <silent> <leader>f :NERDTreeFocus<CR>
nnoremap <silent> <leader>n :NERDTree<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>

" NERDCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
nmap <leader>c <Plug>NERDCommenterToggle
vmap <leader>c <Plug>NERDCommenterToggle<CR>gv

" Tagbar
nmap <F8> :TagbarToggle<CR>
