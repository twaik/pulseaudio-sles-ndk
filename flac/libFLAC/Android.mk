LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	bitmath.c \
	bitreader.c \
	bitwriter.c \
	cpu.c \
	crc.c \
	fixed.c \
	float.c \
	format.c \
	lpc.c \
	memory.c \
	metadata_object.c \
	md5.c \
	stream_decoder.c \
	stream_encoder.c \
	stream_encoder_framing.c \
	window.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/.. \
	$(LOCAL_PATH)/../include

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

LOCAL_CFLAGS += -DHAVE_CONFIG_H -DFLAC__NO_MD5 -DFLAC__INTEGER_ONLY_LIBRARY
LOCAL_CFLAGS += -D_REENTRANT -DPIC -DU_COMMON_IMPLEMENTATION -fPIC
LOCAL_CFLAGS += -O3 -funroll-loops -finline-functions

LOCAL_ARM_MODE := arm

LOCAL_MODULE := libFLAC_pulse

LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_LIBRARY)
