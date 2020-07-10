#!/system/bin/sh
#
# Copyright (C) 2020 The Intelli Kernel Project. All rights reserved.
#
# Intelli Kernel Boot Script
# Author: Samuel Pascua <sgpascua@ngcp.ph>
# Author: SmgKhOaRn <smgkhoarn@gmail.com>
# 
# Huge Thanks to jprimero15, sultanxda and justjr @ xda-developers.com
#
# This script is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation,
# and may be copied, distributed, and modified under those terms.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#

chmod 755 /sbin/sswap
chmod 755 /sbin/busybox

# VNSwap
/sbin/sswap -s -r
sysctl -w vm.swappiness=130

# LMK
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

# SafetyNet
chmod 640 /sys/fs/selinux/enforce;
chmod 440 /sys/fs/selinux/policy;

# Set SmartDim
echo '1' > /sys/class/graphics/fb0/smart_dim

# Set I/O scheduler & entropy
setprop sys.io.scheduler cfq;
echo "0" > /sys/block/mmcblk0/queue/iostats;
echo "1024" > /sys/block/mmcblk0/queue/read_ahead_kb;
echo "0" > /sys/block/mmcblk1/queue/iostats;
echo "2048" > /sys/block/mmcblk1/queue/read_ahead_kb;
echo "256" > /proc/sys/kernel/random/read_wakeup_threshold;
echo "320" > /proc/sys/kernel/random/write_wakeup_threshold;

# Set CPU governor & freq
echo '2265600' > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq;
echo '2265600' > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq;
echo '2265600' > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq;
echo '2265600' > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq;
echo 'intelliactive' > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor;
echo 'intelliactive' > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor;
echo 'intelliactive' > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor;
echo 'intelliactive' > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor;

# Set CPU governor tweaks
echo '20000 1190400:60000 1728000:74000 1958400:80000 2265600:105000' > /sys/devices/system/cpu/cpufreq/intelliactive/above_hispeed_delay;
echo '98 422400:34 652800:41 729600:12 883200:52 960000:9 1036800:8 1190400:73 1267200:6 1497600:87 1574400:5 1728000:89 1958400:91 2265600:94' > /sys/devices/system/cpu/cpufreq/intelliactive/target_loads;

# Applying finished
echo "Intelli-Kernel: Boot script executed sucesfully." | tee /dev/kmsg;
