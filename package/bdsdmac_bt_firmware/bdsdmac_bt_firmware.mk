################################################################################
#
# bdsdmac_bt_firmware
#
################################################################################

BDSDMAC_BT_FIRMWARE_VERSION = d9a2aef408ff9cf94e4afc89db0622a5bec57410
BDSDMAC_BT_FIRMWARE_SITE = ssh://git@linode.boundarydevices.com/qca-firmware.git
BDSDMAC_BT_FIRMWARE_SITE_METHOD = git
BDSDMAC_BT_FIRMWARE_LICENSE = Firmware-QCA
BDSDMAC_BT_FIRMWARE_LICENSE_FILES = LICENSE.qca_firmware

define BDSDMAC_BT_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
