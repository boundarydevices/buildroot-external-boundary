################################################################################
#
# libimxdmabuffer
#
################################################################################

LIBIMXDMABUFFER_VERSION = 1.0.1
LIBIMXDMABUFFER_SITE = $(call github,Freescale,libimxdmabuffer,$(LIBIMXDMABUFFER_VERSION))
LIBIMXDMABUFFER_LICENSE = LGPL-2.1+
LIBIMXDMABUFFER_LICENSE_FILES = LICENSE
LIBIMXDMABUFFER_DEPENDENCIES = host-pkgconf host-python
LIBIMXDMABUFFER_DEPENDENCIES += linux-imx-headers
LIBIMXDMABUFFER_INSTALL_STAGING = YES
LIBIMXDMABUFFER_NEEDS_EXTERNAL_WAF = YES

# Only enable ION allocation for now
# (PxP/IPU are for i.MX6, G2D/Hantro are less attractive)
LIBIMXDMABUFFER_CONF_OPTS += --with-ion-allocator=yes
LIBIMXDMABUFFER_CONF_OPTS += --with-dwl-allocator=no --with-g2d-allocator=no
LIBIMXDMABUFFER_CONF_OPTS += --with-pxp-allocator=no --with-ipu-allocator=no
LIBIMXDMABUFFER_CONF_OPTS += --imx-linux-headers-path="$(STAGING_DIR)/usr/include/imx"
LIBIMXDMABUFFER_CONF_OPTS += --libdir=/usr/lib

$(eval $(waf-package))
