#!/system/bin/sh
# SPECTRUM KERNEL MANAGER
# Profile initialization script by nathanchance

# If there is not a persist value, we need to set one
if [ ! -f /data/property/persist.spectrum.profile ]; then
    setprop persist.spectrum.profile 0
fi

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}

value=$(getprop persist.spectrum.profile)

# Set profile
if [[ $(getprop sys.boot_completed) -eq 1 ]]; then

    chmod 0644 /sys/module/workqueue/parameters/power_efficient
    chmod 0644 /sys/class/kgsl/kgsl-3d0/max_gpuclk
    chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
    chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/governor
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    chmod 0644 /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/governor
    chmod 0644 /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/max_freq
    chmod 0644 /sys/devices/soc/soc:qcom,cpubw/devfreq/soc:qcom,cpubw/min_freq
    chmod 0644 /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/governor
    chmod 0644 /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/max_freq
    chmod 0644 /sys/devices/soc/soc:qcom,mincpubw/devfreq/soc:qcom,mincpubw/min_freq

    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

    if [[ $value -eq 0 ]]; then
        write /sys/module/workqueue/parameters/power_efficient Y
        write /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load 90
        write /sys/devices/system/cpu/cpufreq/interactive/timer_rate 2000
        write /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq 1113600
        write /sys/devices/system/cpu/cpufreq/interactive/timer_slack 480000
        write /sys/devices/system/cpu/cpufreq/interactive/90 400457:22 480000:22 576000:21 652800:81 729600:21 806400:82 883200:21 960000:21 1036800:21 1113600:82 1248000:20 1305600:21 1401600:82 1536000:21 1689600:20 1766400:20 1804800:20 1843200:21 1958400:87
        write /sys/devices/system/cpu/cpufreq/interactive/align_windows 1
        write /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif 1
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 400457
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
    	write /proc/sys/vm/swappiness 45
    fi
fi
