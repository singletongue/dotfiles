# read system default settings
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# read .inputrc
if [ -t 1 ] && [ -f "$HOME/.inputrc" ]; then
    bind "$HOME/.inputrc"
fi

# custom prompts
function venv_info() {
    if [ -n $VIRTUAL_ENV ]; then
        echo "${VIRTUAL_ENV##*/}"
    else
        echo ""
    fi
}
PS1='\[\e[33m\]\A \[\e[36m\]\h \[\e[34m\]\w \[\e[35m\]$(venv_info)\n\[\e[32m\]\\$ \[\e[m\]'

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

# linuxbrew
if [ -d "$HOME/.linuxbrew" ]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

# set the default editor
if type nvim 2&>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# brew completions
if [ -r "$HOME/.linuxbrew/etc/profile.d/bash_completion.sh" ]; then
    . "$HOME/.linuxbrew/etc/profile.d/bash_completion.sh"
elif [ -r "/usr/local/etc/profile.d/bash_completion.sh" ]; then
    . "/usr/local/etc/profile.d/bash_completion.sh"
fi

# fzf
if [ -f "$HOME/.fzf.bash" ]; then
    source "$HOME/.fzf.bash"
fi
