# Add personnal binaries into the PATH env variable

if [ -z "${PATH-}" ];
  then export PATH=/usr/local/bin:/usr/bin:/bin;
else
  export PATH=${HOME}/prog/mybin:$PATH;
fi

setopt noincappendhistory
setopt nosharehistory

export CDPATH=`pwd`/prog/school/projets/

# Display hexadecimal conversions

function fhex() { echo "ibase=16; $1" | bc }
function thex() { echo "obase=16; $1" | bc }

# Personal aliases

alias gpod='git pull origin develop'
alias cl++='clang++ -Wall -Werror -Wextra'

alias dco=docker-compose


#########################################################
#                   BASIC CONFIG                        #
#########################################################

ZSH=$HOME/.oh-my-zsh
# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful plugins for Rails development with Sublime Text
plugins=(gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search)

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed
export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"


# Launch Visual Studio Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}


