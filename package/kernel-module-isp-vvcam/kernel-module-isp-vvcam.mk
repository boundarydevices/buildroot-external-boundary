################################################################################
#
# kernel-module-isp-vvcam
#
################################################################################

KERNEL_MODULE_ISP_VVCAM_VERSION = 58fcf56f7232055cfa9bc44f524e85bc12c53ce5
KERNEL_MODULE_ISP_VVCAM_SITE = $(call github,boundarydevices,isp-vvcam,$(KERNEL_MODULE_ISP_VVCAM_VERSION))
KERNEL_MODULE_ISP_VVCAM_LICENSE = GPL-2.0
KERNEL_MODULE_ISP_VVCAM_DEPENDENCIES = linux

KERNEL_MODULE_ISP_VVCAM_MODULE_SUBDIRS = vvcam/v4l2
KERNEL_MODULE_ISP_VVCAM_MODULE_MAKE_OPTS = KERNEL_SRC=$(LINUX_DIR) ENABLE_IRQ=yes

$(eval $(kernel-module))
$(eval $(generic-package))
