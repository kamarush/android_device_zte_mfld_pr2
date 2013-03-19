LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES := pack.c
LOCAL_CFLAGS += -I. -I/usr/include/ -static -m32 -Wall -Wextra -pedantic -std=c99 -D_BSD_SOURCE
LOCAL_MODULE := pack_intel
LOCAL_MODULE_TAGS := optional
include $(BUILD_HOST_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := eng
LOCAL_SRC_FILES := unpack.c
LOCAL_CFLAGS += -I. -I/usr/include/ -static -m32 -Wall -Wextra -pedantic -std=c99 -D_BSD_SOURCE
LOCAL_MODULE := unpack_intel
LOCAL_MODULE_TAGS := optional
include $(BUILD_HOST_EXECUTABLE)
