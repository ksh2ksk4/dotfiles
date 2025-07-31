function fish_should_add_to_history
    # 履歴に残したくないコマンド(引数なし)
    set -l commands 'bg' 'cd' 'exit' 'fg' 'history' 'jobs' 'la' 'll' 'ls' 'pwd' 'set' 'top' 'tree'

    contains $argv $commands; and return 1

    # 履歴に残したくないコマンド(引数あり)
    set -l commandsWithArgs 'cat' 'kill' 'which'

    for c in $commandsWithArgs
        string match -q -r "^$c" $argv; and return 1
    end

    return 0
end
