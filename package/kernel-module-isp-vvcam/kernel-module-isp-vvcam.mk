################################################################################
#
# kernel-module-isp-vvcam
#
################################################################################

KERNEL_MODULE_ISP_VVCAM_VERSION = 551415470092d6af1d7e11e7a78591f5800333f9
KERNEL_MODULE_ISP_VVCAM_SITE = https://source.codeaurora.org/external/imx/isp-vvcam
KERNEL_MODULE_ISP_VVCAM_SITE_METHOD = git
KERNEL_MODULE_ISP_VVCAM_LICENSE = GPL-2.0
KERNEL_MODULE_ISP_VVCAM_DEPENDENCIES = linux

KERNEL_MODULE_ISP_VVCAM_MODULE_SUBDIRS = vvcam/v4l2
KERNEL_MODULE_ISP_VVCAM_MODULE_MAKE_OPTS = KERNEL_SRC=$(LINUX_DIR) ENABLE_IRQ=yes

$(eval $(kernel-module))
$(eval $(generic-package))
