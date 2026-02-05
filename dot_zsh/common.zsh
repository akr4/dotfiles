# --- General ---
export LANG=ja_JP.UTF-8
export LC_ALL=${LANG}
export VISUAL=hx
export EDITOR=hx
export CLICOLOR=1

bindkey -e
setopt magic_equal_subst print_eight_bit auto_pushd
typeset -U path fpath

# --- History ---
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups hist_ignore_all_dups share_history hist_reduce_blanks hist_save_no_dups

# --- Homebrew ---
eval "$(/opt/homebrew/bin/brew shellenv)"
path=(/opt/homebrew/opt/postgresql@16/bin $path)
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# --- Rust ---
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# --- Docker ---
path=($HOME/.docker/bin $path)
fpath=($HOME/.docker/completions $fpath)
alias dc="docker compose"

# --- kubectl ---
alias kc=kubectl

# --- fzf ---
alias hxf='hx $(fzf)'

# --- broot ---
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"


# --- bat ---
export BAT_THEME=TwoDark
alias cat=bat

# --- eza ---
alias ls=eza

# --- terraform ---
alias tf=terraform

# --- Other tools ---
path=(
    $HOME/bin
    $HOME/Library/Android/sdk/platform-tools
    /Applications/WezTerm.app/Contents/MacOS
    /usr/local/bin
    /usr/local/sbin
    /usr/local/terraform/bin
    /usr/local/go/bin
    /Applications/Xcode.app/Contents/Developer/usr/bin
    $path
)
alias grep='grep --color=auto'
alias typora="open -a typora"

# --- Google Cloud SDK ---
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# --- completion ---
autoload -Uz compinit; compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# --- General ---
export LANG=ja_JP.UTF-8
export LC_ALL=${LANG}
export VISUAL=hx
export EDITOR=hx
export CLICOLOR=1

bindkey -e
setopt magic_equal_subst print_eight_bit auto_pushd
typeset -U path fpath

# --- History ---
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups hist_ignore_all_dups share_history hist_reduce_blanks hist_save_no_dups

# --- Homebrew ---
eval "$(/opt/homebrew/bin/brew shellenv)"
path=(/opt/homebrew/opt/postgresql@16/bin $path)
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# --- Rust ---
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# --- Docker ---
path=($HOME/.docker/bin $path)
fpath=($HOME/.docker/completions $fpath)
alias dc="docker compose"

# --- kubectl ---
command -v kubectl &>/dev/null && source <(kubectl completion zsh)
alias kc=kubectl

# --- fzf ---
alias hxf='hx $(fzf)'

# --- broot ---
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"


# --- bat ---
export BAT_THEME=TwoDark
alias cat=bat

# --- eza ---
alias ls=eza

# --- terraform ---
alias tf=terraform

# --- Other tools ---
path=(
    $HOME/bin
    $HOME/Library/Android/sdk/platform-tools
    /Applications/WezTerm.app/Contents/MacOS
    /usr/local/bin
    /usr/local/sbin
    /usr/local/terraform/bin
    /usr/local/go/bin
    /Applications/Xcode.app/Contents/Developer/usr/bin
    $path
)
alias grep='grep --color=auto'
alias typora="open -a typora"

# --- Google Cloud SDK ---
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# --- completion ---
autoload -Uz compinit; compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
command -v kubectl &>/dev/null && source <(kubectl completion zsh)

