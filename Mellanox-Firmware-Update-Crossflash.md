## Updating Mellanox firmware

[Official Nvidia Firmware Update Instructions](https://network.nvidia.com/support/firmware/nic/)  

**Before updating firmware, first install Mellanox OS drivers to confirm the network adapter is working.**

1. Download Nvidia Firmware Tools (MFT) package. Example: [WinMFT_x64_4_24_0_72.exe](https://content.mellanox.com/MFT/WinMFT_x64_4_24_0_72.exe)
2. Download the correct OEM firmware image from [Nvidia Firmware Downloads](https://network.nvidia.com/support/firmware/firmware-downloads/). Example: [2.42.5000 for Mellanox ConnectX-3 PRO VPI (MCX354A-FCCT)](https://content.mellanox.com/firmware/fw-ConnectX3Pro-rel-2_42_5000-MCX354A-FCC_Ax-FlexBoot-3.4.752.bin.zip)
3. Install MFT software
4. Burn the firmware image to the network card
   1. For Linux, first start the mst driver service by running: `mst start`.
Note: This step is applicable to Linux OSes ONLY.
   1. Print the current status of NVIDIA devices, run: `mst status`.
   The format of device name is:
      - Linux: `/dev/mst/mt<dev_id>_pci{_cr0|conf0}`
      - Windows: `mt<dev_id>_pci{_cr0|conf0}`
   2. Check card version by running `mlxfwmanager --query`
   3. Check card info by running `flint -d <device_name> query full`
   4. Create backup of stock firmware image by running `flint -d <device_name> ri <out-filename.bin>`
   5. Create backup of stock firmware configuration file by running `flint -d <device_name> dc <out-filename.cfg>`
   6. Unzip the firmware binary image (.zip file).
   7. Burn the firmware image by running: `flint -d <device_name> -i <binary image> -allow_psid_change burn`

Stock HP: `mlxfwmanager --query`
``` 
Device #1:
----------

  Device Type:      ConnectX3Pro
  Part Number:      764284-B21_Ax
  Description:      HP InfiniBand FDR/Ethernet 10Gb/40Gb 2-port 544+QSFP Adapter
  PSID:             HP_1370110017
  PCI Device Name:  mt4103_pci_cr0
  Port1 GUID:       9cdc71ffff5aae91
  Port2 GUID:       9cdc71ffff5aae92
  Versions:         Current        Available
     FW             2.42.5044      N/A
     CLP            8025           N/A
     PXE            3.4.0754       N/A
     UEFI           14.11.0048     N/A

  Status:           No matching image found
```

Stock HP: `flint -d <device_name> query full`
``` 
PS C:\WINDOWS\system32> flint -d mt4103_pci_cr0 query full
Image type:            FS2
FW Version:            2.42.5044
FW Release Date:       21.10.2018
MIC Version:           2.0.0
Config Sectors:        2
PRS Name:              cx3pro_hp_falcon_2p_fdr.prs
Product Version:       02.42.50.44
Rom Info:              version_id=8025 type=CLP
                       type=UEFI version=14.11.48 cpu=AMD64
                       type=PXE version=3.4.754
Device ID:             4103
Description:           Node             Port1            Port2            Sys image
GUIDs:                 9cdc71ffff5aae90 9cdc71ffff5aae91 9cdc71ffff5aae92 9cdc71ffff5aae93
MACs:                                       9cdc715aae91     9cdc715aae92
VSD:
PSID:                  HP_1370110017
```

https://docs.nvidia.com/networking/display/MFTv4240/User%20Manual


Check firmware version: `flint -d mt4099_pci_cr0 query full`


Put these lines in a batch file

Do these two lines once to create mlnx_firmware.bin
mlxburn -fw fw-ConnectX3-rel.mlx -conf MCX354A-FCB_A2-A5.ini -wrimage HP_mlnx_firmware.bin
mlxburn -fw fw-ConnectX3-rel.mlx -conf MCX354A-FCB_A2-A5.ini -wrimage fw-ConnectX3-rel-2_31_5050-MCX354A-FCB_A2-A5-56GbE_VPI.bin

echo Cross Flash HP card to use Mellanox CX3 firmware
pause

call flint -i HP_mlnx_firmware.bin verify
call flint -i HP_mlnx_firmware.bin query full

pause
call flint -d mt4099_pciconf0 -i HP_mlnx_firmware.bin -allow_psid_change burn

pause

You need to download and install WinMFT_x64_4_5_0_31.exe
You also need ConnectX3-rel-2_40_5000.tgz ( this is the version I used )
latter version is ConnectX3-rel-2_40_5030.tgz ( dated March 2017 )