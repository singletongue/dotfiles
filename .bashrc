# read system default settings¬
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# read .inputrc
if [ -t 1 ] && [ -f "$HOME/.inputrc" ]; then
    bind -f "$HOME/.inputrc"
fi

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export LSCOLORS=exfxcxdxbxegedabagacad  # for BSD ls
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'  # for GNU ls

export PATH="$HOME/local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"

export HISTFILE="$HOME/.bash_history"
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoreboth

function update_history() {
    history -a
    history -c
    history -r
}

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

PROMPT_COMMAND='update_history'
PS1='\[\e[31m\]\D{%Y-%m-%d} \[\e[33m\]\A \[\e[32m\]\h \[\e[36m\]\w \[\e[34m\]$(git_info)\[\e[35m\]$(venv_info)\n\[\e[32m\]\\$ \[\e[m\]'

shopt -s direxpand
shopt -u histappend
