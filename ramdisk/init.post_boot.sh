#!/system/bin/sh

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}

android=$(getprop ro.build.version.sdk)
value="persist.spectrum.profile"

if [[ $android -ge 28 ]]; then
    if (! (grep -q $value /data/property/persistent_properties)); then
        setprop persist.spectrum.profile 0
    fi
else
    if [ ! -f /data/property/persist.spectrum.profile ]; then
        setprop persist.spectrum.profile 0
    fi
fi

# Set memory parameters
chmod 0644 /sys/block/zram0/disksize

swapoff /dev/block/zram0
echo 1 > /sys/block/zram0/reset
echo 0 > /proc/sys/vm/page-cluster
echo "lz4" > /sys/block/zram0/comp_algorithm
echo 1610612736 > /sys/block/zram0/disksize
echo 8 > /sys/block/zram0/max_comp_streams
mkswap /dev/block/zram0
swapon /dev/block/zram0 -p 32758

# Set CFQ I/O scheduler
write /sys/block/mmcblk0/queue/scheduler cfq
write /sys/block/mmcblk1/queue/scheduler cfq

# Set read ahead to 128kB for internal and 512kB for external storage
write /sys/block/mmcblk0/queue/read_ahead_kb 128
write /sys/block/mmcblk1/queue/read_ahead_kb 512

# Disable slice_idle
write /sys/block/mmcblk0/queue/iosched/slice_idle 0
