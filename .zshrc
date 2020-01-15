#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

export TERM="xterm-256color"

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
alias gi='git'
alias gti='git'
alias rake='bundle exec rake'
alias rspec='bundle exec rspec'
alias rubocop='bundle exec rubocop'
alias rubymine='open -a /Applications/RubyMine.app'
alias webstorm='open -a /Applications/WebStorm.app'
alias intellij='open -a /Applications/IntelliJ\ IDEA\ CE.app'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias doco="docker-compose"
#
#nodebrew
#
export PATH=$HOME/.nodebrew/current/bin:$PATH
#
#yarn
#
export PATH="$PATH:$HOME/.yarn/bin"
#
#libxml2
#
export PATH="/usr/local/opt/libxml2/bin:$PATH"
#
#Android plaform-tools
#
export PATH="/Users/nobuhikosawai/Library/Android/sdk/platform-tools:$PATH"
#
#MECAB_PATH
#
export MECAB_PATH="/usr/local/Cellar/mecab/0.996/lib/libmecab.dylib"
#
# flutter
#
export PATH="/Users/nobuhikosawai/development/flutter/bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/platform/google_appengine:$PATH"
export GOPATH="$HOME/go"

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/nobuhikosawai/.nodebrew/node/v6.12.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/nobuhikosawai/.nodebrew/node/v6.12.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/nobuhikosawai/.nodebrew/node/v6.12.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/nobuhikosawai/.nodebrew/node/v6.12.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# zplug
if [[ -s "${HOME}/.zplug/init.zsh" ]]; then
  source "${HOME}/.zplug/init.zsh"
  zplug "agkozak/zsh-z"
  zplug load
fi

# hub
function git(){hub "$@"}

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# peco
## search repository
function peco-src () {
   local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
   if [ -n "$selected_dir" ]; then
     BUFFER="cd ${selected_dir}"
     zle accept-line
   fi
   zle clear-screen
 }
 zle -N peco-src
 bindkey '^]' peco-src

 ## search branch
 function peco-git-branch-checkout () {
   local selected_branch=$(git branch -a --sort=-authordate | cut -b 3- | perl -pe 's#^remotes/origin/###' | perl -nlE 'say if !$c{$_}++' | grep -v -- "->" | peco)
   if [ -n "$selected_branch" ]; then
     BUFFER="git checkout ${selected_branch}"
     zle accept-line
   fi
   zle clear-screen
 }
 zle -N peco-git-branch-checkout
 bindkey '^g' peco-git-branch-checkout

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/nobuhikosawai/.ghq/github.com/strobo-inc/leafee-watching/packages/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/nobuhikosawai/.ghq/github.com/strobo-inc/leafee-watching/packages/serverless/node_modules/tabtab/.completions/slss.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# kube
KUBECONFIG="$HOME/.kube/my_config"
