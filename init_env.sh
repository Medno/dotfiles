#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)
########################################################################
##################	Config
########################################################################

function install_package() {
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

function install_python() {
  echo "[+] Installing ${bold}Python${normal} and packages..."
  which python3 2>/dev/null
  if [ $? -ne 0 ]; then
    install_package python
  else
    python3 -V
  fi
  # Check either jedi is needed or not
}

function install_neovim() {
  echo "[+] Installing ${bold}Neovim${normal} and plugins..."

  ln -sfv $PWD/vim/vimrc $HOME/.vimrc
  install_package node
  install_package neovim

  mkdir -p ~/.config/nvim

  # Create language specific settings folder
  ln -sfv $PWD/nvim $HOME/.config/nvim
}

function _brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install jesseduffield/lazygit/lazygit wget ripgrep fd openssl readline sqlite3 xz zlib tcl-tk node
}

function zshrc() {
  echo "[+] Installing ${bold}zsh${normal} configuration..."
  ln -sfv $PWD/zsh/zshrc $HOME/.zshrc

  # Install Oh my zsh
  OH_MY_ZSH_PATH="$HOME/.oh-my-zsh"
  ZSH="$OH_MY_ZSH_PATH" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  # Install zsh plugins
  CURRENT_DIR=$(pwd)
  ZSH_PLUGINS_DIR="$OH_MY_ZSH_PATH/custom/plugins"
  mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
  if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
  fi
  cd "$CURRENT_DIR"

  # Add Hack font
  brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-fon
}

function git_config() {
  echo "[+] Installing ${bold}git${normal} configuration..."
  ln -sfv $PWD/git/gitconfig ~/.gitconfig
  source $PWD/git/git_setup.sh
}

########################################################################
##################	Launch
########################################################################

function ask_installation() {
  echo -n
  read -p "Do you want to config $2 ? [y]/N " confirm
  confirm=${confirm:-y}
  if [ $confirm = 'y' ]; then
    "$1"
  fi
}

function install() {
  xcode-select --install
  ask_installation _brew 'brew'
  ask_installation zshrc 'zsh'
  ask_installation git_config 'git'
  ask_installation install_python 'python'
  ask_installation install_neovim 'neovim'
}

function correct_folder() {
  if [ $1 = "./$(basename $1)" ]; then
    return
  fi
  echo "Invalid location, you must be in setup git repository"
  exit
}

case "$(uname)" in
"Darwin")
  pc_get="brew"
  pc_check_installed="brew list"
  ;;
"Linux")
  pc_get="sudo apt-get"
  pc_check_installed="dpkg -s"
  ;;
*) usage ;;
esac
correct_folder $0
install
zsh ~/.zshrc
