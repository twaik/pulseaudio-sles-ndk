#!/bin/sh
adb root
adb shell mount -o remount,rw /
adb shell rm -rf /pulse /usr
adb push out-arm/usr /usr
adb push android-pulseaudio.conf /

adb shell HOME=/pulse TMPDIR=/pulse LD_LIBRARY_PATH=/usr/lib:/usr/lib/pulseaudio/:/usr/lib/pulse-11.1/modules/ \
/usr/bin/pulseaudio --disable-shm=true -n -F /android-pulseaudio.conf --daemonize=false --use-pid-file=false --log-target=stderr --log-level=debug --system=false --dl-search-path=/usr/lib/pulse-11.1/modules/
