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
	install_package node
	install_package neovim

	mkdir -p ~/.config/nvim

	ln -sfv $PWD/neovim/init.vim ~/.config/nvim/init.vim 
	ln -sfv $PWD/vim/vimrc ~/.config/nvim/nvim.vim 
	ln -sfv $PWD/neovim/setup_plugins.vim ~/.config/nvim/plugin.vim 

	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	onedark
	nvim -c ':PlugInstall' -c ':qa'
	nvim -c ':CocInstall coc-python' -c ':qa'

}

function	zshrc()
{
	echo "[+] Installing ${bold}zsh${normal} configuration..."
	ln -sfv $PWD/zsh/zshrc $HOME/.zshrc

	# Install Oh my zsh
	OH_MY_ZSH_PATH="$PWD/zsh/.oh-my-zsh"
	ZSH="$OH_MY_ZSH_PATH" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

	# Install zsh plugins
	CURRENT_DIR=`pwd`
	ZSH_PLUGINS_DIR="$OH_MY_ZSH_PATH/custom/plugins"
	mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
	if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
		echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
		git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
	fi
	cd "$CURRENT_DIR"
}

function	git_config()
{
	echo "[+] Installing ${bold}git${normal} configuration..."
	ln -sfv $PWD/git/gitconfig ~/.gitconfig
	source $PWD/git/git_setup.sh
}

########################################################################
##################	Launch
########################################################################

function	ask_installation()
{
	echo -n 
	read -p "Do you want to config $2 ? [y]/N " confirm
	confirm=${confirm:-y}
	if [ $confirm = 'y' ]; then
		"$1"
	fi
}

function	install()
{
	ask_installation zshrc 'zsh'
	ask_installation neovim 'neovim'
	ask_installation git_config 'git'
}

function	correct_folder()
{
	if [ $1 = "./$(basename $1)" ]; then
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
correct_folder $0
install
zsh ~/.zshrc
