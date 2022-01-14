#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

export TERM="screen-256color"

export EDITOR=vim

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

# Util
## Calendar with japanese holidays
alias calx="cal ; curl -s https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv | iconv -f SHIFT-JIS -t UTF-8 | grep -E \"`date '+%Y/%-m/'`\""
alias calx3="cal -3; curl -s https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv | iconv -f SHIFT-JIS -t UTF-8 | grep -E \"`date -v-1m '+%Y/%-m/'`|`date '+%Y/%-m/'`|`date -v+1m '+%Y/%-m/'`\""

#yarn
export PATH="$PATH:$HOME/.yarn/bin"

#libxml2
export PATH="/usr/local/opt/libxml2/bin:$PATH"

#Android plaform-tools
export PATH="/Users/nobuhikosawai/Library/Android/sdk/platform-tools:$PATH"

#MECAB_PATH
export MECAB_PATH="/usr/local/Cellar/mecab/0.996/lib/libmecab.dylib"

# flutter
export PATH="/Users/nobuhikosawai/development/flutter/bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/platform/google_appengine:$PATH"
export GOPATH="$HOME/go"

# rbenv
if [[ ! -a ~/.rbenv ]]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# gnu-sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# zplug
if [[ -s "${HOME}/.zplug/init.zsh" ]]; then
  source "${HOME}/.zplug/init.zsh"
  zplug "agkozak/zsh-z"
  zplug "zsh-users/zsh-completions"
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  zplug load
fi

#mysql
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# fzf
## search repository
function fzf-src () {
   local selected_dir=$(ghq list -p | fzf-tmux -p -w80% -h80%)
   if [ -n "$selected_dir" ]; then
     BUFFER="cd ${selected_dir}"
     zle accept-line
   fi
 }
 zle -N fzf-src
 bindkey '^]' fzf-src

## search branch
function fzf-git-branch-checkout () {
 local selected_branch=$(git branch -a --sort=-authordate | cut -b 3- | perl -pe 's#^remotes/origin/###' | perl -nlE 'say if !$c{$_}++' | grep -v -- "->" | fzf-tmux -p -w80% -h80%)
 if [ -n "$selected_branch" ]; then
   BUFFER="git checkout ${selected_branch}"
   zle accept-line
 fi
}
zle -N fzf-git-branch-checkout
bindkey '^g' fzf-git-branch-checkout

# fh - repeat history
function fzf-fh() {
  BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
  CURSOR=$#BUFFER
}
zle -N fzf-fh
bindkey '^R' fzf-fh

# nvm
# NOTE: performance workaround by https://github.com/nvm-sh/nvm/issues/1774#issuecomment-403661680
## Install zsh-async if it’s not present
if [[ ! -a ~/.zsh-async ]]; then
    git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi
source ~/.zsh-async/async.zsh

export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}
## Initialize a new worker
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1

#Calling nvm use automatically in a directory with a .nvmrc file
autoload -U add-zsh-hook
load-nvmrc() {
  if ! type nvm > /dev/null 2>&1; then
    return;
  fi

  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc

# k8s
alias k='kubectl'
alias kb='kustomize build'
alias kc='kubectx'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kns='kubens'
alias kubeapply='kubectl apply --server-side'
alias sw-kp='switch_kube_production'
alias un-kp='unset_kube_config'
function switch_kube_production() {
  export KUBECONFIG=$HOME/.kube/prod_config
}
function unset_kube_config() {
  unset KUBECONFIG
}
## completion
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
# Only zsh
alias -g P='$(kubectl get pods | fzf-tmux -p -w80% -h80% | awk "{print \$1}")' # e.g. (kubectl get pod ${interactive selected pod})

# terraform
alias tf="terraform"

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
    *.7z) 7z x $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,7z}=extract

# gvm
[[ -s "/Users/nobuhikosawai/.gvm/scripts/gvm" ]] && source "/Users/nobuhikosawai/.gvm/scripts/gvm"

# aws
alias sw-ap='switch_aws_production'
alias un-ap='unset_aws_profile'
function switch_aws_production() {
  export AWS_PROFILE=production
}
function unset_aws_profile() {
  unset AWS_PROFILE
}
# work specific settings
[ -f ~/.work_settings.sh ] && source ~/.work_settings.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# bookmark
# https://threkk.medium.com/how-to-use-bookmarks-in-bash-zsh-6b8074e40774
if [ -d "$HOME/.bookmarks" ]; then
  export CDPATH=".:$HOME/.bookmarks:/"
  alias goto="cd -P"
  _goto()
  {
    local IFS=$'\n'
    COMPREPLY=( $( compgen -W "$(/bin/ls ~/.bookmarks)" -- ${COMP_WORDS[COMP_CWORDS]} ) )
  } && complete -F _goto goto
fi
