# Mining-OC-Settings

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
