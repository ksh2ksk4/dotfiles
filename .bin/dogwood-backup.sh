#!/usr/bin/env zsh

set -euo pipefail

backup_home() {
    # Backup /home data and upload to the pCloud

    local pcloud='pCloud:/Backups/dogwood/home'
    local now="$(date '+%Y%m%d_%H%M%S')"
    local other_backup_file="${HOME}/tmp/home-other-${now}.tar.gz"
    local share_backup_file="${HOME}/tmp/home-share-${now}.tar.gz"

    cd "${HOME}"

    fd -H -I -F '.DS_Store' -tf -X rm
    fd -H -I -g '._*' -tf -X rm

    tar cvzf "${other_backup_file}" .config .local .ssh
    rclone move "${other_backup_file}" "${pcloud}" --multi-thread-streams 1

    tar cvzf "${share_backup_file}" \
        --exclude='share/SecondaryData' \
        --exclude='share/astro/dist' \
        --exclude='share/*/node_modules' \
        --exclude='share/*/target/debug' \
        --exclude='share/*/target/doc' \
        --exclude='share/*/target/release' \
        share
    rclone move "${share_backup_file}" "${pcloud}" --multi-thread-streams 1

    #rclone --min-age 30d lsf "${pcloud}"
    #rclone --min-age 30d --dry-run delete "${pcloud}"
    rclone --min-age 30d delete "${pcloud}"

    return 0
}

backup_system() {
    # Backup system data and upload to the pCloud

    local pcloud='pCloud:/Backups/dogwood/system'
    local now="$(date '+%Y%m%d_%H%M%S')"
    local backup_file="${HOME}/tmp/system-${now}.tar.gz"

    cd /

    sudo tar cvzf "${backup_file}" \
        --exclude='var/cache' \
        --exclude='var/empty' \
        --exclude='var/games' \
        --exclude='var/local' \
        --exclude='var/log' \
        --exclude='var/tmp' \
        etc root usr var
    rclone move "${backup_file}" "${pcloud}" --multi-thread-streams 1

    #rclone --min-age 30d lsf "${pcloud}"
    #rclone --min-age 30d --dry-run delete "${pcloud}"
    rclone --min-age 30d delete "${pcloud}"

    return 0
}

backup_home
backup_system
