################################################################################
#
# bdsdmac_firmware
#
################################################################################

BDSDMAC_FIRMWARE_VERSION = 7c849ee87c9b523820e25c3f6a8f3ecbd3b0fbe7
BDSDMAC_FIRMWARE_SITE = \
       $(call github,boundarydevices,qca-firmware,$(BDSDMAC_FIRMWARE_VERSION))
BDSDMAC_FIRMWARE_LICENSE = Firmware-QCA
BDSDMAC_FIRMWARE_LICENSE_FILES = LICENSE.qca_firmware

define BDSDMAC_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
