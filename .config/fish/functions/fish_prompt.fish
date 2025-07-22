function fish_prompt -d 'Write out the prompt'
    set -l last_cmd_status $status

    #
    # Foreground color
    #
    set -l normal (set_color normal)
    # Standard color
    set -l black (set_color black)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l magenta (set_color magenta)
    set -l cyan (set_color cyan)
    set -l white (set_color white)
    # Bright color
    set -l brblack (set_color brblack)
    set -l brred (set_color brred)
    set -l brgreen (set_color brgreen)
    set -l bryellow (set_color bryellow)
    set -l brblue (set_color brblue)
    set -l brmagenta (set_color brmagenta)
    set -l brcyan (set_color brcyan)
    set -l brwhite (set_color brwhite)
    #
    # Background color
    #
    set -l b_normal (set_color -b normal)
    # Standard color
    set -l b_black (set_color -b black)
    set -l b_red (set_color -b red)
    set -l b_green (set_color -b green)
    set -l b_yellow (set_color -b yellow)
    set -l b_blue (set_color -b blue)
    set -l b_magenta (set_color -b magenta)
    set -l b_cyan (set_color -b cyan)
    set -l b_white (set_color -b white)

    # カラー確認
    #printf '%s%s %s%s %s%s %s%s %s%s %s%s %s%s %s%s%s\n' \
    #    (set_color black) \
    #    'black' \
    #    (set_color red) \
    #    'red' \
    #    (set_color green) \
    #    'green' \
    #    (set_color yellow) \
    #    'yellow' \
    #    (set_color blue) \
    #    'blue' \
    #    (set_color magenta) \
    #    'magenta' \
    #    (set_color cyan) \
    #    'cyan' \
    #    (set_color white) \
    #    'white' \
    #    (set_color normal)
    #printf '%s%s %s%s %s%s %s%s %s%s %s%s %s%s %s%s%s\n' \
    #    (set_color brblack) \
    #    'brblack' \
    #    (set_color brred) \
    #    'brred' \
    #    (set_color brgreen) \
    #    'brgreen' \
    #    (set_color bryellow) \
    #    'bryellow' \
    #    (set_color brblue) \
    #    'brblue' \
    #    (set_color brmagenta) \
    #    'brmagenta' \
    #    (set_color brcyan) \
    #    'brcyan' \
    #    (set_color brwhite) \
    #    'brwhite' \
    #    (set_color normal)

    set -l columns (tput cols)
    #set -l border_line \
    #    (printf '%s%s%s%s%s' \
    #        $black \
    #        $b_magenta \
    #        (yes '-' | head -n $columns | tr -d '\n') \
    #        $b_normal $normal)
    set -l border_line \
        (printf '%s%s%s' \
            $cyan (yes '-' | head -n $columns | tr -d '\n') $normal)

    set -l user_and_host \
        (printf '%s%s@%s%s' $blue $USER (prompt_hostname) $normal)
    set -l home_escaped \
        (echo -n $HOME | sed 's/\//\\\\\//g')
    set -l cwd \
        (printf '%s%s%s' \
            $red \
            (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g') \
            $normal)
    set -l datetime \
        (printf '%s%s%s' $green (date +'%F %T') $normal)

    set -l git_prompt ''
    # Git リポジトリのワークツリー内部にいるかどうか
    set -l is_inside_work_tree \
        (git rev-parse --is-inside-work-tree 2>/dev/null)

    if [ -n "$is_inside_work_tree" ]
        set -l current_branch '?'

        # コミットがあるかどうか
        if git rev-parse @ >/dev/null 2>&1
            set current_branch (git rev-parse --abbrev-ref @)
        end

        if [ "$current_branch" != "?" ]
            # リポジトリにブランチが存在する場合
            set -l git_branch_status '🙆'
            set -l files (git status --porcelain)
            # コミットしていないものがある場合
            [ -n "$files" ] && set git_branch_status '🤔'
            set git_prompt \
                (printf '%s[%s:%s]%s' \
                    $cyan $current_branch $git_branch_status $normal)
        end
    end

    set last_cmd_status (printf '%s%d%s' $brred $last_cmd_status $normal)
    set -l symbol '$'
    [ "$USER" = 'root' ] && set symbol '#'

    printf '%s\n[%s %s:%s]\n[%s]%s[%s]%s ' \
            $border_line \
            $MY_SYMBOL \
            $user_and_host \
            $cwd $datetime \
            $git_prompt \
            $last_cmd_status \
            $symbol
end
