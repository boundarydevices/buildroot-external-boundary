################################################################################
#
# bdsdmac_firmware
#
################################################################################

BDSDMAC_FIRMWARE_VERSION = 18922f5df1e005865cda2d37cb4f4a81ae1bd886
BDSDMAC_FIRMWARE_SITE = ssh://git@linode.boundarydevices.com/qca-firmware.git
BDSDMAC_FIRMWARE_SITE_METHOD = git
BDSDMAC_FIRMWARE_LICENSE = Firmware-QCA

define BDSDMAC_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
