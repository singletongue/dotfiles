# read system default settings
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# read .inputrc
if [ -t 1 ] && [ -f "$HOME/.inputrc" ]; then
    bind -f "$HOME/.inputrc"
fi

# custom prompts
function git_info() {
    BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ -n "$BRANCH" ]; then
        echo "$BRANCH "
    else
        echo ""
    fi
}
function venv_info() {
    if [ -n $VIRTUAL_ENV ]; then
        echo "${VIRTUAL_ENV##*/} "
    else
        echo ""
    fi
}
PS1='\[\e[31m\]\D{%Y-%m-%d} \[\e[33m\]\A \[\e[32m\]\h \[\e[36m\]\w \[\e[34m\]$(git_info)\[\e[35m\]$(venv_info)\n\[\e[32m\]\\$ \[\e[m\]'

# history-related configuration
export HISTFILE="$HOME/.bash_history"
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoreboth

# update history in real time
shopt -s histappend
PROMPT_COMMAND="history -a;history -r;$PROMPT_COMMAND"

# set locales and charsets
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# set custom paths
export PATH="$HOME/local/bin:$PATH"

# set the default editor
if type nvim 2&>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# brew completions
if [ -r "/usr/local/etc/profile.d/bash_completion.sh" ]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi

# fzf
if [ -f "$HOME/.fzf.bash" ]; then
    source "$HOME/.fzf.bash"
fi
