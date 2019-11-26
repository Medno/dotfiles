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

function	neovim()
{
	echo "[+] Installing ${bold}Neovim${normal} and plugins..."

	ln -sfv $PWD/vim/vimrc $PWD/neovim/nvim.vim
	ln -sfv $PWD/vim/vimrc $HOME/.vimrc 
	$pc_check_installed neovim >/dev/null || $pc_get install neovim
	$pc_check_installed node >/dev/null || $pc_get install node

	mkdir -p ~/.config/nvim

	ln -sfv $PWD/neovim/init.vim ~/.config/nvim/init.vim 
	ln -sfv $PWD/neovim/nvim.vim ~/.config/nvim/nvim.vim 
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

case "$(uname)" in
	"Darwin") pc_get="brew"
		pc_check_installed="brew list";;
	"Linux") pc_get="sudo apt-get"
		pc_check_installed="dpkg -s";;
	*) usage ;;
esac
install
