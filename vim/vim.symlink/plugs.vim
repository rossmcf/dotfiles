if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/pack/rossmcf/start')
"Plug 'tpope/vim-dispatch'
Plug 'Chiel92/vim-autoformat'
Plug 'Raimondi/delimitMate'
"Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elzr/vim-json'
"Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'garyburd/go-explorer'
Plug 'matze/vim-move'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'vim-scripts/AutoComplPop'
call plug#end()

