#!/bin/sh
adb root
adb shell mount -o remount,rw /
adb shell rm -rf /pulse /armeabi-v7a
adb push pa.conf /
adb push libs/armeabi-v7a /
adb shell mkdir /pulse

adb shell HOME=/pulse TMPDIR=/pulse LD_LIBRARY_PATH=/armeabi-v7a \
/armeabi-v7a/pulseaudio --disable-shm=true -n -F /pa.conf --daemonize=false --use-pid-file=false --log-target=stderr --log-level=4 --system=false --dl-search-path=/armeabi-v7a
