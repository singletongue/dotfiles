# 補完候補を一覧で表示する
setopt auto_list
# 補完キー連打で候補順に自動で補完する
setopt auto_menu
# cd 時に自動でディレクトリスタックに追加する
setopt auto_pushd
# コマンド履歴に実行時間も記録する
setopt extended_history
# 履歴中の重複行をすべて削除する
setopt hist_ignore_all_dups
# 直前と重複するコマンドを記録しない
setopt hist_ignore_dups
# コマンド中の余分なスペースは削除して履歴に記録する
setopt hist_reduce_blanks
# 履歴と重複するコマンドを記録しない
setopt hist_save_no_dups
# ^D でシェルを終了しない
setopt ignore_eof
# 履歴をすぐに追加する（通常はシェル終了時）
setopt inc_append_history
# # 以降をコメントとして扱う
setopt interactive_comments
# ビープを無効にする
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
# = 以降も補完する（例：--option=value）
setopt magic_equal_subst
# バックグラウンド処理の状態変化をすぐに通知する
setopt notify
# 8bit文字を有効にする
setopt print_eight_bit
# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value
# VCS情報の表示を有効にする
setopt prompt_subst
# ディレクトリスタックと重複したディレクトリをスタックに追加しない
setopt pushd_ignore_dups
# rm * の前に確認をとる
setopt rm_star_wait
# Zsh間で履歴を共有する
setopt share_history
# コマンド実行後は右プロンプトを消す
setopt transient_rprompt

# フック機能を有効にする
autoload -Uz add-zsh-hook
# コマンドのオプションや引数を補完する
autoload -Uz compinit && compinit -u
# URLをエスケープする
autoload -Uz url-quote-magic
# VCS情報の表示を有効にする
autoload -Uz vcs_info
# 文字入力時にURLをエスケープする
zle -N self-insert url-quote-magic

# 標準エディタを設定する
export EDITOR=vim
# コマンド履歴を保存するファイルを指定する
export HISTFILE=~/.zhistory
# メモリに保存する履歴の件数を指定する
export HISTSIZE=10000
# ファイルに保存する履歴の件数を指定する
export SAVEHIST=1000000
# 文字コードを設定する
export LANG='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
# LESSの文字コード設定
export LESSCHARSET=utf-8

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# 補完の表示方法を変更する
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'

# zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Prompt
ENVNAME=''

zstyle ':vcs_info:*' formats '%b'

function precmd_vcs_info() {
  vcs_info
}

function precmd_env_info() {
  if [ -z $VIRTUAL_ENV ]; then
    ENVNAME=''
  else
    ENVNAME=${VIRTUAL_ENV##*/}
  fi
}

add-zsh-hook precmd precmd_vcs_info
add-zsh-hook precmd precmd_env_info

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
PROMPT='%F{3}%T %F{6}%m %F{4}%~ %F{5}${ENVNAME} %F{2}${vcs_info_msg_0_}%f
%F{2}$%f '

# zplug
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'mollifier/anyframe'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

