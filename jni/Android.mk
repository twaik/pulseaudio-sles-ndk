PROJECT_ROOT_PATH := $(call my-dir)

#PULSEAUDIO_CFLAGS := -DPULSEAUDIO_DATADIR=\"$(PULSEAUDIO_DATADIR)\" -std=gnu99

include $(call all-subdir-makefiles)
