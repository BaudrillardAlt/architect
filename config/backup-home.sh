mount /dev/disk/by-label/linux-usb /mnt/usb
rsync -aAXHv --info=progress2 /home/ /mnt/usb/home-backup-$(date +%Y%m%d)/
