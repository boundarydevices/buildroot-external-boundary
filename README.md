buildroot-external-boundary
===========================

Buildroot external layer for Boundary Devices platforms and modules.
Contains support for BD-SDMAC Wi-Fi/BT module as well as some demo configurations.

Configurations details
----------------------

Here are some details about the configurations available:
* `nitrogen8m_qt5_gst1_defconfig`:
  * For i.MX 8MQ based [Nitrogen8M][nitrogen8m], [Nitrogen8M SOM][nitrogen8m-som]
  * Qt5 modules (+ Cinematic Experience demo)
  * GStreamer1.0 with all its plugins
  * NXP proprietary packages (VPU, GPU, SDMA)
  * NXP-based kernel (5.4.x_2.1.0_ga)
  * [BD-SDMAC][bd-sdmac] WiFi/BT modules support
  * Miscellaneous tools (adbd, CAN, I2C, IIO, etc...)
* `nitrogen8mm_qt5_gst1_defconfig`:
  * For i.MX 8M Mini based [Nitrogen8M Mini][nitrogen8mm], [Nitrogen8M Mini SOM][nitrogen8mm-som]
  * Same set of packages as `nitrogen8m_qt5_gst1_defconfig`
* `nitrogen8mn_qt5_gst1_defconfig`:
  * For i.MX 8M Nano based [Nitrogen8M Nano][nitrogen8mn], [Nitrogen8M Nano SOM][nitrogen8mn-som]
  * Same set of packages as `nitrogen8m_qt5_gst1_defconfig`
* `nitrogen6x_qt5_gst1_defconfig`:
  * For [BD-SL-i.MX6 (SABRE Lite)][sabrelite], [Nitrogen6X][nitrogen6x], [Nitrogen6X SOM v2][nitrogen6x-somv2], [Nitrogen6 Lite][nitrogen6-lite], [Nitrogen6 MAX][nitrogen6-max], [Nitrogen6 VM][nitrogen6-vm]
  * TiWi-BLE and Murata WiFi/BT modules support
  * Same set of packages as `nitrogen8m_qt5_gst1_defconfig`
* `nitrogen6sx_qt5_gst1_defconfig`:
  * For [Nitrogen6_SoloX][nitrogen6-sx]
  * Same set of packages as `nitrogen6x_qt5_gst1_defconfig`
* `nitrogen7_gst1_defconfig`:
  * For [Nitrogen7][nitrogen7]
  * Same set of packages as `nitrogen6x_qt5_gst1_defconfig` minus Qt5
* `nitrogen6x_qt5_gst1_mainline_defconfig`:
  * For [BD-SL-i.MX6 (SABRE Lite)][sabrelite], [Nitrogen6X][nitrogen6x], [Nitrogen6X SOM v2][nitrogen6x-somv2], [Nitrogen6 Lite][nitrogen6-lite], [Nitrogen6 MAX][nitrogen6-max]
  * Same set of packages as `nitrogen6x_qt5_gst1_defconfig`
  * Mainline kernel

Build procedure
---------------

1. Download the latest Buildroot tree:
```
$ git clone https://git.busybox.net/buildroot
```

2. Download Boundary Devices external layer:
```
$ git clone https://github.com/boundarydevices/buildroot-external-boundary
```

3. Create an output folder for your build:
```
$ make BR2_EXTERNAL=$PWD/buildroot-external-boundary/ -C buildroot/ \
  O=$PWD/output nitrogen6x_qt5_gst1_defconfig
$ cd output
```

4. Build the image:
```
$ make
```

5. Your rootfs image is ready!
```
$ ls -l images/sdcard.img
```

6. Create the SDK for this image (optional):
```
$ make sdk
```

Flashing procedure
------------------

You can simply use `dd` to flash an SD card:
```
$ sudo dd if=images/sdcard.img of=/dev/sdX bs=1M
```

If you want to flash the eMMC on your board, you can use the U-Boot UMS gadget as explained in [this blog post][emmc-flashing].
```
=> ums 0 mmc 1
```

Using the image
---------------

### Login information
The login for this image is `root` with no password.
```
Welcome to Buildroot
buildroot login: root
#
```

### GPU testing

##### NXP proprietary driver
If the configuration/platform supports 3D GPU, the Vivante example can be tested:
```
# cd /usr/share/examples/viv_samples/vdk/
# ./tutorial7
fps: 496.61
```

