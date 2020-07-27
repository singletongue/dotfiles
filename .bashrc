export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export LSCOLORS=exfxcxdxbxegedabagacad  # for BSD ls
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'  # for GNU ls

export PATH="$HOME/local/bin:$PATH"

HISTFILE="$HOME/.bash_history"
SAVEHIST=100000
HISTSIZE=10000

PROMPT_COMMAND="history -a;history -r;$PROMPT_COMMAND"
shopt -s histappend

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

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# fzf
if [ -f "$HOME/.fzf.bash" ]; then
    source "$HOME/.fzf.bash"
fi
