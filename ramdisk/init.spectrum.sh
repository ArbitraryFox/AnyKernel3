#!/system/bin/sh
# SPECTRUM KERNEL MANAGER
# Profile initialization script by nathanchance

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}

value=$(getprop persist.spectrum.profile)

# Set profile
if [[ $(getprop sys.boot_completed) -eq 1 ]]; then

    chmod 0644 /sys/module/workqueue/parameters/power_efficient
    chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/max_pwrlvl
    chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/min_pwrlvl
    chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/governor
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    chmod 0644 /sys/block/zram0/comp_algorithm
    chmod 0644 /sys/block/zram0/max_comp_streams
    chmod 0644 /sys/block/zram0/disksize

    echo "lz4" > /sys/block/zram0/comp_algorithm
    echo 8 > /sys/block/zram0/max_comp_streams
    echo 536870912 > /sys/block/zram0/disksize
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

    if [[ $value -eq 0 ]]; then
    	write /sys/devices/platform/kcal_ctrl.0/kcal_sat 273
    	write /sys/devices/platform/kcal_ctrl.0/kcal_val 263
    	write /sys/devices/platform/kcal_ctrl.0/kcal_cont 261
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 0
    	write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 6
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 400457
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    	write /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay 0
    	write /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load 90
    	write /sys/devices/system/cpu/cpufreq/interactive/timer_rate 20000
    	write /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq 1113600
    	write /sys/devices/system/cpu/cpufreq/interactive/timer_slack 480000
    	write /sys/devices/system/cpu/cpufreq/interactive/target_loads "90 400457:22 480000:22 576000:21 652800:81 729600:21 806400:82 883200:21 960000:21 1036800:21 1113600:82 1248000:20 1305600:21 1401600:82 1536000:21 1689600:20 1766400:20 1804800:20 1843200:21 1958400:87"
    	write /sys/devices/system/cpu/cpufreq/interactive/align_windows 1
    	write /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif 1
    	write /proc/sys/vm/swappiness 45
    elif [[ $value -eq 1 ]]; then
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 0
    	write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 4
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652800
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    	write /sys/devices/system/cpu/cpufreq/interactive/target_loads "90 652800:81 729600:21 806400:82 883200:21 960000:21 1036800:21 1113600:82 1248000:20 1305600:21 1401600:82 1536000:21 1689600:20 1766400:20 1804800:20 1843200:21 1958400:87"
    elif [[ $value -eq 2 ]]; then
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 4
    	write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 6
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1401600
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 400457
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "conservative"
    	write /sys/devices/system/cpu/cpufreq/conservative/up_threshold 95
    	write /sys/devices/system/cpu/cpufreq/conservative/down_threshold 35
    else [[ $value -eq 3 ]];
    	write /sys/module/workqueue/parameters/power_efficient N
    	write /sys/class/kgsl/kgsl-3d0/max_pwrlevel 0
    	write /sys/class/kgsl/kgsl-3d0/min_pwrlevel 4
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 806400
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    	write /sys/devices/system/cpu/cpufreq/interactive/target_loads "90 806400:82 883200:21 960000:21 1036800:21 1113600:82 1248000:20 1305600:21 1401600:82 1536000:21 1689600:20 1766400:20 1804800:20 1843200:21 1958400:87"
    fi
fi
