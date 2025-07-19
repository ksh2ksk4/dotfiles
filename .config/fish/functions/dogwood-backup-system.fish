function dogwood-backup-system -d "Backup system data and upload to the pCloud"
    set -l pcloud 'pCloud:/Backups/dogwood'
    set -l now $(date '+%Y%m%d_%H%M%S')
    set -l backup_file ~/tmp/system-{$now}.tar.gz

    cd /

    sudo tar cvzf $backup_file etc root usr var
    rclone move $backup_file $pcloud --multi-thread-streams 1

    #rclone --min-age 30d lsf $pcloud
    #rclone --min-age 30d --dry-run delete $pcloud
    rclone --min-age 30d delete $pcloud
end
