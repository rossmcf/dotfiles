call plug#begin('~/.vim/neoplugged')
" Useful
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'matze/vim-move'
Plug 'tpope/vim-dispatch'
" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t && ruby extconf.rb && make'
    \ }
" JSON
Plug 'elzr/vim-json'
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'garyburd/go-explorer'
Plug 'jodosha/vim-godebug'
" AWS
Plug 'https://github.com/m-kat/aws-vim'
" Wiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev'}
call plug#end()

set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set backspace=2

if has("gui_running")
	syntax enable
	set background=dark
	colorscheme solarized
	if has("gui_macvim")
		set guifont=Source\ Code\ Pro\ for\ Powerline:h14
	endif
	set noerrorbells 
	set novisualbell
	set t_vb=
	autocmd! GUIEnter * set vb t_vb=
endif

let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
:set laststatus=2

" Open/close file browser
map <C-A> :vsplit .<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Apparently this is useful for vim-go.
set autowrite

" Set $GOPATH
let g:GoPath="~"

" vim-go mappings for quickfix.
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" quickfix everywhere
let g:go_list_type = "quickfix"

" camelCase JSON field names
let g:go_snippet_case_type = "camelcase"

" Quick run / test
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

" run :GoBuild or :GoTestCompile based on the go file
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

" Go syntax highlighting.
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

" Completion
let g:deoplete#enable_at_startup = 1

" Show tags with F8.
nmap <C-t>t :TagbarToggle<CR>

" Required by vimwiki
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'path': '~/Dropbox/txt/wiki/', 'syntax': 'markdown', 'ext': '.md'}]

" JSON
:autocmd BufWritePre *.json :normal gg=G

" NERDCommenter
filetype plugin on
map <C-\> <leader>c<space>

" Move
let g:move_key_modifier = 'C'
let g:move_map_keys = 0
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp

" Line numbers
:set number
