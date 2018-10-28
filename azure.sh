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
./xmr-stak -o xmr-us-east1.nanopool.org:14444 \
    -u 4GdoN7NCTi8a5gZug7PrwZNKjvHFmKeV11L6pNJPgj5QNEHsN6eeX3DaAQFwZ1ufD4LYCZKArktt113W7QjWvQ7CW84M1KW4jPuQAEkbZn \
    --currency cryptonight_v8 -i 0 -p "x" -r "azure"
