# Installing OpenWrt on a Wi-Fi router
Depending on the Wi-Fi router model, installing OpenWrt could be as simple as using the Wi-Fi router's stock firmware upgrade web page and uploading the OpenWrt firmware, or as complex as disassembling Wi-Fi router to access the mainboard to flash OpenWrt firmware using serial or JTAG port.  
**Before buying a Wi-Fi router, review the instructions for installing OpenWrt to check the difficulty level and confirm you are comfortable with the level of difficulty involved.**  
- **Beginners** are recommended to select a Wi-Fi router that supports installing OpenWrt by using the Wi-Fi router's stock firmware upgrade web page, as that is the simplest installation method. 
- **Advanced users** can choose a Wi-Fi router that support installing OpenWrt via a command line interface to connect to the Wi-Fi router bootloader via wired ethernet connection, and setting up a TFTP server to transfer OpenWrt firmware.  
The below Wi-Fi routers are affordable and have good OpenWrt support as of 2023:
- [Dynalink DL-WRX36](https://openwrt.org/toh/dynalink/dl-wrx36) Wi-Fi 6 (802.11ax) 3600 Mbps max
- [Linksys E8450/Belkin RT3200](https://openwrt.org/toh/linksys/e8450) Wi-Fi 6 (802.11ax) 3200 Mbps max
- [Netgear R7800 Nighthawk X4S](https://openwrt.org/toh/netgear/r7800) Wi-Fi 5 (802.11ac) 2600 Mbps max