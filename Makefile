docker: Dockerfile *.sh *.patch
	sudo docker build . -t quay.io/quamotion/android-x86-disk:7.1-r2
	sudo docker image ls --format "{{.ID}}" quay.io/quamotion/android-x86-disk:7.1-r2 > docker

run: docker
	sudo docker run --rm -it $$(cat docker) /bin/bash

android-x86.qcow2: docker
	sudo docker run -v $$(pwd):/target --rm $$(cat docker) /bin/bash -c "cp /disk/android-x86.qcow2 /target/android-x86.qcow2"

qemu: android-x86.qcow2
	sudo qemu-system-x86_64 \
	     -enable-kvm \
	     -m 4G \
	     -smp 2 \
	     -nodefaults \
	     -M graphics=off \
	     -serial stdio \
	     -display egl-headless -vnc :0 \
	     -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/a297db4a-f4c2-11e6-90f6-d3b88d6c9525,display=on \
             -device e1000,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5000-:5555 \
	     -hda android-x86.qcow2

