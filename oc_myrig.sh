#! /bin/bash

# 0    01 00 67DF Ellesmere       W25X20           40000 pass 115-D009PI2-101
# 1    02 00 67DF Ellesmere       M25P40/c         80000 pass 113-58085STD1-M80
# 2    04 00 67DF Ellesmere       M25P40/c         80000 pass 113-58085SHD1-M80
# 3    05 00 67DF Ellesmere       M25P20/c         40000 pass 113-58085SHD1-W90
# 4    06 00 67DF Ellesmere       M25P40/c         80000 pass 113-58085SHD1-M80
# 5    07 00 67DF Ellesmere       W25X20           40000 pass 115-C940PI0-100

sudo ./ohgodatool -i 3 --core-state 7 --core-vddc-idx 13 --mem-state 2  --mem-clock 2100
sudo ./ohgodatool -i 5 --mem-state 2 --mem-clock 2000 --core-state 7 --core-vddc-idx 13

vddc_voltages=(1050 750 750 1000 750 910)
for gpuid in ${!vddc_voltages[*]}
do
    if [[ "$gpuid" != "0" ]] && [[ "$gpuid" != "0" ]];
    then
        echo "Setting up VDDC Voltage GPU$gpuid"
        for voltstate in {1..15}
        do
            ./wolfamdctrl -i $gpuid --volt-state $voltstate --vddc-table-set ${vddc_voltages[$gpuid]}
        done
    fi
done
