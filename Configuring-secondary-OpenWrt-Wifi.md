# Configuring a secondary OpenWrt device with Wi-Fi 802.11s mesh networking for improved connection speed & reliability

- [Configuring a secondary OpenWrt device with Wi-Fi 802.11s mesh networking for improved connection speed \& reliability](#configuring-a-secondary-openwrt-device-with-wi-fi-80211s-mesh-networking-for-improved-connection-speed--reliability)
  - [Configure WLAN roaming on your primary OpenWrt Wi-Fi router](#configure-wlan-roaming-on-your-primary-openwrt-wi-fi-router)
  - [Configure 802.11s wireless mesh networking on your primary OpenWrt Wi-Fi router](#configure-80211s-wireless-mesh-networking-on-your-primary-openwrt-wi-fi-router)
  - [Install OpenWrt on a second Wi-Fi router](#install-openwrt-on-a-second-wi-fi-router)
  - [Configure secondary OpenWrt device as a "dumb" Wi-Fi Access Point](#configure-secondary-openwrt-device-as-a-dumb-wi-fi-access-point)
  - [Configure and test 802.11s mesh network connection between OpenWrt devices](#configure-and-test-80211s-mesh-network-connection-between-openwrt-devices)
  - [Next steps](#next-steps)

With a Wi-Fi router with OpenWrt firmware installed and Wi-Fi network configured, an optional step to improve Wi-Fi range and speed is to configure a secondary OpenWrt Wi-Fi Access Point (AP). The primary and secondary OpenWrt devices are connected using 802.11s wireless mesh networking, with no wired ethernet network cabling required.

*If you don't have a OpenWrt router with a Wi-Fi network configured yet, then review [Installing OpenWrt on a Wi-Fi router](Installing-OpenWrt-on-a-Wi-Fi-router.md) guide first.*  

To do so, you'll need to complete these steps
1. Configure WLAN roaming on your primary OpenWrt Wi-Fi router
2. Configure 802.11s wireless mesh networking on your primary OpenWrt Wi-Fi router
3. Install OpenWrt on a second Wi-Fi router 
4. Configure secondary OpenWrt device as a "dumb" Wi-Fi Access Point
5. Configure and test 802.11s mesh network connection between OpenWrt devices
6. Configure wireless networks on your secondary OpenWrt device

The instructions below were tested on OpenWrt 23.05 release.

## Configure WLAN roaming on your primary OpenWrt Wi-Fi router
Enable *WLAN roaming* so that when you have multiple Wi-Fi Access Point devices, your mobile Wi-Fi devices can seemlessly switch Wi-Fi Access Points and connect to the Wi-Fi Access Point with the best signal strength. 

1. Navigate to **Network → Wireless** page, then select *edit* button next to your Wi-Fi network. Under *Interface configuration* section, select *WLAN roaming* tab, then select checkbox for *802.11r Fast Transition*.
2. Under *Mobility Domain*, enter a 4 digit hexadecimal value (ex: 1a2b).


## Configure 802.11s wireless mesh networking on your primary OpenWrt Wi-Fi router
First, update your primary OpenWrt Wi-Fi router's software and configuration to support 802.11s wireless mesh network.

1. In a web browser on your computer, navigate to http://192.168.1.1/ or http://openwrt.lan/ address to view the OpenWrt admin web site.  
2. If you didn't customize the OpenWrt firmware image to include `wpad-mesh-mbedtls` and `mesh11sd` software packages, then navigate to **System → Software** page, select *Update lists* button and wait for OpenWrt to download the latest list of available software packages. Next, select *Installed* tab, and remove any packages that begin with `wpad`. Then, select *Available* tab, and install `wpad-mesh-mbedtls` and `mesh11sd` software packages. Reboot your OpenWrt device. Under *Software* page, double check the *Installed* tab to verify `wpad-mesh-mbedtls` and `mesh11sd` software packages were installed.  
3. Next, configure OpenWrt to create a 802.11s wireless mesh network. Navigate to **Network → Wireless** page, find your device's 2.4GHz 802.11n radio, and select *Add* button.  
   1. Under *Interface Configuration* section, *General Setup* tab, under *Mode* menu, select `802.11s`. 
   2. Enter the network name, such as *MeshLink*. This network name is broadcasted and visible by nearby Wi-Fi client devices.
   3. Under *Network*, select `lan`. If you're using network segmentation with VLANs, then select a single VLAN network. Don't select multiple networks, as 802.11s mesh network doesn't support VLAN tagging.  
   4. Under *Wireless Security* tab, under *Encryption* menu, select `WPA3-SAE (Strong security)`
   5. Under *Key*, enter a new password to use. This is different password than the Wi-Fi network password used to connect Wi-Fi client devices, and is only used by your OpenWrt device.

*Note*: You can use any available wireless radio for the wireless mesh network, but using a lower frequency like 2.4GHz instead of 5GHz provides better connection performance through walls & ceilings.

##  Install OpenWrt on a second Wi-Fi router
Follow the same steps as [Installing OpenWrt on a Wi-Fi router](Installing-OpenWrt-on-a-Wi-Fi-router.md) guide, with the small changes below. 
1. Use [OpenWrt firmware-selector](https://firmware-selector.openwrt.org/) to customize the `sysupgrade` OpenWrt firmware for your device hardware. Select *Customize installed packages* link, then under "Installed Packages", change `wpad-basic-mbedtls` to `wpad-mesh-mbedtls` package and add `mesh11sd` package. Then select *Request Build* button. After the build is completed, then select *Sysupgrade* button to download your customized OpenWrt firmware image that supports 802.11s mesh networking.  
2. Skip the last step to connect the secondary OpenWrt Wi-Fi router to your internet modem or gateway to test & verify internet connectivity.

## Configure secondary OpenWrt device as a "dumb" Wi-Fi Access Point
The secondary OpenWrt device configuration needs to be updated to act as a "dumb" Wi-Fi Access Point.

1. To log into OpenWrt and change settings, temporarily connect a wired ethernet cable from your computer to the `LAN` ethernet port (not the *Internet/WAN* port) on your **secondary** OpenWrt Wi-Fi Access Point. Do not connect your **secondary** OpenWrt Wi-Fi Access Point to your primary OpenWrt Wi-Fi router yet or to your Internet modem or gateway.  
2. In a web browser on your computer, navigate to http://192.168.1.1/ or http://openwrt.lan/ address to view the OpenWrt admin web site. Double check you are connected to your secondary OpenWrt Wi-Fi Access Point and not connected to your primary OpenWrt Wi-Fi router.  

You should see a login page like yet this:  
![Image](OpenWrt-essential-Wi-Fi_1.jpg)

3. Follow the steps in [OpenWrt Dumb AP configuration instructions](https://openwrt.org/docs/guide-user/network/wifi/dumbap#configuration_via_luci_the_openwrt_web_interface) to configure your secondary OpenWrt Wi-Fi Access Point to use a different IP address in the same subnet to avoid address conflict with your primary OpenWrt Wi-Fi router, such as *192.168.1.2*, use the IP address of your primary OpenWrt (*192.168.1.1*) for DNS, disable redundant functionality like firewall, DHCP server, DNS server, and WAN interface. After applying the changes to your Wi-Fi Access Point, temporarily connect a wired ethernet cable from your primary OpenWrt Wi-Fi router's LAN port to your secondary OpenWrt Wi-Fi Access Point's LAN port.  
4. Configure the same wireless network settings on your secondary OpenWrt Wi-Fi Access Point, including *WLAN roaming* settings. For instructions on enabling WLAN roaming, follow the same steps as [Configure WLAN roaming on your primary OpenWrt Wi-Fi router](#configure-wlan-roaming-on-your-primary-openwrt-wi-fi-router).   
5. Test and verify Internet connectivity. Navigate to your secondary OpenWrt device's IP address (*192.168.1.2*) to login to OpenWrt.  
6. Enter your password and login to OpenWrt. Navigate to **Network → Diagnostics** page, then select **IPv4 Ping** button to ping *openwrt.org* to verify your secondary OpenWrt device can connect to the your Internet.   

## Configure and test 802.11s mesh network connection between OpenWrt devices
Now that your primary OpenWrt Wi-Fi router has wireless mesh network configured and your secondary OpenWrt device is configure as a "dumb" Wi-Fi Access Point, the next step is to configure wireless mesh network on your secondary OpenWrt Wi-Fi Access Point and test wireless mesh network connectivity between your OpenWrt devices.  

1. Navigate to http://192.168.1.2/ or the IP address of your secondary OpenWrt device, then follow the same steps as [Configure 802.11s wireless mesh networking on your primary OpenWrt Wi-Fi router](#configure-80211s-wireless-mesh-networking-on-your-primary-openwrt-wi-fi-router) to create a 802.11s wireless mesh network.
2. Verify wireless mesh network connectivity between your OpenWrt devices. 
   1. Navigate to http://192.168.1.1/ or http://openwrt.lan/ address to view the OpenWrt admin web site for your primary OpenWrt Wi-Fi router.
   2. On **Status → Overview** page, in *Associated Stations* section, look for *Mesh Point* client. 
3. Disconnect the temporary wired ethernet cable that connects the LAN ports of your OpenWrt primary Wi-Fi router and your secondary Wi-Fi Access Point. 
4. Verify you can still connect to your secondary Wi-Fi Access Point by navigating to http://192.168.1.2/ or the IP address of your secondary OpenWrt device.  

## Next steps
Now that you completed configuring a secondary OpenWrt Wi-Fi Access Point (AP) to improve your Wi-Fi range and speed, you can continue to improve your Wi-Fi network with the following guides.

1. Configuring OpenWrt with additional Guest Wi-Fi network - coming soon
2. Configuring Wireguard VPN remote access - coming soon
