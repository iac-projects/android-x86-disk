docker:
	sudo docker build . -t quay.io/quamotion/android-x86-disk:6.0-r3

run:
	sudo docker run --rm -it quay.io/quamotion/android-x86-disk:6.0-r3 /bin/bash
