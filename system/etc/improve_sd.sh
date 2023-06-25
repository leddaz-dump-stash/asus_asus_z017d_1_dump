#!/system/bin/sh
nr_requests="/sys/block/mmcblk1/queue/nr_requests"
read_ahead_kb="/sys/block/mmcblk1/queue/read_ahead_kb"

echo 512 > $nr_requests
echo 512 > $read_ahead_kb
