function dogwood-backup-home -d "Backup /home data and upload to the pCloud"
    set -l pcloud 'pCloud:/Backups/dogwood'
    set -l now $(date '+%Y%m%d_%H%M%S')
    set -l other_backup_file ~/tmp/home-other-{$now}.tar.gz
    set -l share_backup_file ~/tmp/home-share-{$now}.tar.gz

    cd

    tar cvzf $other_backup_file .config .local .ssh fossils
    rclone move $other_backup_file $pcloud --multi-thread-streams 1

    tar cvzf $share_backup_file share
    #tar cvzf $share_backup_file --exclude='share' .
    rclone move $share_backup_file $pcloud --multi-thread-streams 1

    #rclone --min-age 30d lsf $pcloud
    #rclone --min-age 30d --dry-run delete $pcloud
    rclone --min-age 30d delete $pcloud
end
