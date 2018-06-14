sudo ./ohgodatool -i 0 --mem-state 2 --mem-clock 2150
sudo ./ohgodatool -i 1 --mem-state 2 --mem-clock 2150

# this works for gpu0
sudo ./ohgodatool -i 0 --core-state 7 --core-vddc-idx 1
# this does not work for gpu1
# sudo ./ohgodatool -i 1 --core-state 7 --core-vddc-idx 1
# even this does not work for gpu1
# sudo ./ohgodatool -i 1 --core-state 7 --core-vddc-idx 2
# this finally works for gpu1
sudo ./ohgodatool -i 1 --core-state 7 --core-vddc-idx 3
