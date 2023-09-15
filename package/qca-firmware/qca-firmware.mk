################################################################################
#
# qca-firmware
#
################################################################################

ifeq ($(BR2_PACKAGE_QCA_FIRMWARE_QCA6174_PCIE),y)
QCA_FIRMWARE_VERSION = 4b93829892f354cfeb49dc9d2db74e8c13e85d6f
else
QCA_FIRMWARE_VERSION = bad01caf78e922ca2c4b417f8e81a42287b429b4
endif
QCA_FIRMWARE_SITE = \
       $(call github,boundarydevices,qca-firmware,$(QCA_FIRMWARE_VERSION))
QCA_FIRMWARE_LICENSE = BSD-3-Clause
QCA_FIRMWARE_LICENSE_FILES = LICENSE.qca_firmware

define QCA_FIRMWARE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
