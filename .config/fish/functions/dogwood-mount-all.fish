function dogwood-mount-all -d "Mount all LUKS disks"
    sudo cryptsetup --type luks2 open UUID=60725da9-161c-47ff-9942-097ab234be23 luks-disk-d
    sudo cryptsetup --type luks2 open UUID=d817ea97-0757-4f1f-be09-68b83eaaf823 luks-disk-c
    sudo cryptsetup --type luks2 open UUID=e3e5ab63-79aa-4666-a67d-dc87b86db2eb luks-disk-b
    sudo cryptsetup --type luks2 open UUID=4396cc8e-0c48-4730-bfd5-a4fbb09634ae luks-disk-a
    sudo mount /mnt/luks-disk-a
    sudo mount /mnt/luks-disk-b
    sudo mount /mnt/luks-disk-c
    sudo mount /mnt/luks-disk-d

    sudo systemctl restart nfs-server

    sudo hdparm -S 60 /dev/sdb
    sudo hdparm -S 60 /dev/sdc
    sudo hdparm -S 60 /dev/sdd
    sudo hdparm -S 12 /dev/sde
end
