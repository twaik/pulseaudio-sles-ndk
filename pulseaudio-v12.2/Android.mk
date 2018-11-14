PULSEAUDIO_PATH := $(call my-dir)

PULSEAUDIO_DATADIR ?= /system/etc/pulse
PULSE_CFLAGS := -std=gnu11 -DHAVE_CONFIG_H -DPA_BUILDDIR=\"$(PULSEAUDIO_PATH)\" -DPULSEAUDIO_DATADIR=\"$(PULSEAUDIO_DATADIR)\"

LOCAL_PATH := $(PULSEAUDIO_PATH)/src

include $(CLEAR_VARS)
LOCAL_MODULE := libpulsecommon
LOCAL_CFLAGS := $(PULSE_CFLAGS) -D__INCLUDED_FROM_PULSE_AUDIO
LOCAL_CXXFLAGS := -std=c++11

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -DHAVE_ARMV6=1
endif

LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES := \
		pulse/client-conf.c \
		pulse/fork-detect.c \
		pulse/format.c \
		pulse/json.c \
		pulse/xmalloc.c \
		pulse/proplist.c \
		pulse/utf8.c \
		pulse/channelmap.c \
		pulse/sample.c \
		pulse/util.c \
		pulse/timeval.c \
		pulse/rtclock.c \
		pulse/volume.c \
		pulsecore/authkey.c \
		pulsecore/conf-parser.c \
		pulsecore/core-error.c \
		pulsecore/core-format.c \
		pulsecore/core-rtclock.c \
		pulsecore/core-util.c \
		pulsecore/dynarray.c \
		pulsecore/fdsem.c \
		pulsecore/flist.c \
		pulsecore/g711.c \
		pulsecore/hashmap.c \
		pulsecore/i18n.c \
		pulsecore/idxset.c \
		pulsecore/arpa-inet.c \
		pulsecore/iochannel.c \
		pulsecore/ioline.c \
		pulsecore/ipacl.c \
		pulsecore/lock-autospawn.c \
		pulsecore/log.c \
		pulsecore/ratelimit.c \
		pulsecore/mcalign.c \
		pulsecore/memblock.c \
		pulsecore/memblockq.c \
		pulsecore/memchunk.c \
		pulsecore/native-common.c \
		pulsecore/once.c \
		pulsecore/packet.c \
		pulsecore/parseaddr.c \
		pulsecore/pdispatch.c \
		pulsecore/pid.c \
		pulsecore/pipe.c \
		pulsecore/memtrap.c \
		pulsecore/aupdate.c \
		pulsecore/proplist-util.c \
		pulsecore/pstream-util.c \
		pulsecore/pstream.c \
		pulsecore/queue.c \
		pulsecore/random.c \
		pulsecore/srbchannel.c \
		pulsecore/sample-util.c \
		pulsecore/shm.c \
		pulsecore/bitset.c \
		pulsecore/socket-client.c \
		pulsecore/socket-server.c \
		pulsecore/socket-util.c \
		pulsecore/strbuf.c \
		pulsecore/strlist.c \
		pulsecore/svolume_c.c pulsecore/svolume_arm.c \
		pulsecore/svolume_mmx.c pulsecore/svolume_sse.c \
		pulsecore/tagstruct.c \
		pulsecore/time-smoother.c \
		pulsecore/tokenizer.c \
		pulsecore/usergroup.c \
		pulsecore/sndfile-util.c \
		pulsecore/modinfo.c \
		pulsecore/sioman.c
LOCAL_SRC_FILES += \
		pulsecore/mutex-posix.c \
		pulsecore/semaphore-posix.c \
		pulsecore/thread-posix.c

LOCAL_STATIC_LIBRARIES := libsndfile_pulse libogg_pulse libltdl_pulse
LOCAL_ALLOW_UNDEFINED_SYMBOLS := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libpulsecore
LOCAL_CFLAGS := $(PULSE_CFLAGS) -D__INCLUDED_FROM_PULSE_AUDIO
LOCAL_CXXFLAGS := -std=c++11

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -DHAVE_ARMV6=1
endif

LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES :=\
		pulsecore/filter/lfe-filter.c \
		pulsecore/filter/biquad.c \
		pulsecore/filter/crossover.c \
		pulsecore/asyncmsgq.c \
		pulsecore/asyncq.c \
		pulsecore/auth-cookie.c \
		pulsecore/cli-command.c \
		pulsecore/cli-text.c \
		pulsecore/client.c \
		pulsecore/card.c \
		pulsecore/core-scache.c \
		pulsecore/core-subscribe.c \
		pulsecore/core.c \
		pulsecore/hook-list.c \
		pulsecore/ltdl-helper.c \
		pulsecore/modargs.c \
		pulsecore/modinfo.c \
		pulsecore/module.c \
		pulsecore/msgobject.c \
		pulsecore/namereg.c \
		pulsecore/object.c \
		pulsecore/play-memblockq.c \
		pulsecore/play-memchunk.c \
		pulsecore/remap.c \
		pulsecore/remap_mmx.c pulsecore/remap_sse.c \
		pulsecore/resampler.c \
		pulsecore/resampler/ffmpeg.c pulsecore/resampler/peaks.c \
		pulsecore/resampler/trivial.c \
		pulsecore/rtpoll.c \
		pulsecore/stream-util.c \
		pulsecore/mix.c \
		pulsecore/cpu.c \
		pulsecore/cpu-arm.c \
		pulsecore/cpu-x86.c \
		pulsecore/cpu-orc.c \
		pulsecore/sconv-s16be.c \
		pulsecore/sconv-s16le.c \
		pulsecore/sconv_sse.c \
		pulsecore/sconv.c \
		pulsecore/shared.c \
		pulsecore/sink-input.c \
		pulsecore/sink.c \
		pulsecore/device-port.c \
		pulsecore/sioman.c \
		pulsecore/sound-file-stream.c \
		pulsecore/sound-file.c \
		pulsecore/source-output.c  \
		pulsecore/source.c  \
		pulsecore/start-child.c \
		pulsecore/thread-mq.c \
		pulsecore/ffmpeg/resample2.c \
		pulsecore/protocol-native.c

LOCAL_STATIC_LIBRARIES := libsndfile_pulse libogg_pulse libltdl_pulse
LOCAL_SHARED_LIBRARIES := libpulsecommon
LOCAL_ALLOW_UNDEFINED_SYMBOLS := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libpulse
LOCAL_CFLAGS := $(PULSE_CFLAGS)
LOCAL_CXXFLAGS := -std=c++11

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -DHAVE_ARMV6=1
endif

LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES := \
		pulse/channelmap.c \
		pulse/context.c \
		pulse/direction.c \
		pulse/error.c \
		pulse/ext-device-manager.c \
		pulse/ext-device-restore.c \
		pulse/ext-stream-restore.c \
		pulse/introspect.c \
		pulse/mainloop-api.c \
		pulse/mainloop-signal.c \
		pulse/mainloop.c \
		pulse/operation.c \
		pulse/proplist.c \
		pulse/rtclock.c \
		pulse/sample.c \
		pulse/scache.c \
		pulse/stream.c \
		pulse/subscribe.c \
		pulse/thread-mainloop.c \
		pulse/timeval.c \
		pulse/utf8.c \
		pulse/util.c \
		pulse/volume.c \
		pulse/xmalloc.c

LOCAL_STATIC_LIBRARIES := 
LOCAL_SHARED_LIBRARIES := libpulsecommon
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := pulseaudio
LOCAL_CFLAGS := $(PULSE_CFLAGS)
LOCAL_CXXFLAGS := -std=c++11

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -DHAVE_ARMV6=1
endif

LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES := \
		daemon/caps.c \
		daemon/cmdline.c \
		daemon/cpulimit.c \
		daemon/daemon-conf.c \
		daemon/dumpmodules.c \
		daemon/ltdl-bind-now.c \
		daemon/main.c \
		preloaded_symbols.c

LOCAL_STATIC_LIBRARIES := libltdl_pulse
LOCAL_SHARED_LIBRARIES := libpulse  libpulsecore libpulsecommon
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE := pacat
LOCAL_CFLAGS := $(PULSE_CFLAGS)
LOCAL_CXXFLAGS := -std=c++11
LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES := utils/pacat.c

LOCAL_SHARED_LIBRARIES := libpulse libpulsecore libpulsecommon
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := module-sles-sink
LOCAL_MODULE_FILENAME := $(LOCAL_MODULE)
LOCAL_CFLAGS := $(PULSE_CFLAGS)
LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES := modules/$(LOCAL_MODULE).c
LOCAL_STATIC_LIBRARIES := libltdl_pulse
LOCAL_SHARED_LIBRARIES := libpulsecore libpulsecommon libpulse
LOCAL_LDFLAGS := -lOpenSLES
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := module-native-protocol-tcp
LOCAL_MODULE_FILENAME := $(LOCAL_MODULE)
LOCAL_CFLAGS := $(PULSE_CFLAGS) -DUSE_TCP_SOCKETS -DUSE_PROTOCOL_NATIVE -DPA_MODULE_NAME=module_native_protocol_tcp
LOCAL_C_INCLUDES := $(PULSEAUDIO_PATH) $(LOCAL_PATH)
LOCAL_SRC_FILES := modules/module-protocol-stub.c
LOCAL_STATIC_LIBRARIES := libltdl_pulse
LOCAL_SHARED_LIBRARIES := libpulsecore libpulsecommon libpulse
include $(BUILD_SHARED_LIBRARY)
