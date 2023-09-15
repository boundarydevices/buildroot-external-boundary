################################################################################
#
# LIBIMXVPUAPI_V2
#
################################################################################

LIBIMXVPUAPI_V2_VERSION = 2.3.0
LIBIMXVPUAPI_V2_SITE = $(call github,Freescale,libimxvpuapi,$(LIBIMXVPUAPI_V2_VERSION))
LIBIMXVPUAPI_V2_LICENSE = LGPL-2.1+
LIBIMXVPUAPI_V2_LICENSE_FILES = LICENSE
LIBIMXVPUAPI_V2_DEPENDENCIES = host-pkgconf host-python3 imx-vpu-hantro libimxdmabuffer
LIBIMXVPUAPI_V2_DEPENDENCIES += linux
LIBIMXVPUAPI_V2_INSTALL_STAGING = YES
LIBIMXVPUAPI_V2_NEEDS_EXTERNAL_WAF = YES

LIBIMXVPUAPI_V2_CONF_OPTS += --imx-headers="$(LINUX_DIR)/include/uapi"
LIBIMXVPUAPI_V2_CONF_OPTS += --sysroot-path=$(STAGING_DIR)
LIBIMXVPUAPI_V2_CONF_OPTS += --libdir=/usr/lib
ifeq ($(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8MM),y)
LIBIMXVPUAPI_V2_CONF_OPTS += --imx-platform="imx8mm"
else
LIBIMXVPUAPI_V2_CONF_OPTS += --imx-platform="imx8m"
endif

$(eval $(waf-package))
