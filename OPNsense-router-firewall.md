
## Segment network into trusted and untrusted IoT networks with VLANs

1. Create a VLAN interface for each VLAN tag  
2. Add VLAN interfaces to assignments
3. Enable VLAN interface and configure router IPv4 local address
4. Enable IPv4 DHCP server
5. Configure firewall rules for each VLAN

### Create a VLAN interface for each VLAN tag  
On **Interfaces:Other Types:VLAN** page, create a new VLAN interface for each VLAN tag.  

Parent interface | VLAN tag | Description
-|:-:|-
igb0 (LAN)|4|IoT
igb0 (LAN)|6|Guest
igb0 (LAN)|8|Home
igb0 (LAN)|10|Management

### Add VLAN interfaces to assignments
On **Interfaces: Assignments** page, choose the VLAN interfaces created and select **Add**.  

### Enable VLAN interface and configure router IPv4 local address
On the interface page for each VLAN (ex: **Interface:[Home]** ), select **Enable interface** checkbox.  

On the same page, assign a static IPv4 address so that your OPNsense device is accessible by client devices in that VLAN network. Set IPv4 Configuration Type as **Static IPv4**, then enter the static IPv4 address and select **24** subnet mask for 256 address.

VLAN tag | Description | IPv4 address range
:-:|-|-
4|IoT|192.168.4.1/24
6|Guest|192.168.6.1/24
8|Home|192.168.8.1/24
10|Management|192.168.10.1/24

### Enable IPv4 DHCP server
On the Services: DHCPv4 page for each VLAN (**Services:DHCPv4:[Home]** ), select "Enable DHCP server on this interface" checkbox.  

Under **Range**, enter the IPv4 address range to assing to client devices.  

### Configure firewall rules for each VLAN
For the LAN interface, OPNsense configures default rules to allow LAN traffic to any destination and port.  

For custom VLAN interfaces, OPNsense configures default "fail secure" rules that blocks all traffic, so you'll need to create custom rules to allow some types of traffic. OPNsense firewall matches rules in order.

Select "Add" button, then add the below rules.

IoT network
Allow local DNS
Block outbound DNS
Block firewall admin ports
Allow diagnostic ping
Allow outbound to local HomeAssistant
Allow Inbound From TrustedLocalSubnets
Block Outbound to TrustedLocalSubnets
Block Outbound to Guest network
Allow internet

Guest network
Allow local DNS
Block outbound DNS
Block firewall admin ports
Allow diagnostic ping
Allow outbound to local printer
Allow Inbound From TrustedLocalSubnets
Block Outbound to RFC1918 local IPv4 addresses
Allow internet

## Sources  
https://www.youtube.com/watch?v=y6Ewly5-WvI
https://www.youtube.com/watch?v=b2w1Ywt081o
