function dogwood-umount-all -d "Umount all LUKS disks"
    sudo systemctl restart nfs-server

    sudo umount /mnt/luks-disk-a
    sudo umount /mnt/luks-disk-b
    sudo umount /mnt/luks-disk-c
    sudo umount /mnt/luks-disk-d
    sudo cryptsetup --type luks2 close luks-disk-a
    sudo cryptsetup --type luks2 close luks-disk-b
    sudo cryptsetup --type luks2 close luks-disk-c
    sudo cryptsetup --type luks2 close luks-disk-d
end
