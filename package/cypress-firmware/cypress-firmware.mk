################################################################################
#
# cypress-firmware
#
################################################################################

CYPRESS_FIRMWARE_VERSION = 449919baa69f5ca60f9234f275bb5e329ccedeaf
CYPRESS_FIRMWARE_SITE = \
       $(call github,boundarydevices,cypress-firmware,$(CYPRESS_FIRMWARE_VERSION))
CYPRESS_FIRMWARE_LICENSE = Proprietary
CYPRESS_FIRMWARE_LICENSE_FILES = LICENSE

define CYPRESS_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
