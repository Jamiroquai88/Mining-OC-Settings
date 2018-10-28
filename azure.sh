#!/usr/bin/env bash

sudo apt -y update
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth

git clone https://github.com/fireice-uk/xmr-stak.git
cd xmr-stak

sed -i 's@fDevDonationLevel = 2@fDevDonationLevel = 0@g' xmrstak/donate-level.hpp

mkdir build
cd build

cmake .. -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF
make

cd bin
./xmr-stak \
    -o $1 \
    -u $2 \
    --currency cryptonight_v8 -p "x" -r "azure" -i 0
