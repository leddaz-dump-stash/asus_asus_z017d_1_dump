#!/system/bin/sh
app=`getprop sys.storage.bchmode`

if [ $app != "0" ]; then
	echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
	echo 0 > /sys/devices/soc/7864900.sdhci/mmc_host/mmc1/clk_scaling/enable
	echo 512 > /sys/block/dm-0/queue/read_ahead_kb
	echo 512 > /sys/block/dm-1/queue/read_ahead_kb
else
	echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
	echo 1 > /sys/devices/soc/7864900.sdhci/mmc_host/mmc1/clk_scaling/enable
	echo 128 > /sys/block/dm-0/queue/read_ahead_kb
	echo 128 > /sys/block/dm-1/queue/read_ahead_kb
fi
