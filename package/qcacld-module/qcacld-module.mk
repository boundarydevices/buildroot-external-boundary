################################################################################
#
# qcacld-module
#
################################################################################

QCACLD_MODULE_VERSION = db914d089c2f773be8be3c729692b043f61dcc12
QCACLD_MODULE_SITE = \
	$(call github,boundarydevices,qcacld-2.0,$(QCACLD_MODULE_VERSION))
QCACLD_MODULE_LICENSE = ISC, BSD-like, GPL-2.0+
QCACLD_MODULE_DEPENDENCIES = linux

define QCACLD_MODULE_BUILD_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
		CONFIG_ROME_IF=$(BR2_PACKAGE_QCACLD_MODULE_IF) \
		ARCH=$(KERNEL_ARCH)  KERNEL_SRC=$(LINUX_DIR)
endef

define QCACLD_MODULE_INSTALL_TARGET_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH=$(KERNEL_ARCH) KERNEL_SRC=$(LINUX_DIR) \
		INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(generic-package))
