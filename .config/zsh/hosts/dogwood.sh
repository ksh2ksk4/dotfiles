export MY_SYMBOL='🌈'

# Functions
() {
    fpath=("${ZDOTDIR}/functions/arch_linux" $fpath)
    autoload -Uz dogwood-mount-all \
        dogwood-umount-all
}
