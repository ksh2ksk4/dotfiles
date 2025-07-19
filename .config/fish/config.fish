if status is-interactive
    # Commands to run in interactive sessions can go here

end

set -gx EDITOR (which vim)
set -gx LANG ja_JP.UTF-8
set -gx LC_TIME C
set -gx LESS -Fgij10MnRWX
# これを設定していると圧縮したファイルの less でエラーになる
#set -gx LESSCOLORIZER /usr/local/bin/pygmentize
set -gx LESSPIPE (which lesspipe.sh)
set -gx LESSOPEN "|$LESSPIPE \"%s\""
set -gx LESS_ADVANCED_PREPROCESSOR 1
set -gx PAGER less

abbr -a --set-cursor -- df 'df -h%'

switch (uname -s)
    case 'Darwin'
        set -gx JAVA_HOME (/usr/libexec/java_home)
        alias l@='ll -@'

        if not set -q TMUX
            tmux
        end
    case 'Windows'
        # Windows を識別する方法が不明
        alias grep='grep --color=auto'
        alias ls='ls --color=never'
end
