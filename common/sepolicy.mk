#
# This policy configuration will be used by all products that
# inherit from Octavi
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
ifeq ($(TARGET_HAS_FUSEBLK_SEPOLICY_ON_VENDOR),true)
BOARD_SEPOLICY_M4DEFS += board_excludes_fuseblk_sepolicy=true
endif
endif

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/octavi/sepolicy/common/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/octavi/sepolicy/common/private

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/octavi/sepolicy/common/dynamic \
    device/octavi/sepolicy/common/system
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/octavi/sepolicy/common/dynamic \
    device/octavi/sepolicy/common/vendor
endif

# Selectively include legacy rules defined by the products
-include device/octavi/sepolicy/legacy-common/sepolicy.mk
