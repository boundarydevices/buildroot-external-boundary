################################################################################
#
# cypress-firmware
#
################################################################################

CYPRESS_FIRMWARE_VERSION = e8d385cd0ce002f49be9b73cd6684e84ae15d603
CYPRESS_FIRMWARE_SITE = \
       $(call github,boundarydevices,cypress-firmware,$(CYPRESS_FIRMWARE_VERSION))
CYPRESS_FIRMWARE_LICENSE = Proprietary
CYPRESS_FIRMWARE_LICENSE_FILES = LICENSE

define CYPRESS_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
