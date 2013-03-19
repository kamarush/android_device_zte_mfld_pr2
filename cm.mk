# Boot animation
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 540

# Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit enhanced nfc config 
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Inherit device configuration
$(call inherit-product, device/zte/mfld_pr2/full_gxi.mk)

DEVICE_PACKAGE_OVERLAYS += device/zte/mfld_pr2/overlay

#
# Setup device specific product configuration.
#
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_DEVICE := mfld_pr2
PRODUCT_NAME := cm_mfld_pr2
PRODUCT_BRAND := ZTE
PRODUCT_MODEL := P940
PRODUCT_MANUFACTURER := ZTE
PRODUCT_RELEASE_NAME := Grand X In

#Set build fingerprint / ID / Product Name etc.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=mfld_pr2 BUILD_FINGERPRINT="ZTE/mfld_pr2/mfld_pr2:4.0.4/GXI_THUV1.0.0B04/eng.ztetd.20120929.195416:user/release-keys" PRIVATE_BUILD_DESC="mfld_pr2-user 4.0.4 GXI_THUV1.0.0B04 eng.ztetd.20120929.195416 release-keys"

# Release name and versioning
PRODUCT_RELEASE_NAME := GXI
