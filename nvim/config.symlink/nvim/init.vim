call plug#begin('~/.config/nvim/plugged')
" Useful
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim'
Plug 'SirVer/ultisnips'
Plug 'matze/vim-move'
"Plug 'tpope/vim-dispatch'
"Plug 'mileszs/ack.vim'
"Plug 'tpope/vim-surround'
"Plug 'Chiel92/vim-autoformat'
"Plug 'Raimondi/delimitMate'
"Plug 'editorconfig/editorconfig-vim'
"Plug 'terryma/vim-multiple-cursors'
" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
"Plug 'majutsushi/tagbar'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wincent/command-t', {'do': 'cd ruby/command-t && ruby extconf.rb && make'}
" JSON
Plug 'elzr/vim-json'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'jodosha/vim-godebug'
"Plug 'AndrewRadev/splitjoin.vim'
Plug 'garyburd/go-explorer'
" AWS
"Plug 'https://github.com/m-kat/aws-vim'
" JavaScript
"Plug 'pangloss/vim-javascript'
" Markdown
"Plug 'godlygeek/tabular'
"Plug 'hallison/vim-markdown'
call plug#end()

set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set backspace=2

set wrap

" Solarized
syntax enable
set background=dark
colorscheme solarized
let g:solarized_visibility='low'
let g:solarized_termtrans=1
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
:set laststatus=2
set list
set listchars=tab:⇾\

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
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

" vim-go + syntastic
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_go_checkers = ["go", "gofmt", "golint", "gotype", "govet"]

let g:deoplete#enable_at_startup = 1

" Show tags with F8.
"nmap <C-t>t :TagbarToggle<CR>

" Markdown
command! MarkdownPreview !open -a /Applications/Marked\ 2.app/ %

" NERDCommenter
filetype plugin on
map <C-\> <leader>c<space>

" EditorConfig
" Play nicely with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Move
let g:move_key_modifier = 'C'
let g:move_map_keys = 0
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp

" Line numbers
:set number
:set relativenumber
