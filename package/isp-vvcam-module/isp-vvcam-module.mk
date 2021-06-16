################################################################################
#
# ISP_VVCAM_MODULE
#
################################################################################

ISP_VVCAM_MODULE_VERSION = 9824e601d336bcef2dc6284ff3605e0b1d32d63d
ISP_VVCAM_MODULE_SITE = https://source.codeaurora.org/external/imx/isp-vvcam
ISP_VVCAM_MODULE_SITE_METHOD = git
ISP_VVCAM_MODULE_LICENSE = GPL-2.0+
ISP_VVCAM_MODULE_DEPENDENCIES = linux

ISP_VVCAM_MODULE_LICENSE = NXP Semiconductor Software License Agreement
ISP_VVCAM_MODULE_LICENSE_FILES = EULA COPYING
ISP_VVCAM_MODULE_REDISTRIBUTE = NO

define ISP_VVCAM_MODULE_BUILD_CMDS
	cd $(@D)/vvcam/v4l2; \
	$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH=$(KERNEL_ARCH) KERNEL_SRC=$(LINUX_DIR)
endef

define ISP_VVCAM_MODULE_INSTALL_TARGET_CMDS
	cd $(@D)/vvcam/v4l2; \
	$(TARGET_MAKE_ENV) $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
		ARCH=$(KERNEL_ARCH) KERNEL_SRC=$(LINUX_DIR) \
		INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(generic-package))
