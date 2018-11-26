docker:
	sudo docker build . -t quay.io/quamotion/android-x86-disk:5.1-rc1

run:
	sudo docker run --rm -it quay.io/quamotion/android-x86-disk:5.1-rc1 /bin/bash
