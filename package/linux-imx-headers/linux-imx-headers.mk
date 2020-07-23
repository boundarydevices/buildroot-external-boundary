################################################################################
#
# linux-imx-headers
#
################################################################################

LINUX_IMX_HEADERS_DEPENDENCIES += linux
LINUX_IMX_HEADERS_INSTALL_STAGING = YES

IMX_UAPI_HEADERS = \
	dma-buf.h \
	hantrodec.h \
	hx280enc.h \
	ion.h \
	ipu.h \
	isl29023.h \
	mxc_asrc.h \
	mxc_dcic.h \
	mxc_mlb.h \
	mxc_sim_interface.h \
	mxc_v4l2.h \
	mxcfb.h \
	pxp_device.h \
	pxp_dma.h \
	version.h \
	videodev2.h

define LINUX_IMX_HEADERS_CONFIGURE_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(MAKE) \
		-C $(LINUX_DIR) \
		ARCH=$(KERNEL_ARCH) \
		HOSTCC="$(HOSTCC)" \
		HOSTCFLAGS="$(HOSTCFLAGS)" \
		HOSTCXX="$(HOSTCXX)" \
		INSTALL_HDR_PATH=$(@D) \
		headers_install; \
	cp $(LINUX_DIR)/drivers/staging/android/uapi/ion.h \
		$(@D)/include/linux/ion.h;
endef

define LINUX_IMX_HEADERS_INSTALL_STAGING_CMDS
	for h in $(IMX_UAPI_HEADERS); do \
		install -D -m 0644 $(@D)/include/linux/$$h \
			$(STAGING_DIR)/usr/include/imx/linux/$$h; \
	done;
endef

$(eval $(generic-package))
