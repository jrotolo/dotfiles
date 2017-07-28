#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
source ~/.bashrc

#Alias
## Prints all empty directories in current dir
alias pempty="find . -type d -empty -print"
## Delets all empty directories in current directory
alias dempty="find . -type d -empty -delete"

# Run Ticker Watch app using main watch list
alias stocks='ruby ~/scripts/ticker-watch/ticker.rb -l main --watch 600'
alias ticker='ruby ~/scripts/ticker-watch/ticker.rb -t'

eval "$(rbenv init - zsh)"
source $HOME/.zshenv
