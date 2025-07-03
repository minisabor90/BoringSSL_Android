LOCAL_PATH := $(call my-dir)

include $(LOCAL_PATH)/sources.mk

LOCAL_PATH := $(call my-dir)

include $(LOCAL_PATH)/sources.mk

# Build crypto static library
include $(CLEAR_VARS)
LOCAL_MODULE            := crypto_static
LOCAL_SRC_FILES         := $(crypto_sources) $(crypto_sources_asm)
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/src/crypto $(LOCAL_PATH)/src/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/src/include

# Essential BoringSSL flags
LOCAL_CFLAGS            := -DBORINGSSL_IMPLEMENTATION -DOPENSSL_NO_THREADS
LOCAL_CPPFLAGS          := -std=c++11

# Architecture-specific assembly optimizations
ifeq ($(TARGET_ARCH),arm)
  LOCAL_CFLAGS += -DOPENSSL_ARM
endif
ifeq ($(TARGET_ARCH),arm64)
  LOCAL_CFLAGS += -DOPENSSL_AARCH64
endif
ifeq ($(TARGET_ARCH),x86)
  LOCAL_CFLAGS += -DOPENSSL_X86
endif
ifeq ($(TARGET_ARCH),x86_64)
  LOCAL_CFLAGS += -DOPENSSL_X86_64
endif

include $(BUILD_STATIC_LIBRARY)

# Build SSL static library
include $(CLEAR_VARS)
LOCAL_MODULE            := ssl_static
LOCAL_SRC_FILES         := $(ssl_sources)
LOCAL_C_INCLUDES        := $(LOCAL_PATH)/src/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/src/include
LOCAL_STATIC_LIBRARIES  := crypto_static

# Essential BoringSSL flags
LOCAL_CFLAGS            := -DBORINGSSL_IMPLEMENTATION -DOPENSSL_NO_THREADS
LOCAL_CPPFLAGS          := -std=c++11

include $(BUILD_STATIC_LIBRARY)