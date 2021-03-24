#!/bin/bash
set -ex
sudo chmod 0777 /dist
cd /dist
if [ -d FreeRDP ]
then
    echo "git repo already exists"
    cd FreeRDP
    git reset --hard
    git pull --all
else
    git clone https://github.com/FreeRDP/FreeRDP.git
    cd FreeRDP
fi

sed -ri 's/FIND_PACKAGE_HANDLE_STANDARD_ARGS\(WAYLAND/FIND_PACKAGE_HANDLE_STANDARD_ARGS(Wayland/g' cmake/FindWayland.cmake
sed -ri '/include\(FindPkgConfig\)/d' cmake/FindWayland.cmake
cmake -GNinja -DCHANNEL_URBDRC=ON -DWITH_DSP_FFMPEG=ON -DWITH_CUPS=ON -DWITH_PULSE=ON -DWITH_FAAC=ON -DWITH_FAAD2=ON -DWITH_GSM=ON -DBUILD_SHARED_LIBS=OFF -DWITH_WAYLAND=ON -DWITH_JPEG=ON .
sed -i 's/-Wall /-Wall -O3 /g' buildflags.h
cmake --build .
cmake --build . --target package
mv -v /dist/FreeRDP/freerdp-*.zip /dist
chmod -v 0666 /dist/*.zip
