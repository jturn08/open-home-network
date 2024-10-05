# Configuring OpenWrt VLAN to connect multiple Wi-Fi Access Points with wired connection and multiple logical networks (ex: home & guest network)

- [Configuring OpenWrt VLAN to connect multiple Wi-Fi Access Points with wired connection and multiple logical networks (ex: home \& guest network)](#configuring-openwrt-vlan-to-connect-multiple-wi-fi-access-points-with-wired-connection-and-multiple-logical-networks-ex-home--guest-network)
  - [Overview](#overview)
  - [VLAN](#vlan)

This guide describes configuring OpenWrt Wi-Fi router with multiple logical networks (ex: home & guest networks) using VLANs for better security and multiple Wi-Fi Access Points connected with wired Ethernet connection for better Wi-Fi range, speed and reliability.

 - Creating separate logical networks improves security compared to connecting all your devices in a single network as untrusted devices won't be connecting to the same network as trusted devices.
 - Connecting multiple Wi-Fi Access Points with wired Ethernet connection improves Wi-Fi range, speed and reliability, as each Wi-Fi Access Point will be transferring data over wired connection, leaving more wireless bandwidth available for client PCs and devices.
 
## Overview
 **Functionality**
- Multiple isolated networks for improved security
- Multiple Wi-Fi access points connected with wired ethernet network
- Wired ethernet networking (ex: Cat5e 1 Gbps)

**Components**
- Routing & Firewall: **OpenWrt** compatible Wi-Fi router
- Wi-Fi Access Point: **OpenWrt** compatible Wi-Fi router
- Wired network: **Wired ethernet network** connected to Wi-Fi router and client devices (PCs)

**Hardware**
- 2 or more **OpenWrt** compatible Wi-Fi routers
- **Wired ethernet network cables** between Wi-Fi router locations (ex: Cat5e 1 Gbps)
- **Managed wired ethernet network switch** or a Wi-Fi router with built in VLAN-enabled network switch with enough wired ports for connecting to modem, Wi-Fi routers, and any client devices.  

## VLAN
VLAN is the acronym for **V**irtual **L**ocal **A**rea **N**etwork, a logical partitioning of physical network connection on OSI layer 2.  

It is a way to keep network client devices separated from each other even if they use the same shared physical network. It works by adding a label (**VLAN ID**) on networking traffic, and network switches using this label to route the traffic to keep clients separate.

 - using [IEEE 802.1Q](https://en.wikipedia.org/wiki/IEEE_802.1Q)  
 - A single wired Ethernet network cable can transmit network traffic from multiple logically separate VLAN networks.  
 - A VLAN-capable **Managed network switch** device can configure an individual wired network port with **untagged VLAN ID** to allow only a specific logical VLAN network (ex: guest). A client PC connected to a managed network switch configured to a specific VLAN network would only communicate with other devices within the same VLAN network, and not be able to communicate to devices that are part of different VLAN network, even if physically connected to the same network switch.  
 - A VLAN-capable **Managed network switch** device can configure an individual wired network port with multiple **tagged VLAN IDs** to allow multiple logical VLAN networks (ex: home and guest). A Wi-Fi Access Point connected to a managed network switch configured this way would be able to broadcast different Wi-Fi network names, one for each logical network. Any client devices connecting to a Wi-Fi network would only be able to communicate with other devices within the same VLAN network (ex: guest), and not be able to communicate to devices that are part of a different VLAN network (ex: home).  