APP_PLATFORM := android-19
APP_ABI := armeabi-v7a
APP_PIE := true

#APP_MODULES := libltdl
APP_MODULES := \
	pulseaudio \
	module-sles-sink \
	module-native-protocol-tcp
