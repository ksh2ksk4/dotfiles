export MY_SYMBOL='🍨'

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
