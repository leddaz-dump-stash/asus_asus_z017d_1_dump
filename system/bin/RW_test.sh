#!/system/bin/sh

k=1
i=1

export test_file="/data/media/0/1G_test_file.tmp"
export log_file="/data/media/0/RW_test.log"
export SIZE=`cat /data/data/emmc_total_size`

echo "======= Start RW test =======" | tee -a $log_file
echo "Device is $SIZE G" | tee -a $log_file
chmod 775 $log_file

if [ ${SIZE} -eq 16 ]; then
	export LIMIT=90
else
	export LIMIT=95
fi
echo "Limit is $LIMIT %" | tee -a $log_file

# Delet all test file
rm "$test_file"_*

echo "Create test file" | tee -a $log_file
dd if=/dev/block/bootdevice/by-name/system count=2097152 of=/data/media/0/1G_test_file.tmp

HEALTH=`cat cat proc/emmc_health`
echo "eMMC health : $HEALTH" | tee -a $log_file

while [ ${k} -ge 1 ]
do
	used=$(busybox df -P /data/ | grep dev | busybox awk '{ print $5}' | cut -d'%' -f1)
	if [ ${used} -ge ${LIMIT} ]; then

		echo "Start fsync!!!"
		sync

		echo "Fill up Stotage $i times, used $used %" | tee -a $log_file

		# HEALTH=`cat cat proc/emmc_health`
		# echo "eMMC health : $HEALTH" | tee -a $log_file

		rm "$test_file"_*
		i=$(($i+1))
	fi

	cp $test_file "$test_file"_$k

	k=$(($k+1))
done
