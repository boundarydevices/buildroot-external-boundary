################################################################################
#
# bdsdmac_firmware
#
################################################################################

BDSDMAC_FIRMWARE_VERSION = ac58684b47af5e97bd9a9f839aa97dcf200acc6f
BDSDMAC_FIRMWARE_SITE = \
       $(call github,boundarydevices,qca-firmware,$(BDSDMAC_FIRMWARE_VERSION))
BDSDMAC_FIRMWARE_LICENSE = Firmware-QCA
BDSDMAC_FIRMWARE_LICENSE_FILES = LICENSE.qca_firmware

define BDSDMAC_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
