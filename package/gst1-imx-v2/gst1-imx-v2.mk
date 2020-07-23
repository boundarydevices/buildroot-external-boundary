################################################################################
#
# gst1-imx-v2
#
################################################################################

GST1_IMX_V2_VERSION = 038ec0b65270d0412a6be2cf1d2f63a9aaac0e80
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

$(eval $(meson-package))
