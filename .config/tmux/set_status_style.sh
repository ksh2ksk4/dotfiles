#!/usr/bin/env zsh

# ディレクトリによってステータスラインの色を切り替える

if [ -z "${TMUX}" ]; then
    return
fi

cwd="$(tmux display-message -p '#{pane_current_path}')"

if [[ "${cwd}" == *"/mine/srcs/Rust/mp3player"* ]]; then
    # yellow
    tmux set status-style bg='#ffff99',fg='#000000'
    # red
    #tmux set status-style bg='#ff3300',fg='#fefefe'
elif [[ "${cwd}" == *"/mine/srcs/Rust/rf"* ]]; then
    # blue
    tmux set status-style bg='#3300ff',fg='#e0ffff'
else
    # green
    tmux set status-style bg='#00ff44',fg='#2a2a22'
fi
