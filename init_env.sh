#!/bin/bash
########################################################################
##################	Config
########################################################################

function	neovim()
{
	echo "[+] Installing Neovim and plugins...\n"

	ln -sfv $PWD/vim/vimrc $PWD/neovim/nvim.vim
	$pc_get install neovim
	mkdir -p ~/.config/nvim

	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	nvim -c ':PlugInstall' -c ':qa'

}

function	zshrc()
{
	ln -sfv $PWD/.zshrc ~/.zshrc
}

########################################################################
##################	Launch
########################################################################

function	install()
{
	zshrc();
	neovim();
}

case "$(uname)" in
	"Darwin") pc_get="brew";;
	"Linux") pc_get="sudo apt-get" ;;
	*) usage ;;
esac
install;