##### Mainline driver (etnaviv)
If the configuration/platform supports 3D GPU, make sure to try `kmscube`:
```
# kmscube -D /dev/dri/card1
```

### Qt5 demo
If the configuration includes Qt5 support, the Cinematic demo can be tested.

The NXP proprietary drivers require to setup the following variables:
```
# export FB_MULTI_BUFFER=3
# export QT_QPA_EGLFS_INTEGRATION=eglfs_viv
```

Then the demo can be started:
```
# CinematicExperience-demo -platform eglfs
```

### Gstreamer demo

##### NXP-based kernel
If the configuration includes GStreamer support, the following pipelines can be tested:
* VPU testing
```
# wget http://linode.boundarydevices.com/videos/trailer_1080p_h264_mp3.avi -P /root/
# gst-launch-1.0 playbin uri=file:///root/trailer_1080p_h264_mp3.avi
# gst-launch-1.0 filesrc location=/root/trailer_1080p_h264_mp3.avi ! \
  avidemux ! decodebin ! imxeglvivsink
```
* Camera (MIPI) Streaming to display using 3D GPU:
```
# gst-launch-1.0 imxv4l2videosrc device=/dev/video1 ! imxeglvivsink
```
* Camera (Parallel) Streaming to display using IPU:
```
# gst-launch-1.0 imxv4l2videosrc device=/dev/video0 ! \
  imxipuvideosink use-vsync=true
```
* Camera Streaming to display using PXP (i.MX7 / i.MX6SX):
```
# gst-launch-1.0 imxv4l2videosrc device=/dev/video1 ! \
  imxpxpvideosink use-vsync=true
```

##### Mainline kernel
```
# wget http://linode.boundarydevices.com/videos/trailer_1080p_h264_mp3.avi -P /root/
# gst-launch-1.0 filesrc location=/root/trailer_1080p_h264_mp3.avi ! avidemux ! \
  decodebin ! kmssink name=imx-drm sync=0
```

[bd-sdmac]: https://boundarydevices.com/product/bd_sdmac_wifi/ "BD-SDMAC WiFi/BT module"
[emmc-flashing]:https://boundarydevices.com/programming-emmc-on-i-mx-platforms "Programming eMMC on i.MX"
[nitrogen6x]:http://boundarydevices.com/nitrogen6x-board-imx6-arm-cortex-a9-sbc "Nitrogen6X product page"
[nitrogen6x-som]:http://boundarydevices.com/products/nitrogen6x-som "Nitrogen6X SOM product page"
[nitrogen6x-somv2]:http://boundarydevices.com/product/nit6x-som-v2/ "Nitrogen6X SOM v2 product page"
[nitrogen6-lite]:http://boundarydevices.com/products/nitrogen6_lite "Nitrogen6_Lite product page"
[nitrogen6-max]:http://boundarydevices.com/product/nitrogen6max "Nitrogen6_MAX product page"
[nitrogen6-vm]:http://boundarydevices.com/product/nitrogen6_vm_imx6 "Nitrogen6_VM product page"
[nitrogen6-sx]:http://boundarydevices.com/product/nit6_solox-imx6 "Nit6_SoloX product page"
[nitrogen7]:https://boundarydevices.com/product/nitrogen7 "Nitrogen7 product page"
[nitrogen8m]:https://boundarydevices.com/wiki/nitrogen8m-sbc "Nitrogen8M product page"
[nitrogen8m-som]:https://boundarydevices.com/wiki/nitrogen8m-som "Nitrogen8M SOM product page"
[nitrogen8mm]:https://boundarydevices.com/wiki/nitrogen8m-mini-sbc "Nitrogen8M_Mini product page"
[nitrogen8mm-som]:https://boundarydevices.com/wiki/Nitrogen8M_Mini-SOM "Nitrogen8M_Mini SOM product page"
[nitrogen8mn]:https://boundarydevices.com/wiki/nitrogen8m-nano-sbc "Nitrogen8M Nano product page"
[nitrogen8mn-som]:https://boundarydevices.com/wiki/nitrogen8m-nano-som "Nitrogen8M Nano SOM product page"
[private-git]:https://boundarydevices.com/private-git-access/ "Private Git server access"
[sabrelite]:http://boundarydevices.com/sabre-lite-imx6-sbc "SABRE Lite product page"
