#!/bin/bash

########################################################################
##################	Config
########################################################################

function	neovim()
{
	echo "[+] Installing Neovim and plugins..."

	ln -sfv $PWD/vim/vimrc $PWD/neovim/nvim.vim
	$pc_get install neovim
	$pc_get install node

	mkdir -p ~/.config/nvim

	ln -sfv $PWD/neovim/init.vim ~/.config/nvim/init.vim 
	ln -sfv $PWD/neovim/nvim.vim ~/.config/nvim/nvim.vim 
	ln -sfv $PWD/neovim/setup_plugins.vim ~/.config/nvim/plugin.vim 

	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	nvim -c ':PlugInstall' -c ':qa'

}

function	zshrc()
{
	ln -sfv $PWD/zsh/zshrc ~/.zshrc
}

########################################################################
##################	Launch
########################################################################

function	install()
{
	zshrc
	neovim
}

case "$(uname)" in
	"Darwin") pc_get="brew";;
	"Linux") pc_get="sudo apt-get" ;;
	*) usage ;;
esac
install
