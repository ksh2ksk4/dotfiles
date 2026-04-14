#
# 個人専用設定
#
[[ -f "${HOME}/config/zsh/my.sh" ]] && source "${HOME}/config/zsh/my.sh"

#
# Misc
#
export EDITOR="$(which vim)"
export LANG='ja_JP.UTF-8'
export LC_TIME='C'
export PAGER='bat'

alias l@='ll -@'

# zsh-abbr が必要?
#abbr -a --set-cursor -- df 'df -h%'

#
# Oh My Zsh
#
# 非常に紛らわしいが Oh My Zsh のインストールディレクトリを示す環境変数
export ZSH="${HOME}/.oh-my-zsh"

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
# tmux
#
function tmux_set_status_style() {
    ${HOME}/.config/tmux/set_status_style.sh
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd tmux_set_status_style
# フック関数を実行するため
cd "${PWD}"

#
# compinit
#
# キャッシュファイルは ZDOTDIR(デフォルトはホームディレクトリ)直下に作成される
# ZDOTDIR を変更すると他のドットファイルにも影響が及ぶため、手動削除で対応する
rm -f "${HOME}/.zcompdump-$(hostname -s)-${ZSH_VERSION}"*
autoload -Uz compinit
compinit -C -d "${HOME}/.cache/zsh/zcompdump-$(hostname -s)-${ZSH_VERSION}"

#
# atuin
#
eval "$(atuin init zsh)"
