function mc -d "Create a directory then change to it"
    command mkdir $argv

    if test $status = 0
        set -l arg $argv[(count $argv)]

        switch $arg
            case '-*'
                # オプションの場合
            case '*'
                cd $arg
                return
        end
    end
end
