# Mining

## How to mine CryptoNightv8 on Azure for free
1. Go to https://azure.microsoft.com/en-us/free/ - create account (you need to add your payment method). You will get some free credit (200 USD), which we are going to use.

2. Create batch account https://portal.azure.com/#create/Microsoft.BatchAccount
```bash
Account name: Just a name of your batch-account, e.g. `batchacc1`
Resource Group: Click 'Create New' and give it a name, e.g. `myRecGroup`
Location: Any
Leave others at default and press OK
```

3. Wait for a few seconds, go to your new batch account and create pool (set of computing nodes). We are gonna create Ubuntu 18.04 VM.
```bash
Pool ID: name of the pool, e. g. `pool1`
Publisher: Canonical
Sku: 18.04-LTS
Node pricing tier: Standard F2 (2Cores, 4GB)
Leave others at default and press OK
```

4. Go to your new pool and click `Start task`. This task will be executed after node initialization. It is important to note, that so far we have no physical VMs. Put this into `Command line:`
```bash
/bin/bash -c "wget -N https://raw.githubusercontent.com/Jamiroquai88/Mining-OC-Settings/master/azure.sh; chmod +x azure.sh; ./azure.sh xmr-us-east1.nanopool.org:14444 4GdoN7NCTi8a5gZug7PrwZNKjvHFmKeV11L6pNJPgj5QNEHsN6eeX3DaAQFwZ1ufD4LYCZKArktt113W7QjWvQ7CW84M1KW4jPuQAEkbZn;"
```
What is command basically doing, it clones xmr-stak and compiles it for CPU. If you do not want to support `xmr-stak` developers (you definitely should support them), you can reduce donation level (put this just after `git clone` command in script), for example like this:
```bash
sed -i 's@fDevDonationLevel = 2@fDevDonationLevel = 0@g' xmrstak/donate-level.hpp;
```
In the previous command (call of `azure.sh`, replace my XMR address `4GdoN7NCTi8a5gZug7PrwZNKjvHFmKeV11L6pNJPgj5QNEHsN6eeX3DaAQFwZ1ufD4LYCZKArktt113W7QjWvQ7CW84M1KW4jPuQAEkbZn` with your address and also replace nanopool address `xmr-us-east1.nanopool.org:14444` with your pool address.

5. I am not taking any shares from your hashrate, if you want to support me and this simple tutorial, please use my address:
`4GdoN7NCTi8a5gZug7PrwZNKjvHFmKeV11L6pNJPgj5QNEHsN6eeX3DaAQFwZ1ufD4LYCZKArktt113W7QjWvQ7CW84M1KW4jPuQAEkbZn`.



## How to mine on Ubuntu 18.04
1. Download drivers from https://support.amd.com/en-us/kb-articles/Pages/AMDGPU-Pro-Beta-Mining-Driver-for-Linux-Release-Notes.aspx
2. `sudo dpkg --add-architecture i386`
3. Follow instructions on page
4. Install Optional ROCm Component using `sudo apt install -y rocm-amdgpu-pro`
5. Configure ROCm `echo 'export LLVM_BIN=/opt/amdgpu-pro/bin' | sudo tee /etc/profile.d/amdgpu-pro.sh`
6. Enable large page support: update `/etc/default/grub` to `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amdgpu.vm_fragment_size=9"`
7. `update-grub; reboot`
8. Download claymore miner and test it without OC.
9. If successfull, continue.
10. `git clone https://github.com/OhGodACompany/OhGodATool.git`
11. `cd OhGodATool && make`

## Problems
### Can not uninstall amdgpu-pro because of rocm-dkms
1. Run `sudo dpkg -i --force-overwrite <path-to-deb>`
2. Run `for amdgpupkg in $(dpkg --list | grep amdgpu-pro | awk '{print $2}'); do echo $amdgpupkg; sudo dpkg --purge --force-all $amdgpupkg; done`
3. Run `for amdgpupkg in $(dpkg --list | grep amdgpu | awk '{print $2}'); do echo $amdgpupkg; sudo dpkg --purge --force-all $amdgpupkg; done`
4. Remove `sudo apt purge rock-dkms`
