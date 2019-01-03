export LANG=ja_JP.UTF-8
export LC_ALL=${LANG}
export XCODE_BIN_PATH=/Applications/Xcode.app/Contents/Developer/usr/bin

PATH=$XCODE_BIN_PATH:$PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH=/usr/local/terraform/bin:$PATH
PATH=$HOME/.go/bin:/usr/local/go/bin:$PATH
PATH=$HOME/app/sketchtool/bin:$PATH
PATH=$HOME/bin:$PATH
export PATH

case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

fpath=(~/.zfunc /usr/local/share/zsh-completions $fpath)

bindkey -e
autoload -Uz compinit; compinit
setopt magic_equal_subst
setopt print_eight_bit
setopt auto_pushd

export BAT_THEME=TwoDark

# history #############################
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt hist_reduce_blanks
setopt hist_save_no_dups

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# git ##################################################
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

# aliases ###################################################

alias ij="open -b com.jetbrains.intellij"
alias ac="open -b com.jetbrains.AppCode"
alias pc="open -b com.jetbrains.PyCharm"
alias ws="open -b com.jetbrains.webstorm"
alias as="open -b com.google.android.studio"
alias push-release="git push origin develop master && git push origin --tags"
alias ec="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
alias diff=colordiff
alias ls=exa
alias cat=bat
alias tf=terraform
alias es=./node_modules/.bin/eslint
alias pt=./node_modules/.bin/prettier
alias dc=docker-compose
alias kc=kubectl

# brew install awscli
source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh

source ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function gi() { curl https://www.gitignore.io/api/$@ ;}

## fzf ###############################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## go #################################

if [ -x "`which go`" ]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

## Node #################################
export PATH=$HOME/.nodebrew/current/bin:$PATH

## Rust #################################
source $HOME/.cargo/env

## k8s ####################################
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
if [ $commands[minikube] ]; then
  source <(minikube completion zsh)
fi

## yarn #########################################
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/akira/.sdkman"
[[ -s "/Users/akira/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/akira/.sdkman/bin/sdkman-init.sh"
