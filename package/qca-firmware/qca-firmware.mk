################################################################################
#
# qca-firmware
#
################################################################################

ifeq ($(BR2_PACKAGE_QCA_FIRMWARE_QCA6174_PCIE),y)
QCA_FIRMWARE_VERSION = 8376bcd5e28a954b6cb522b079d3a94ddf22a756
else
QCA_FIRMWARE_VERSION = af26e1e5670bb9afa0691d260924adf86c37fea3
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
