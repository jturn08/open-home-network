# open-home-network

- [open-home-network](#open-home-network)
  - [Overview](#overview)
    - [Features](#features)
    - [Software \& Hardware](#software--hardware)
    - [Comparison to Alternatives](#comparison-to-alternatives)
      - [Advantages](#advantages)
      - [Disadvantages](#disadvantages)
  - [Recommended setup options](#recommended-setup-options)
    - [Basic setup: Wi-Fi](#basic-setup-wi-fi)
    - [Deluxe setup: Wi-Fi and wired network](#deluxe-setup-wi-fi-and-wired-network)
    - [Advanced setup: Wi-Fi and wired network with advanced networking](#advanced-setup-wi-fi-and-wired-network-with-advanced-networking)
  - [Software \& Hardware](#software--hardware-1)
    - [OpenWrt](#openwrt)
      - [Hardware choices](#hardware-choices)
    - [pfSense or OPNsense](#pfsense-or-opnsense)
      - [Hardware choices](#hardware-choices-1)
      - [Network Appliance](#network-appliance)
      - [PC + PCIe Network Card](#pc--pcie-network-card)
      - [Thin Client + PCIe Network Card (DIY network appliance)](#thin-client--pcie-network-card-diy-network-appliance)
      - [PCIe Network Card](#pcie-network-card)
    - [Managed wired network switch](#managed-wired-network-switch)

This guide describes deploying an advanced home wireless network with improved security, ease of management, and functionality using open source software and low cost hardware.

*(This guide is a work in progress)*

## Overview
There are many choices for home Wi-Fi networking that it can be overwhelming. This guide is for anyone who wants to upgrade their home wireless network from a consumer single or mesh Wi-Fi router to an advanced modular, upgradeable home Wi-Fi network using open source software and low cost hardware.

### Features
- Separate Guest Wi-Fi network
- Separate Wi-Fi & wired network for untrusted smarthome and IoT devices
- Advanced stateful firewall
- VPN (ex: OpenVPN and Wireguard) remote access
- Custom DNS ad blocking (ex: [AdGuardHome](https://github.com/AdguardTeam/AdGuardHome))
- Web filtering
- QOS / rate limiter

### Software & Hardware
- pfSense or OPNsense open source routing & firewall software running on an old PC with extra network adapter hardware
- OpenWRT open source software on a compatible Wi-Fi router for Wi-Fi Access Point and managed switching
- Managed wired network switch that supports VLANs
- Modem or internet gateway (ex: cable modem)

### Comparison to Alternatives
Consumer mesh Wi-Fi systems with 2 or 3 access points are popular for basic home Wi-Fi networks and have fast speeds with the latest generation 802.11ax (WiFi 6) devices.
For more advanced home networks, Ubiquity Unifi is popular and makes a variety of advanced router & wireless access point devices that  

#### Advantages
- For compatible hardware, open source software provides longer softwware support lifecycle and can add new functionality over time compared to commercial products. For example, [Google is discontinuing support for OnHub Wi-Fi routers after 6 years](https://support.google.com/googlenest/answer/11257354).
- More features & configuration flexibilty on low end hardware. Running OpenWRT on an old consumer-grade Wi-Fi router can enable advanced networking functionality like VLAN and VPN.
- Improved security with customized network segmentation and firewall rules
- Reduce e-waste by repurposing older hardware. An old PC that may be too slow for running Windows 10 can still run pfSense or OPNsense with good performance.

#### Disadvantages
- Open source software has limited hardware compatibility, and may not support some newer models, as it takes some time for developers to add support for a new device.
- More complex setup. Setting up & configuring OpenWRT or pfSense/OPNsense requires more technical expertise and is not easy for beginners, but this guide is meant to help.
- Limited professional technical support options, must troubleshoot issues yourself through internet forums. If there's a problem, you may have to spend a lot time yourself to diagnose and troubleshoot. 

## Recommended setup options
The number of components in your system depends on your desired functionality and network performance.  As the components are modular, you can start with basic setup, then move up to deluxe or advanced setups by incrementally adding more hardware. With open source software, it's easier to scale up to more powerful hardware while re-using the same software compared to switching between commercial platforms.

### Basic setup: Wi-Fi
The Basic setup is for a home with all client devices connecting wirelessly and no wired ethernet network cabling.

Functionality
- 1 or more Wi-Fi access points connected wirelessly forming single network
- Multiple segmented networks for improved security
- VPN remote access
- No wired ethernet network

Components
- Routing & Firewall: **OpenWrt** compatible Wi-Fi router
- Wi-Fi Access Point: **OpenWrt** compatible Wi-Fi router

### Deluxe setup: Wi-Fi and wired network
The Deluxe setup is for a home with client devices connecting wirelessly and with wired ethernet network, and requires Cat5e or better wired ethernet network cabling.

Functionality
- Multiple Wi-Fi access points connected with wired ethernet network
- Multiple segmented networks for improved security
- VPN remote access
- Wired ethernet networking

Components
- Routing & Firewall: **OpenWrt** compatible Wi-Fi router
- Wi-Fi Access Point: **OpenWrt** compatible Wi-Fi router
- Wired networks: Managed wired ethernet network switch connected to Wi-Fi router and client devices (PCs)

### Advanced setup: Wi-Fi and wired network with advanced networking
The Advanced setup uses Deluxe setup and uses has more powerful dedicated hardware for advanced routing & firewall functionality, and is for a home with multiple client devices connecting wirelessly and with wired ethernet network, and requires Cat5e or better wired ethernet network cabling. 

Functionality
- Multiple Wi-Fi access points connected with wired ethernet network
- Multiple segmented networks for improved security with advanced rules
- VPN remote access
- Wired ethernet networking

Components
- Routing & Firewall: **pfSense** or **OPNsense** compatible PC, thin client, or network appliance
- Wi-Fi Access Points: **OpenWrt** compatible Wi-Fi router
- Wired networks: Managed wired ethernet network switch connected to Wi-Fi router and client devices (PCs)

## Software & Hardware

### OpenWrt
OpenWrt is an open source Linux-based operating system software optimized to run on Wi-Fi routers and PCs, that supports configuration with command-line or web browser interfaces. It's used in all suggested setups.

OpenWrt supports features like 
- Wi-Fi configuration with Mesh support
- Multiple segmented networks to support separate Guest network and separate network for untrusted smarthome and IoT devices
- Advanced stateful firewall
- VPN (ex: OpenVPN and Wireguard) tunneling

#### Hardware choices
OpenWrt runs on some Wi-Fi routers. Below are  models with good OpenWrt support as of 2023:

- [Belkin RT3200](https://openwrt.org/toh/linksys/e8450) Wi-Fi 6 (802.11ax) 3200 Mbps max
- [Netgear R7800 Nighthawk X4S](https://openwrt.org/toh/netgear/r7800) Wi-Fi 5 (802.11ac) 2600 Mbps max

For a larger home with multiple rooms and multiple client devices, it's better to use multiple Wi-Fi cheaper access points than deploying a single more expensive Wi-Fi access point, as the wireless signal quality is greatly impacted by walls.

*Note:* OpenWrt compatibility and the ease of OpenWrt installation varies depending on the model of the Wi-Fi router, so it's a good idea to review the installation instructions and online discussions before deciding to purchase new hardware.

### pfSense or OPNsense
pfSense and OPNsense are advanced open source routing & firewall software that runs on a PC, thin client with extra network adapter hardware or a network appliance. It's used only in my Advanced setup, and is not needed in basic or deluxe setups.

Both pfSense and OPNsense support a variety of features like 
- Multiple segmented networks to support separate Guest network and separate network for untrusted smarthome and IoT devices
- Advanced stateful firewall
- VPN (ex: OpenVPN and Wireguard) remote access
- Custom DNS ad blocking (ex: [AdGuardHome](https://github.com/AdguardTeam/AdGuardHome))
- Web filtering
- QOS / rate limiter

#### Hardware choices
pfSense and OPNsense runs on x86 based PCs, thin clients, or network appliance hardware. 

#### Network Appliance
While pfSense and OPNsense software is free & open source, each software project is affliated with an official hardware manufacturer ([Netgate](https://www.netgate.com/pfsense-plus-software/how-to-buy#appliances) with pfSense & [Deciso](https://www.deciso.com/product-catalog/) with OPNsense) that create hardware specifically designed to run the software. Buying the official hardware appliances financially supports the development of the software, but costs more than installing the software on an old PC.  

|                              | Netgate 2100            | Netgate 5100                   | Deciso DEC600              | Deciso DEC630              |
| ---------------------------- | ----------------------- | ------------------------------ | -------------------------- | -------------------------- |
| Price (MSRP)                 | $349                    | $599                           | $499                       | $799                       |
| Processor                    | Dual core ARMv8 A53 CPU | Quad core Intel Atom C3558 CPU | Dual core AMD GX-210UA CPU | Quad core AMD GX-416RA CPU |
| RAM                          | 4 GB                    | 4 GB                           | 4 GB                       | 4 GB                       |
| Storage                      | 8 GB eMMC               | 8 GB eMMC                      | 16 GB eMMC                 | 128 GB SSD                 |
| Network ports                | 5x GbE                  | 6x GbE                         | 3x GbE                     | 4x GbE                     |
| AES-NI hardware acceleration | Yes                     | Yes                            | Yes                        | Yes                        |

Other manufacturers (not affliated with pfSense or OPNsense) sell similar network appliances designed to run pfSense or OPNsense. There are many manufacturers and models available, table below is just a sample.

|                              | Qotom Q330P                  | PC Engines APU.4D4        | Protectli Vault FW2B          | Protectli Vault FW4B          |
| ---------------------------- | ---------------------------- | ---------------------- | ----------------------------- | ----------------------------- |
| Price (street)               | $260                         | $276                   | $320                          | $450                          |
| Processor                    | Dual core Intel i3 4005U CPU | Quad core AMD GX-412TC | Dual core Intel Celeron J3060 | Quad core Intel Celeron J3160 |
| RAM                          | 8 GB                         | 4 GB                   | 4 GB                          | 8 GB                          |
| Storage                      | 128 GB SSD                   | 30 GB SSD              | 32 GB SSD                     | 120 GB SSD                    |
| Network ports                | 2x GbE                       | 4x GbE                 | 2x GbE                        | 4x GbE                        |
| AES-NI hardware acceleration | Yes                          | Yes                    | Yes                           | Yes                           |

*(Models and prices valid as of Jan 2022)*

#### PC + PCIe Network Card
The easiest option is to use an old desktop PC (ex: Intel 4th gen Core i3 dual core CPU) with a PCIe 2.x x4 expansion slot. But the desktop PC needs to meet a few special requirements: 
- You'll need a PC with at least 2 network ports (1 for WAN and 1 for LAN) or a PCIe 2.x x4 expansion slot to add a network card.
- PC with low power consumption is preferred. The PC will be running 24x7, so electricity costs add up as each Watt of electricity will cost ~$1 to run 24/7 for a year.

[OPNsense](https://docs.opnsense.org/manual/hardware.html) provides hardware requirements table below

|           | Minimum             | Reasonable          | Recommended            |
| --------- | ------------------- | ------------------- | ---------------------- |
| Processor | 1 GHz dual core CPU | 1 GHz dual core CPU | 1.5 GHz multi core CPU |
| RAM       | 2 GB                | 4 GB                | 8 GB                   |
| Storage   | 4 GB SD card        | 40 GB SSD           | 120 GB SSD             |

- **Minimum** = Run all OPNsense standard features that do not need disk writes, means you can run all standard features, except for the ones that require disk writes, e.g. a caching proxy (cache) or intrusion detection and prevention (alert database)
- **Reasonable** = Run all OPNsense standard features, means every feature is functional, but perhaps not with a lot of users or high loads.
- **Recommended** = Run all OPNsense standard features, means every feature is functional and fits most use cases.

*Note: Hardware requirements varies based on features enabled and required throughput.*

#### Thin Client + PCIe Network Card (DIY network appliance)
Thin clients are low power office PCs originally designed for remote desktop use that are popular choice for running pfSense or OPNsense software. They use similar hardware (ex: [AMD G-series embedded CPUs](https://www.amd.com/en/products/embedded-thin-client-solutions)) as pfSense/OPNsense network appliances at a lower cost. Used models can be found in good condition on eBay for $80 to $200. Choose a model from the last 3 to 8 years with dual or quad core embedded CPUs, upgradeable RAM slots, upgradeable storage, and with a PCIe 2.0 x4 expansion slot for adding an extra network card. Using a USB network adapter is not recommended due to slower speeds and network instability.

Popular thin-client choices:
- HP T730, T620 plus, T610 plus thin client with low profile PCIe 2.0 x4 expansion slot
- Dell Wyse 5070 Extended, Dell Wyse 5060 Extended thin client with low profile PCIe 2.0 x4 expansion slot
- Fujitsu Futuro S930, S920, S900 thin client with low profile PCIe 2.0 x4 expansion slot

#### PCIe Network Card
If your PC only has 1 network port, then you'll need to add a PCIe network card to add additional network ports. You'll need at least 2 network ports: 1 port for WAN (internet connection) and 1 port for LAN (local home network).
Used but high quality server-grade dual-port and quad-port 1Gbps PCIe network cards can be found used on eBay for $30-$60. [ServeTheHome forum has a great list with eBay search links and pfSense compatibility.](https://forums.servethehome.com/index.php?threads/list-of-nics-and-their-equivalent-oem-parts.20974/post-195275)

Popular network card choices compatible with pfSense and OPNsense:
- Intel i340-T2 dual-port 1Gbps or i340-T4 quad-port  (PCI-E 2.0 x4, 4.3W)  
- Intel i350-T2 dual-port 1Gbps or i350-T4 quad-port  (PCI-E 2.1 x4, 5W)  

*Note 1:* If your thin client or PC only supports half-height low profile cards, you can still buy a card with a full height bracket and then swap to a low profile bracket. 
*Note 2:* pfSense and OPNsense are based on the BSD operating system rather than Linux, so hardware driver support is more limited. 

### Managed wired network switch
A wired network switch is to used in homes to connect different PCs together into a network using wired ethernet cables. Wired network switches come in either unmanaged or managed versions. An unmanaged wired network switch supports a single network for all connected wired devices, while a managed wired network switch can support logically isolated networks even though the physical wired ethernet cables are all connected to a single device.  
A wired network switch is used in my Deluxe and Advanced setups, and is not needed in my basic setup. A managed wired network switch that supports VLAN tagging is required if you want to create isolated networks like a guest Wi-Fi network and connect multiple Wi-Fi Access Points together using wired ethernet cables for the best performance.  