################################################################################
#
# bdsdmac_module
#
################################################################################

BDSDMAC_MODULE_VERSION = cb598adce4c1136fbf61c5dc7754fb962d72da87
BDSDMAC_MODULE_SITE = \
	$(call github,boundarydevices,qcacld-2.0,$(BDSDMAC_MODULE_VERSION))
BDSDMAC_MODULE_LICENSE = ISC, BSD-like, GPL-2.0+
BDSDMAC_MODULE_DEPENDENCIES = linux

define BDSDMAC_MODULE_BUILD_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH=arm CONFIG_CLD_HL_SDIO_CORE=y KERNEL_SRC=$(LINUX_DIR)
endef

define BDSDMAC_MODULE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH=arm KERNEL_SRC=$(LINUX_DIR) \
		INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(generic-package))
