################################################################################
#
# basler-camera
#
################################################################################

BASLER_CAMERA_VERSION = 4.2.2.18.0
BASLER_CAMERA_SITE = $(FREESCALE_IMX_SITE)
BASLER_CAMERA_SOURCE = basler-camera-$(BASLER_CAMERA_VERSION).bin
BASLER_CAMERA_DEPENDENCIES = linux

BASLER_CAMERA_LICENSE = NXP Semiconductor Software License Agreement
BASLER_CAMERA_LICENSE_FILES = EULA COPYING
BASLER_CAMERA_REDISTRIBUTE = NO

define BASLER_CAMERA_EXTRACT_CMDS
	$(call FREESCALE_IMX_EXTRACT_HELPER,$(BASLER_CAMERA_DL_DIR)/$(BASLER_CAMERA_SOURCE))
endef

define BASLER_CAMERA_INSTALL_TARGET_CMDS
	cp -r $(@D)/opt/* $(TARGET_DIR)/usr/share/
	ln -sf /usr/share/imx8-isp/bin/daA3840_30mc.drv $(TARGET_DIR)/usr/lib64/daA3840_30mc.drv
	cp -r $(@D)/usr/* $(TARGET_DIR)/usr/
endef

$(eval $(generic-package))
