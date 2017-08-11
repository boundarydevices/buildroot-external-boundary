buildroot-external-boundary
===========================

Buildroot external layer for Boundary Devices platforms and modules.
Contains support for BD-SDMAC Wi-Fi/BT module as well as some demo configurations.

Build procedure
---------------

1. Download the latest Buildroot tree:
```
$ git clone https://git.busybox.net/buildroot -b 2017.08.x
```

2. Download Boundary Devices external layer:
```
$ git clone https://github.com/boundarydevices/buildroot-external-boundary -b 2017.08.x
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
If the configuration/platform supports 3D GPU, the Vivante example can be tested:
```
# cd /usr/share/examples/viv_samples/vdk/
# ./tutorial7
fps: 496.61
```

### Qt5 demo
If the configuration includes Qt5 support, the Cinematic demo can be tested:
```
# export FB_MULTI_BUFFER=3
# export QT_QPA_EGLFS_INTEGRATION=eglfs_viv
# CinematicExperience-demo -platform eglfs
```

### Gstreamer demo
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

[emmc-flashing]:https://boundarydevices.com/programming-emmc-on-i-mx6 "Programming eMMC on i.MX"
