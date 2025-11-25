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
  which python3 2>/dev/null
  if [ $? -ne 0 ]; then
    install_package python
  else
    python3 -V
  fi
  # Check either jedi is needed or not
}

function install_neovim() {
  ln -sfv $PWD/vim/vimrc $HOME/.vimrc

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  nvm install node

  # Ensure it's neovim >0.9 installed, otherwise use brew
  install_package neovim

  mkdir -p $HOME/.config

  # Create language specific settings folder
  ln -sfv $PWD/nvim $HOME/.config/nvim
}

function _brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  case "$(uname)" in
  "Linux")
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
    sudo apt install locales
    sudo locale-gen en_US.UTF-8
    sudo dpkg-reconfigure locales
    ;;
  *) usage ;;
  esac

  brew install jesseduffield/lazygit/lazygit wget ripgrep fd openssl readline sqlite3 xz zlib tcl-tk
}

function zshrc() {
  which zsh > /dev/null
  if [ $? -ne 0 ]; then
    install_package zsh
  fi

  ln -sfv $PWD/zsh/zshrc $HOME/.zshrc
  ln -sfv $PWD/zsh/.aliases $HOME/.aliases

  # Install Oh my zsh
  OH_MY_ZSH_PATH="$HOME/.oh-my-zsh"
  ZSH="$OH_MY_ZSH_PATH" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

  # Install zsh plugins
  CURRENT_DIR=$(pwd)
  ZSH_PLUGINS_DIR="$OH_MY_ZSH_PATH/custom/plugins"
  mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
  if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  fi
  cd "$CURRENT_DIR"

  # Add Hack font
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git && ./nerd-fonts/install.sh Hack && rm -rf ./nerd-fonts
}

function git_config() {
  ln -sfv $PWD/git/gitconfig $HOME/.gitconfig
  source $PWD/git/git_setup.sh
}

function install_cargo() {
  curl https://sh.rustup.rs -sSf | sh
}

########################################################################
##################	Launch
########################################################################

function ask_installation() {
  echo -n
  read -p "Do you want to config $2 ? [y]/N " confirm
  confirm=${confirm:-y}
    echo "[+] Installing ${bold}$2${normal} configuration..."
  if [ $confirm = 'y' ]; then
    "$1"
  fi
}

function install() {
  case "$(uname)" in
  "Darwin")
    xcode-select --install
  esac
  install_package gcc
  install_package unzip
  ask_installation _brew 'brew'
  ask_installation zshrc 'zsh'
  ask_installation git_config 'git'
  ask_installation install_python 'python'
  ask_installation install_neovim 'neovim'
  ask_installation install_cargo 'cargo'
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
$pc_get update
correct_folder $0
install
zsh ~/.zshrc
