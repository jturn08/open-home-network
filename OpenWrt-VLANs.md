
# Configure OpenWrt router and firewall VLANs

1. Add VLAN IDs to Network Switch configuration
2. Add new network device and network interface for each VLAN
3. Configure Firewall rules for each VLAN
4. Add Wireless network for each VLAN interface



### Add VLAN IDs to Network Switch configuration
In OpenWrt LuCi Network\Switch page, select **Add VLAN** button, then enter the VLAN IDs and description that matches the VLAN IDs from your router configuration.

Select "tagged" for the CPU that corresponds to the LAN interface (`eth1`) and "off" for the other CPU.

### Add new network interface for each VLAN
Update LAN network device and network interface to use VLAN ID.  

In OpenWrt LuCi Network\Interfaces page, select Devices tab, then find the `br-lan` bridge device, then select **Configure** button. 
1. Under *Bridge ports*, select the Switch VLAN that corresponds to the VLAN ID (ex: `Switch VLAN: "eth1.10"`).  

Add a new network device for each VLAN (ex: Guest).  

In OpenWrt LuCi Network\Interfaces page, select Devices tab, then select **Add device configuration** button.
1. Under *Device type*, select `Bridge device`.
2. Under *Device name*, enter `br-guest` . Under *Bridge ports*, select 
3. Under *Bridge ports*, select the Switch VLAN that corresponds to the VLAN ID (ex: `Switch VLAN: "eth1.6"`).  

In OpenWrt LuCi Network\Interfaces page, select Interfaces tab, then select **Add new interface** button.
1. Under *Name*, enter `Guest`
2. Under *Protocol*, select `Static address`
3. Under *Device*, select the bridge device created in the previous step (ex: `br-guest`)
4. Select **Create interface** button.
5. Under *IPv4 address*, enter the access points's IP address for the VLAN (ex: `192.168.6.2`) 
6. Under *IPv4 netmask*, select `255.255.255.0`.
7. Select *DHCP Server* tab, then select **Set up DHCP Server** button.

### Configure Firewall rules for each VLAN
In OpenWrt LuCi Network\Firewall page, 