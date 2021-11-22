################################################################################
#
# kernel-module-isp-vvcam
#
################################################################################

KERNEL_MODULE_ISP_VVCAM_VERSION = 47588cb88cc75400b5d2c35a17527e99b752d9be
KERNEL_MODULE_ISP_VVCAM_SITE = https://source.codeaurora.org/external/imx/isp-vvcam
KERNEL_MODULE_ISP_VVCAM_SITE_METHOD = git
KERNEL_MODULE_ISP_VVCAM_LICENSE = GPL-2.0
KERNEL_MODULE_ISP_VVCAM_DEPENDENCIES = linux

KERNEL_MODULE_ISP_VVCAM_MODULE_SUBDIRS = vvcam/v4l2
KERNEL_MODULE_ISP_VVCAM_MODULE_MAKE_OPTS = KERNEL_SRC=$(LINUX_DIR) ENABLE_IRQ=yes

$(eval $(kernel-module))
$(eval $(generic-package))
