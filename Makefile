docker:
        sudo docker build . -t quay.io/quamotion/android-x86-disk:8.1-rc2

run:
        sudo docker run --rm -it quay.io/quamotion/android-x86-disk:8.1-rc2 /bin/bash
