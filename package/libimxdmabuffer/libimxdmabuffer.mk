################################################################################
#
# libimxdmabuffer
#
################################################################################

LIBIMXDMABUFFER_VERSION = 1.1.2
LIBIMXDMABUFFER_SITE = $(call github,Freescale,libimxdmabuffer,$(LIBIMXDMABUFFER_VERSION))
LIBIMXDMABUFFER_LICENSE = LGPL-2.1+
LIBIMXDMABUFFER_LICENSE_FILES = LICENSE
LIBIMXDMABUFFER_DEPENDENCIES = host-pkgconf host-python3
LIBIMXDMABUFFER_DEPENDENCIES += linux-imx-headers
LIBIMXDMABUFFER_INSTALL_STAGING = YES
LIBIMXDMABUFFER_NEEDS_EXTERNAL_WAF = YES

LIBIMXDMABUFFER_CONF_OPTS += --with-dwl-allocator=no --with-g2d-allocator=no
LIBIMXDMABUFFER_CONF_OPTS += --with-pxp-allocator=no --with-ipu-allocator=no
LIBIMXDMABUFFER_CONF_OPTS += --imx-linux-headers-path="$(STAGING_DIR)/usr/include/imx"
LIBIMXDMABUFFER_CONF_OPTS += --libdir=/usr/lib

$(eval $(waf-package))
