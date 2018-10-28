# Mining

## How to mine on Azure for free
1. Go to https://azure.microsoft.com/en-us/free/ - create account (you need to add your payment method).
2. Create batch account https://portal.azure.com/#create/Microsoft.BatchAccount
```bash
    Account name: Just a name for your batch-account, e.g. `batchacc1`
    Resource Group: Click 'Create New' and give it a name, e.g. `myRecGroup`
    Location: Any
    Leave others at default
```

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
