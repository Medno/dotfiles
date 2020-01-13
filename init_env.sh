#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
########################################################################
##################	Config
########################################################################

function	onedark()
{
	curl -fLo $HOME/.vim/autoload/lightline/colorscheme/onedark.vim --create-dirs \
		https://raw.githubusercontent.com/joshdick/onedark.vim/master/autoload/lightline/colorscheme/onedark.vim
}

function	install_package()
{
	package=$1
	$pc_check_installed $package >/dev/null
	if [ $? -ne 0 ]; then
		$pc_get install $package
		if [ $? -ne 0 ]; then
			echo "Error: Unable to install ${bold}$package${normal}"
			exit 1
		fi
	fi
	echo "${bold}$package${normal} installed"
}

function	neovim()
{
	echo "[+] Installing ${bold}Neovim${normal} and plugins..."

	ln -sfv $PWD/vim/vimrc $HOME/.vimrc 
	install_package neovim
	install_package node

	mkdir -p ~/.config/nvim

	ln -sfv $PWD/neovim/init.vim ~/.config/nvim/init.vim 
	ln -sfv $PWD/vim/vimrc ~/.config/nvim/nvim.vim 
	ln -sfv $PWD/neovim/setup_plugins.vim ~/.config/nvim/plugin.vim 

	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	onedark
	nvim -c ':PlugInstall' -c ':qa'

}

function	zshrc()
{
	echo "[+] Installing ${bold}zsh${normal} configuration..."
	ln -sfv $PWD/zsh/zshrc ~/.zshrc
}

function	git_config()
{
	echo "[+] Installing ${bold}git${normal} configuration..."
	ln -sfv $PWD/git/gitconfig ~/.gitconfig
}

########################################################################
##################	Launch
########################################################################

function	install()
{
	zshrc
	neovim
	git_config
}

function	correct_folder()
{
	if [ $0 = "./$(basename $0)" ]; then
		return
	fi
	echo "Invalid location, you must be in setup git repository"
	exit
}

case "$(uname)" in
	"Darwin") pc_get="brew"
		pc_check_installed="brew list";;
	"Linux") pc_get="sudo apt-get"
		pc_check_installed="dpkg -s";;
	*) usage ;;
esac
correct_folder
install
