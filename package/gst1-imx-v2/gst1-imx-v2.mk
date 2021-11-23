################################################################################
#
# gst1-imx-v2
#
################################################################################

GST1_IMX_V2_VERSION = 2.0.0
GST1_IMX_V2_SITE = $(call github,Freescale,gstreamer-imx,$(GST1_IMX_V2_VERSION))
GST1_IMX_V2_LICENSE = LGPL-2.0+
GST1_IMX_V2_LICENSE_FILES = LICENSE
GST1_IMX_V2_INSTALL_STAGING = YES

GST1_IMX_V2_DEPENDENCIES += \
	host-pkgconf \
	gstreamer1 \
	gst1-plugins-base \
	imx-codec \
	libimxvpuapi-v2

ifeq ($(BR2_PACKAGE_IMX_GPU_G2D),y)
GST1_IMX_V2_DEPENDENCIES += imx-gpu-g2d
endif

ifeq ($(BR2_PACKAGE_GST1_IMX_V2_G2D),y)
GST1_IMX_V2_CONF_OPTS += -Dg2d=enabled
else
GST1_IMX_V2_CONF_OPTS += -Dg2d=disabled
endif

$(eval $(meson-package))
