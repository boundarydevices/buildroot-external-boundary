################################################################################
#
# kernel-module-isp-vvcam
#
################################################################################

KERNEL_MODULE_ISP_VVCAM_VERSION = e82559d4129848fede0d9181e238314e99ae989d
KERNEL_MODULE_ISP_VVCAM_SITE = $(call github,boundarydevices,isp-vvcam,$(KERNEL_MODULE_ISP_VVCAM_VERSION))
KERNEL_MODULE_ISP_VVCAM_LICENSE = GPL-2.0
KERNEL_MODULE_ISP_VVCAM_DEPENDENCIES = linux

KERNEL_MODULE_ISP_VVCAM_MODULE_SUBDIRS = vvcam/v4l2
KERNEL_MODULE_ISP_VVCAM_MODULE_MAKE_OPTS = KERNEL_SRC=$(LINUX_DIR) ENABLE_IRQ=yes

$(eval $(kernel-module))
$(eval $(generic-package))
