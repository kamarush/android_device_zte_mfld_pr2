DEVICE_FOLDER := device/zte/mfld_pr2

## (2) Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/zte/mfld_pr2/mfld_pr2-vendor.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Files needed for boot image
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/ramdisk/init.zte.factory.rc:root/init.zte.factory.rc \
    $(DEVICE_FOLDER)/ramdisk/init.mfld_pr2.rc:root/init.mfld_pr2.rc \
	$(DEVICE_FOLDER)/ramdisk/init.factory.mfld_pr2.rc:root/init.factory.mfld_pr2.rc \
    $(DEVICE_FOLDER)/ramdisk/init.sdcard.rc:root/init.sdcard.rc \
    $(DEVICE_FOLDER)/ramdisk/init.sdcard1.rc:root/init.sdcard1.rc \
    $(DEVICE_FOLDER)/ramdisk/init.sdcard2.rc:root/init.sdcard2.rc \
    $(DEVICE_FOLDER)/ramdisk/init.wifi.rc:root/init.wifi.rc \
    $(DEVICE_FOLDER)/ramdisk/init.nfs.rc:root/init.nfs.rc \
    $(DEVICE_FOLDER)/ramdisk/ueventd.mfld_pr2.rc:root/ueventd.mfld_pr2.rc \
    $(DEVICE_FOLDER)/ramdisk/android.fstab:root/android.fstab

PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/idc/mxt224_touchscreen_0.idc:system/usr/idc/mxt224_touchscreen_0.idc

PRODUCT_PACKAGES += \
    apache-harmony-tests \
    bd_prov \
    bthelp \
    btcmd \
    depmod \
    dhcp6c \
    jcifs-1.3.16 \
    libglib-2.0 \
    libgmodule-2.0 \
    libgobject-2.0 \
    libgthread-2.0 \
    libpsb_drm \
    libmemrar \
    libwbxmlparser \
    libz \
    pack_intel \
    uim \
    unpack_intel

# Audio
PRODUCT_PACKAGES += \
    alsa.mfld_pr2 \
    audio.a2dp.default \
    audio.usb.default \
    audio_policy.mfld_pr2 \
    audio.primary.mfld_pr2 \
    libasound \


# NFC Support
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab \
	$(LOCAL_PATH)/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/blobs/watchdogd:recovery/root/sbin/watchdogd \

# Inherit dalvik configuration and the rest of the platform
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
$(call inherit-product,$(SRC_TARGET_DIR)/product/generic_x86.mk)
$(call inherit-product, build/target/product/full_base_telephony.mk)
