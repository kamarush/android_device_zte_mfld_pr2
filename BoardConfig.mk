TARGET_SPECIFIC_HEADER_PATH := hardware/intel/include

include $(GENERIC_X86_CONFIG_MK)

# Board configuration
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := mfld_pr2
TARGET_CPU_ABI := x86
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := x86
TARGET_ARCH_VARIANT := x86-atom
TARGET_BOARD_PLATFORM := atom
TARGET_CPU_SMP := true

# Blutetooth
BOARD_HAVE_BLUETOOTH=true

# NFC
BOARD_HAVE_NFC := true

# Audio
BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true

# Graphics
BOARD_EGL_CFG := device/zte/gxi/prebuilt/egl.cfg

# Wi-Fi

WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P := "/vendor/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_AP := "/vendor/firmware/fw_bcmdhd_apsta.bin"


# Use boot tools to make Intel-formatted images
DEVICE_BASE_BOOT_IMAGE := device/zte/gxi/blobs/boot.image
DEVICE_BASE_RECOVERY_IMAGE := device/zte/gxi/blobs/recovery.image
BOARD_CUSTOM_BOOTIMG_MK := device/zte/gxi/pack-repack_tool/boot.mk

# Recovery configuration
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/zte/gxi/recovery_keys.c
BOARD_HAS_NO_SELECT_BUTTON := true

# This is deprecated and will be dropped
TARGET_PREBUILT_KERNEL := device/zte/gxi/blobs/kernel

BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 805306368
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1730150400
BOARD_FLASH_BLOCK_SIZE := 4096
