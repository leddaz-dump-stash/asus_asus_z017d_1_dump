#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:18750716:a4816821d55271fb2a8c0625dacd18a5a7971646; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:14941432:10e94a097b4f3d79d42172ec03589406eb522a25 EMMC:/dev/block/bootdevice/by-name/recovery a4816821d55271fb2a8c0625dacd18a5a7971646 18750716 10e94a097b4f3d79d42172ec03589406eb522a25:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
