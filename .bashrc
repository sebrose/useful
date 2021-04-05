export JAVA_HOME=$(/usr/libexec/java_home)
export MYSQL_HOME=/usr/local/mysql
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/bin/local/jruby/bin
export PATH=$PATH:$MYSQL_HOME/bin
export PATH=$PATH:/Applications/texttest-3.26/source/bin
export PATH=$PATH:/usr/local/bin/apache-maven-3.6.2/bin

# export CUCUMBER_PUBLISH_TOKEN=b4a57c85-3202-40ea-a1e7-813ae6e581f8

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

bind '"\e[A"':history-search-backward # Use up and down arrow to search
bind '"\e[B"':history-search-forward  # the history. Invaluable!

alias  ls='ls -aF'                    # Append indicator (one of */=>@|)
alias  ll='ls -aFls'                  # Listing
alias  la='ls -all'

alias ga='git add'
alias grc='git rebase --continue'
alias gs='git status'
alias gpl='git pull'
alias gph='git push'
alias gc='git clone'
alias gri="git rebase -i --root"

# Git Commit with Message
gcm() {
  git commit -m "$1"
}

#Git ABort
gab() {
#  set -e

  git checkout $1
  git branch -D work

  if [ -n "$2" ]; then
    git branch work :/^===$2
    git checkout work
  fi
}

# Git Checkout Work
gcw() {
  git branch -D work
#  set -e

  git branch work :/^===$1
  git checkout work
}

gcws() {
  git branch -D work
  git branch work $1
  git checkout work
}

#Git Rebase Work
grw() {
#  set -e

  git checkout $1
  git rebase work
}

alias ..='cd ..'
alias ...='cd ../..'
alias mysql=$MYSQL_HOME/bin/mysql
alias mysqladmin=$MYSQL_HOME/bin/mysqladmin

source ~/.git-completion.sh
source ~/.git-prompt.sh
export PS1='[\W$(__git_ps1 " (%s)")]\$ '

export HISTFILESIZE=5000              # Larger history
shopt -s histappend
PROMPT_COMMAND="history -a"
#source /Users/seb/Projects/git-subrepo/.rc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
