################################################################################
#
# basler-camera
#
################################################################################

BASLER_CAMERA_VERSION = 4.2.2.6.0
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
	mkdir -p $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/opt/imx8-isp/bin/* $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/usr/lib/* $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
