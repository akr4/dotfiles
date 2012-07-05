export LANG=ja_JP.UTF-8
export M2_REPO=$HOME/.m2/repository
export SVNREPO=$HOME/Documents/svnrepos
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
export GROOVY_HOME=/usr/local/groovy
export GRAILS_HOME=/usr/local/grails-1.3.2
export GRIFFON_HOME=/usr/local/griffon
export HADOOP_HOME=/usr/local/hadoop
export SPHINX_PATH=/usr/local/Cellar/python/2.7/bin

PATH=/usr/sbin:/usr/bin:/sbin:/bin:$PATH
PATH=/usr/local/sbin:/usr/local/bin:$PATH
PATH=/usr/local/maven/bin:$PATH
PATH=$HOME/.rvm/bin:$PATH

PATH=$GROOVY_HOME/bin:$PATH
PATH=$GRAILS_HOME/bin:$PATH
PATH=$GRIFFON_HOME/bin:$PATH
PATH=$HADOOP_HOME/bin:$PATH
PATH=/usr/local/groovyserv/bin:$PATH
PATH=$SPHINX_PATH:$PATH

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

bindkey -e
autoload -Uz compinit; compinit
setopt magic_equal_subst
setopt print_eight_bit
setopt auto_pushd

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

classpathjars () { find $1 -name "*.jar" | xargs | sed 's/ /:/g' }

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'


export JREBEL_HOME=/Applications/ZeroTurnaround/JRebel
PATH=$JREBEL_HOME/bin:$PATH


MAVEN_OPTS="-ea -Dfile.encoding=UTF-8 -DsocksProxyHost=localhost -DsocksProxyPort=1080"

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

source ~/.pythonbrew/etc/bashrc

stty -ixon

# tmux ###############################################
tm() {
  unset dir cmd host window_name

  while getopts "c:h:" flag; do
    case $flag in
      \?) OPT_ERROR=1; break;;
      h) host="$OPTARG";;
    esac
  done
  shift $(( $OPTIND - 1 ))

  if [ $1 ]; then
    dir=$1
  else
    dir=`pwd`
  fi

  if [ $host ]; then
    window_name=$host
    cmd="ssh $host"
  else
    window_name=`basename $dir`
  fi

  tmux set default-path $dir
  tmux new-window $cmd
  tmux split-window -dh -p 70 $cmd
  tmux split-window -v $cmd
  tmux select-pane -t 2
  tmux split-window -dv -p 20 $cmd
  tmux set -u default-path
  tmux rename-window $window_name
}

