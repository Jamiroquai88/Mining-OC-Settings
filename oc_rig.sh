#!/usr/bin/env bash

# 0    01 00 67DF Ellesmere       W25X20           40000 pass 115-C940PI0-100
# 1    02 00 67DF Ellesmere       M25P20/c         40000 pass 113-D00034-S07
# 2    04 00 67DF Ellesmere       W25X20           40000 pass 115-D009PI2-101
# 3    05 00 67DF Ellesmere       M25P40/c         80000 pass 113-58085SHD1-M80
# 4    06 00 67DF Ellesmere       M25P40/c         80000 pass 113-58085SHD1-M80
# 5    07 00 67DF Ellesmere       M25P40/c         80000 pass 113-58085SHD1-M80

sudo ./ohgodatool -i 0 --mem-state 2 --mem-clock 2075
sudo ./ohgodatool -i 1 --mem-state 2  --mem-clock 2050
sudo ./ohgodatool -i 3 --mem-state 2 --mem-clock 2100
sudo ./ohgodatool -i 4 --mem-state 2 --mem-clock 2125
sudo ./ohgodatool -i 5 --mem-state 2 --mem-clock 2100

sudo ./ohgodatool -i 0 --core-state 7 --core-vddc-idx 13
sudo ./ohgodatool -i 1 --core-state 7 --core-vddc-idx 9
sudo ./ohgodatool -i 3 --core-state 7 --core-vddc-idx 9
sudo ./ohgodatool -i 4 --core-state 7 --core-vddc-idx 10
sudo ./ohgodatool -i 5 --core-state 7 --core-vddc-idx 9

vddc_voltages=(945 850 1050 860 815 850)
# set all voltage states from 1 upwards to xxx mV:
for gpuid in ${!vddc_voltages[*]}
do
    if [[ "$gpuid" != "0" ]] && [[ "$gpuid" != "2" ]]; then
        echo "Setting up VDDC Voltage GPU$gpuid"
        for voltstate in {1..15}
        do
        ./wolfamdctrl -i $gpuid --volt-state $voltstate --vddc-table-set ${vddc_voltages[$gpuid]}
        done
    fi
done
