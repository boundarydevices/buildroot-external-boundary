################################################################################
#
# isp-imx
#
################################################################################

ISP_IMX_VERSION = 4.2.2.22.0
ISP_IMX_SITE = $(FREESCALE_IMX_SITE)
ISP_IMX_SOURCE = isp-imx-$(ISP_IMX_VERSION).bin
ISP_IMX_DEPENDENCIES = linux linux-imx-headers python3 libdrm tinyxml2 boost
ISP_IMX_LICENSE = NXP Semiconductor Software License Agreement
ISP_IMX_LICENSE_FILES = EULA COPYING
ISP_IMX_REDISTRIBUTE = NO
ISP_IMX_SUBDIR = appshell

ISP_IMX_CONF_OPTS += \
	-DCMAKE_BUILD_TYPE=release \
	-DISP_VERSION=ISP8000NANO_V1802 \
	-DPLATFORM=ARM64 \
	-DAPPMODE=V4L2 \
	-DQTLESS=1 \
	-DFULL_SRC_COMPILE=1 \
	-DWITH_DRM=1 \
	-DWITH_DWE=1 \
	-DSERVER_LESS=1 \
	-DSUBDEV_V4L2=1 \
	-DENABLE_IRQ=1 \
	-DPARTITION_BUILD=0 \
	-D3A_SRC_BUILD=0 \
	-DSDKTARGETSYSROOT=$(STAGING_DIR) \
	-Wno-dev

ifeq ($(BR2_PACKAGE_IMX_GPU_G2D),y)
ISP_IMX_CONF_OPTS += -DIMX_G2D=ON
ISP_IMX_DEPENDENCIES += imx-gpu-g2d
endif

ISP_IMX_CONF_ENV += SDKTARGETSYSROOT=$(STAGING_DIR)

define ISP_IMX_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(ISP_IMX_DL_DIR)/$(ISP_IMX_SOURCE))
endef

define ISP_IMX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/*_test $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/*.xml $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/isp_media_server $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/vvext $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/*.drv $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/*.drv $(TARGET_DIR)/usr/lib64
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/lib/*.so* $(TARGET_DIR)/usr/lib/
	cp -r $(@D)/dewarp/dewarp_config $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp -r $(@D)/mediacontrol/case/ $(TARGET_DIR)/usr/share/imx8-isp/bin

	cp $(@D)/imx/run.sh $(TARGET_DIR)/usr/share/imx8-isp/bin
	cp $(@D)/imx/start_isp.sh $(TARGET_DIR)/usr/share/imx8-isp/bin

	chmod +x $(TARGET_DIR)/usr/share/imx8-isp/bin/run.sh
	chmod +x $(TARGET_DIR)/usr/share/imx8-isp/bin/start_isp.sh
endef

define ISP_IMX_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/imx/imx8-isp.service \
		$(TARGET_DIR)/usr/lib/systemd/system/imx8-isp.service
endef

define ISP_IMX_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(BR2_EXTERNAL_BOUNDARY_PATH)/package/isp-imx/S80isp \
		$(TARGET_DIR)/etc/init.d/S80isp
endef

$(eval $(cmake-package))
