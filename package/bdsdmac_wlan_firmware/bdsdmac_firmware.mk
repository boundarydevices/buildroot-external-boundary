################################################################################
#
# bdsdmac_wlan_firmware
#
################################################################################

BDSDMAC_WLAN_FIRMWARE_VERSION = a74776992fb0580810e122d77dcd14748a55f7f9
BDSDMAC_WLAN_FIRMWARE_SITE = \
	$(call github,boundarydevices,qca-firmware,$(BDSDMAC_WLAN_FIRMWARE_VERSION))
BDSDMAC_WLAN_FIRMWARE_LICENSE = Firmware-QCA
BDSDMAC_WLAN_FIRMWARE_LICENSE_FILES = LICENSE.qca_firmware

define BDSDMAC_WLAN_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
