# android-x86-disk

[![Docker Repository on Quay](https://quay.io/repository/kubedroid/android-x86-disk/status "Docker Repository on Quay")](https://quay.io/repository/kubedroid/android-x86-disk)

This repository contains scripts to create a Docker image which contains a disk image
of an Android-x86 installation.

You can use it together with [kubevirt](https://kubevirt.io) to run Android emulators
on top of your Kubernetes cluster.

This copy of Android is:
* Optimized to run as a KVM guest with GPU acceleration
* Preconfigured to skip the Android installer, enable ADB,... .

## Using

The preferred way of using this image is through [kubedroid](https://github.com/kubedroid/kubedroid).
See the main KubeDroid repository for more info.

You can also use this disk to run Android-x86 on any KVM-enabled Linux computer. To do so,
you'll first need to extract the disk image from the container:

```
docker run -v $(pwd):/target --rm quay.io/kubedroid/android-x86-disk:7.1-r2 /bin/bash -c "cp /disk/android-x86.qcow2 /target/android-x86.qcow2"
```

Then, launch qemu:

```
qemu-system-x86_64 \
     -enable-kvm \
     -m 4G \
     -smp 2 \
     -serial stdio \
     -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5000-:5555 \
     -hda android-x86.qcow2
```

You can connect to your Android VM using VNC, and adb on port 5000.

If you want to use graphics acceleration, use:

```
qemu-system-x86_64 \
     -enable-kvm \
     -m 4G \
     -smp 2 \
     -serial stdio \
     -nodefaults \
     -M graphics=off \
     -display egl-headless -vnc :0 \
     -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/a297db4a-f4c2-11e6-90f6-d3b88d6c9525,display=on \
     -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5000-:5555 \
     -hda android-x86.qcow2
```



## About

This repository is part of [KubeDroid](https://github.com/kubedroid). You can use KubeDroid to run Android-x86
emulators inside Kubernetes clusters, using [KubeVirt](https://kubevirt.io)

KubeDroid is sponsored by [Quamotion](http://quamotion.mobi). Quamotion provides test automation software for
mobile devices.
