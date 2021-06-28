################################################################################
#
# isp-imx
#
################################################################################

ISP_IMX_VERSION = 4.2.2.11.0
ISP_IMX_SITE = $(FREESCALE_IMX_SITE)
ISP_IMX_SOURCE = isp-imx-$(ISP_IMX_VERSION).bin
ISP_IMX_DEPENDENCIES = linux linux-imx-headers python3 libdrm imx-gpu-g2d
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
    -DIMX_G2D=ON \
    -DBUILD_SHARED_LIBS=ON \
    -Wno-dev

ISP_IMX_CONF_ENV += SDKTARGETSYSROOT=$(STAGING_DIR)

define ISP_IMX_EXTRACT_CMDS
	$(call FREESCALE_IMX_EXTRACT_HELPER,$(ISP_IMX_DL_DIR)/$(ISP_IMX_SOURCE))
endef

define ISP_IMX_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/*2775* $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/isp_media_server $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/*_test $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/bin/vvext $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/dewarp/dewarp_config/ $(TARGET_DIR)/opt/imx8-isp/bin
	cp -r $(@D)/$(ISP_IMX_SUBDIR)/generated/release/lib/*.so* $(TARGET_DIR)/usr/lib/

	cp $(@D)/imx/run.sh $(TARGET_DIR)/opt/imx8-isp/bin
	cp $(@D)/imx/start_isp.sh $(TARGET_DIR)/opt/imx8-isp/bin

	chmod +x $(TARGET_DIR)/opt/imx8-isp/bin/run.sh
	chmod +x $(TARGET_DIR)/opt/imx8-isp/bin/start_isp.sh
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
