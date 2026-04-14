export MY_SYMBOL='👻'

#
# Functions
#
fpath=("${HOME}/.config/zsh/functions/macos" $fpath)
autoload -Uz macos \
    _macos_help \
    _macos_volume \
    _macos_volume_help \
    _macos_volume_info \
    _macos_volume_set
