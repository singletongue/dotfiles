# Language and Locale
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Homebrew Paths
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/openjdk@8/bin:$PATH"

# Custom Paths
export PATH="$HOME/local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"

# History
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=100000
export HISTSIZE=10000

setopt append_history
setopt complete_in_word
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt magic_equal_subst
setopt no_beep
setopt share_history

autoload -U compinit
compinit
zstyle ':completion:*' completer _complete _prefix _approximate _list
zstyle ':completion:*' list-separator '->'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=2

# ls
export LSCOLORS=exfxcxdxbxegedabagacad  # for BSD ls
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'  # for GNU ls
alias ls='ls --color'

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# spaceship
SPACESHIP_CONDA_SHOW=false
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_GIT_BRANCH_COLOR="green"
SPACESHIP_PYENV_SHOW=false
SPACESHIP_VENV_COLOR="magenta"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
