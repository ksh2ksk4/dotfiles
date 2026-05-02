export MY_SYMBOL='👻'

# Functions
() {
    fpath=("${ZDOTDIR}/functions/macos" $fpath)
    autoload -Uz macos \
        _macos_help \
        _macos_volume \
        _macos_volume_help \
        _macos_volume_info \
        _macos_volume_set
}
# tmux
() {
    function tmux_set_status_style() {
        ${HOME}/.config/tmux/set_status_style.sh
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd tmux_set_status_style
    # フック関数を実行するため
    cd "${PWD}"
}
# Rust
() {
    #   公式インストーラが .zshenv に追加した設定をここに移動
    #   (.zshenv に設定するのは行儀が悪い)
    #   他の OS ではパッケージマネージャでインストールしており、
    #   このスクリプトが存在しない
    . "${HOME}/.cargo/env"
}
