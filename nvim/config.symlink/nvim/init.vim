call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'Shougo/denite.nvim'
Plug 'matze/vim-move'
Plug 'tpope/vim-dispatch'
Plug 'Chiel92/vim-autoformat'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'elzr/vim-json'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'jodosha/vim-godebug'
Plug 'garyburd/go-explorer'
Plug 'pangloss/vim-javascript'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

set nocompatible
filetype off
filetype plugin indent on

set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set mouse=a      

set noerrorbells             " No beeps
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case 
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set updatetime=400

set pumheight=10             " Completion window max size
set colorcolumn=80           " Vertical line at column 80.

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set viminfo='200

set lazyredraw          " Wait to redraw

if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo//
endif

set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set backspace=2

set wrap

" Invisibles
set list
set listchars=tab:⇾\

" Solarized
syntax enable
colorscheme solarized
let g:solarized_visibility='low'
let g:solarized_termtrans=1
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
set background=dark
:set laststatus=2

" Open/close file browser
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap ,cd :lcd %:p:h

" Autoformat on save
"au BufWrite * :Autoformat
"autocmd FileType yml,yaml,ctmpl,txt,Dockerfile let b:autoformat_autoindent=0

set autowrite " Apparently this is useful for vim-go.
let g:GoPath="~"
" vim-go mappings for quickfix.
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
let g:go_list_type = "quickfix" " quickfix everywhere
let g:go_snippet_case_type = "camelcase"
let g:go_addtags_transform = "camelcase"
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>f  <Plug>(go-test-func)
autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>a  <Plug>(go-alternate-edit)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#cmd#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction
let g:go_auto_type_info = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

" vim-go + syntastic
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_go_checkers = ["go", "gofmt", "golint", "gotype", "govet"]

let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-N>" : "\<tab>"
let g:UltiSnipsExpandTrigger="<tab>"

" Show todos in a go project.
" Fatih is a star.
 autocmd Filetype go command! GoTodos vimgrep TODO: **/*.go | cwindow

" Show tags with F8.
"nmap <C-t>t :TagbarToggle<CR>

" Markdown
command! MarkdownPreview !open -a /Applications/MacDown.app/ %

" NERDCommenter
filetype plugin on
map <C-\> <leader>c<space>

" EditorConfig
" Play nicely with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
au FileType gitcommit set tw=72

" Move
let g:move_key_modifier = 'C'
let g:move_map_keys = 0
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp

" Line numbers
set number
set relativenumber

" ==================== CtrlP ====================
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_switch_buffer = 'et'  " jump to a file if it's open already
let g:ctrlp_mruf_max=450    " number of recently opened files
let g:ctrlp_max_files=0     " do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_match_window = 'bottom,order:btt,max:10,results:10'
let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ftv'}

func! MyCtrlPTag()
  let g:ctrlp_prompt_mappings = {
		\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
		\ 'AcceptSelection("t")': ['<c-t>'],
		\ }
  CtrlPBufTag
endfunc
command! MyCtrlPTag call MyCtrlPTag()

nmap <C-b> :CtrlPCurWD<cr>
imap <C-b> <esc>:CtrlPCurWD<cr>

" Fat-fingered commands
" Courtesy of github.com/captainsafia
cnoreabbrev W! w!
cnoreabbrev E! e!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev Vsp vsp

