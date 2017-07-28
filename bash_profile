
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile


PATH=$PATH:$HOME/bin:/opt/boxen/bin:/opt/boxen/homebrew/opt/postgresql/bin:/opt/boxen/homebrew/Cellar/postgresql/9.3.2-boxen/bin/

alias rtest='RAILS_ENV=test bundle exec rake spec spec:javascript'
alias jtest='RAILS_ENV=test bundle exec rake spec:javascript'
alias toggl='ruby -r rubygems ~/scripts/toggl_hours.rb'
alias stocks='ruby ~/scripts/ticker-watch/ticker.rb -l main --watch 900'
