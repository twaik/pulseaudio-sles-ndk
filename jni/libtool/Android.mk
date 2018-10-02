LOCAL_PATH := $(call my-dir)

LOCAL_MODULE := libltdl
LOCAL_MODULE_FILENAME := libltdl
LOCAL_CFLAGS := -DLTDL=1 -DLTDLOPEN=_PROGRAM_ -DLT_DEBUG_LOADERS
LOCAL_SRC_FILES := \
	libltdl/loaders/dlopen.c \
	libltdl/loaders/preopen.c \
	libltdl/lt__alloc.c \
	libltdl/lt__argz.c \
	libltdl/lt_dlloader.c \
	libltdl/lt_error.c \
	libltdl/ltdl.c \
	libltdl/slist.c

LOCAL_C_INCLUDES := $(LOCAL_PATH) $(LOCAL_PATH)/libltdl $(LOCAL_PATH)/libltdl/libltdl
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/libltdl

include $(BUILD_STATIC_LIBRARY)
