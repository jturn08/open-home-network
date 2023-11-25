# Configuring OpenWrt with an essential Wi-Fi network
- [Configuring OpenWrt with an essential Wi-Fi network](#configuring-openwrt-with-an-essential-wi-fi-network)
  - [Setup Wi-Fi Access Point](#setup-wi-fi-access-point)

*If you don't have a Wi-Fi router running OpenWrt and connected to the Internet yet, then review [Installing OpenWrt on a Wi-Fi router](Installing-OpenWrt-on-a-Wi-Fi-router.md) guide first.*  

Now that you have OpenWrt running on a Wi-Fi router and you've verified OpenWrt has Internet connectivity, the next step is to configure OpenWrt to create a Wi-Fi network. By default, OpenWrt disables Wi-Fi for security, so you'll need to login to OpenWrt to change Wi-Fi settings.  

The instructions below are for OpenWrt 22.03 version.

## Setup Wi-Fi Access Point
Temporarily connect a wired ethernet cable from your computer to the `LAN` ethernet port on your router and log into your router's OpenWrt administration web page.  

Next, go to **Network → Wireless** page.  
![Image](OpenWrt-essential-Wi-Fi_4.jpg)

This page displays a list of wireless radio chips in your Wi-Fi router. Most routers will display 2 wireless radios, a 802.11ac (5Ghz Wi-Fi 5) and 802.11n (2.4GHz Wi-Fi 4).  

For each of your radios, you can create a Wi-Fi network by selecting `Add` button. You can use the same network name and password for both 802.11ac (5Ghz) and 802.11bgn (2.4GHz) Wi-Fi networks, and client devices will automatically connect to the best Wi-Fi network.  

1. For the first Wi-Fi network, in **Device Configuration** section, select **Advanced Settings** tab, then in **Country Code** menu, select the  country code that corresponds to the location of your OpenWrt router. This ensures your OpenWrt device meets the legal regulations in your country.  
2. For each Wi-Fi network, then configure related settings
   1. In **Interface Configuration** section and **General Setup** tab, in "ESSID" field, enter your network name. 
   2. In **Interface Configuration** section and **Wireless Security** tab, in "Encryption" menu, select your desired encryption type. `WPA2-PSK` is recommended for home/small office networks.
   3. In **Interface Configuration** section and **Wireless Security** tab, in "Key" field, enter the Wi-Fi password client devices use when connecting to the Wi-Fi network. 
   4. In **Device Configuration** section and **General Setup** tab, in  **Operating frequency**, set the **Channel** and **Width** to the best performance for your area. In general, for best performance in North America, choose these channel settings:     
        | Mode | Channel     | Width  |
        | ---- | ----------- | ------ |
        | N    | 1, 6, or 11 | 20 MHz |
        | AC   | 149         | 80 Mhz |
   5. Select "Save" button, then edit the settings for the next Wi-Fi network. 
   6. Select "Save & Apply" button to apply changes. 

Now on your client device, open Wi-Fi settings, find the new Wi-Fi network you created, and enter the Wi-Fi password, and connect to the network.