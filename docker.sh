bash -c "sudo apt install -y git; git clone https://github.com/fireice-uk/xmr-stak.git; sudo apt install -y libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev; cd xmr-stak; sed -i 's@fDevDonationLevel = 2@fDevDonationLevel = 0@g' xmrstak/donate-level.hpp; mkdir build; cd build; cmake .. -DOpenCL_ENABLE=OFF; make install -j 8; cd bin; ./xmr-stak  -o  pool.supportxmr.com:7777 -u 4GdoN7NCTi8a5gZug7PrwZNKjvHFmKeV11L6pNJPgj5QNEHsN6eeX3DaAQFwZ1ufD4LYCZKArktt113W7QjWvQ7CW84M1KW4jPuQAEkbZn --currency cryptonight_r -p x -r azure -i 0 --noCPU;"
