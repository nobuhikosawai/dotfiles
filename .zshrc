# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# emacs keybind
bindkey -e

#
# Input/output
#

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# ---------------------------
# User setting
# ---------------------------
# Starship prompt
eval "$(starship init zsh)"

# Use zoxide
eval "$(zoxide init zsh)"

export TERM="screen-256color"

export EDITOR=vim

# git / less
export LESS=-iXFR

# Customize to your needs...
alias g='git'
alias gs='git status'
alias gci='git commit'
alias ga='git add'

alias rake='bundle exec rake'
alias rspec='bundle exec rspec'
alias rubocop='bundle exec rubocop'
alias rubymine='open -a /Applications/RubyMine.app'
alias intellij='open -a /Applications/IntelliJ\ IDEA\ CE.app'
alias doco="docker-compose"
alias lz="lazygit"

# util
## Calendar with japanese holidays
alias calx="cal ; curl -s https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv | iconv -f SHIFT-JIS -t UTF-8 | grep -E \"`date '+%Y/%-m/'`\""
alias calx3="cal -3; curl -s https://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv | iconv -f SHIFT-JIS -t UTF-8 | grep -E \"`date -v-1m '+%Y/%-m/'`|`date '+%Y/%-m/'`|`date -v+1m '+%Y/%-m/'`\""

# lazygit 
export XDG_CONFIG_HOME="$HOME/.config"

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
  local selected_branch=$(git --no-pager branch -vv | fzf-tmux -p +m -w80% -h80%)
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout $(echo "$selected_branch" | awk '{print $1}' | sed 's/.* //')"
    zle accept-line
  fi
}
zle -N fzf-git-branch-checkout
bindkey '^g' fzf-git-branch-checkout

## fh - repeat history
function fzf-fh() {
  BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
  CURSOR=$#BUFFER
}
zle -N fzf-fh
bindkey '^R' fzf-fh

##  alacritty theme switcher
function fzf-alacritty-theme-switcher() {
  local config_path="$HOME/.config/alacritty/alacritty.yml"
  local selected_theme=$(cat $config_path | yq '.schemes | keys' | awk '{print $2}' |  fzf-tmux -p +m -w80% -h80%)
  if [ -n "$selected_theme" ]; then
    theme="$selected_theme" yq -i '.colors alias = env(theme)' $config_path
  fi
}
zle -N fzf-alacritty-theme-switcher
alias ats="fzf-alacritty-theme-switcher"

#git fixup
function git-fixup() {
  if git diff --cached --quiet; then
      local commits="No staged changes. Use git add -p to add them."
      local ret=1
  else
      local commits=$(git log --oneline -n 20)
      local ret=$?
  fi

  if [[ "$ret" != 0 ]]; then
      headline=$(head -n1 <<< "$commits")
      if [[ "$headline" = "No staged changes. Use git add -p to add them." ]]; then
          echo "$headline" >&2
      fi
  fi

  local line=$(echo "$commits" | fzf-tmux -p +m -w80% -h80%)
  if [[ "$?" = 0 && "$line" != "" ]]; then
    git commit --fixup "$(awk '{print $1}' <<< "$line")" "$@"
  fi
}

# node
eval "$(fnm env --use-on-cd)"

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

# toggl
alias tg='toggl'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/nobuhikosawai/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/nobuhikosawai/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/nobuhikosawai/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/nobuhikosawai/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
