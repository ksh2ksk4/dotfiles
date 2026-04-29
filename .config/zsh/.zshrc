#
# ホスト個別設定
#
function load_per_host_settings() {
    local me=""

    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS の場合
        me="$(hostname -s)"
    elif [[ "$(uname)" == "Linux" ]]; then
        # Arch Linux の場合
        me="$(hostnamectl --static)"
    fi

    [[ -f "${ZDOTDIR}/hosts/${me}.sh" ]] && source "${ZDOTDIR}/hosts/${me}.sh"
}

load_per_host_settings

#
# Misc
#
export EDITOR="$(which vim)"
export LANG='ja_JP.UTF-8'
export LC_TIME='C'
export PAGER='bat'

#
# Oh My Zsh
#
# 非常に紛らわしいが Oh My Zsh のインストールディレクトリを示す環境変数
export ZSH="${ZDOTDIR}/oh-my-zsh"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 30

#
# Oh My Zsh プラグイン
#
plugins=(
    git
    zsh-autosuggestions
)
source "${ZSH}/oh-my-zsh.sh"

#
# 履歴関連
#
# 一応設定はしてあるが、履歴は atuin で管理する
export HIST_STAMPS='%Y-%m-%d %H:%M:%S'
export HISTFILE="${HOME}/.local/share/zsh/history"
export HISTORY_IGNORE='(bg|cd|exit|fg|history|jobs|kill *|la|ll|ls|l@|pwd|set|top|tree|which *)'
export HISTSIZE=1000
export SAVEHIST=1000

setopt inc_append_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

# macOS 独自の履歴機能の設定を解除
unset SHELL_SESSION_DIR
unset SHELL_SESSION_HISTORY
unset SHELL_SESSION_ID

#
# プロンプト
#
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

function get_prompt() {
    local border_line="%F{cyan}$(yes '-' | head -n $(tput cols) | tr -d '\n')%f"
    local user_and_host='%F{blue}%n@%m%f'
    local cwd='%F{red}%~%f'
    local datetime="%F{green}$(date +'%F %T')%f"
    local last_cmd_status='%B%F{red}%?%f%b'
    echo "${border_line}\n[${MY_SYMBOL} ${user_and_host}:${cwd}]\n[${datetime}][${last_cmd_status}]%# "
}

function get_rprompt() {
    # 変数の値を返す訳ではないのでダブルクォートではなくシングルクォート
    local git_prompt='${vcs_info_msg_0_}'
    echo "${git_prompt}"
}

export PROMPT="$(get_prompt)"
export RPROMPT="$(get_rprompt)"

#
# atuin
#
eval "$(atuin init zsh)"

#
# alias
#
alias df='df -h'
alias l@='ll -@'
