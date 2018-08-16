New Mac
=======

ZSH
---
	chsh -s $(which zsh)
	xcode-select --install
	git clone https://github.com/rossmcf/dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
	script/bootstrap

(While CLI tools are installing…)
1Password

Homebrew
------------
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Git
---
[Generate personal access token for Github.](https://github.com/settings/tokens)

Install terminal theme from ~/.dotfiles/terminal
`brew install wget`
`wget https://www.iterm2.com/downloads/stable/latest`

Go
--
- [Download](https://golang.org/dl/)

Vim
---
- `brew install vim --with-python3`
- (check if pip3 is already installed)
- [install pip](https://pip.readthedocs.io/en/stable/installing/)
- `pip3 install neovim`
- `vim ~/.vim/plugs.vim`
- `source %`
- `:PlugInstall`

