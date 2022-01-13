# open-home-network
This guide shares an example of deploying an advanced home wireless network with better security using open source software and low cost hardware.

*(This guide is a work in progress)*

## Overview
There so are many choices when setting up advanced home wireless network that it can be overwhelming. This guide is for anyone who wants to upgrade their home wireless network from a single or mesh Wi-Fi router to an advanced home network with better security using open source software and low cost hardware.

### Features
- Separate Guest WiFi network
- Separate WiFi network & wired network for untrusted smarthome IOT devices
- Advanced stateful firewal
- VPN (ex: OpenVPN and Wireguard)
- Ad blocker (ex: [AdGuardHome](https://github.com/AdguardTeam/AdGuardHome))
- Web filtering
- QOS / rate limiter


### Software & Hardware
- pfSense or OPNsense on an old PC with extra network adapter for routing & firewall
- OpenWRT on an old compatible Wi-Fi router for Wi-Fi Access Point and managed switching
- Managed switch that supports VLANs and/or unmanaged switch for wired (LAN) devices
- Modem or internet gateway (ex: cable modem)

### Comparison to Alternatives
Mesh Wi-Fi systems with 2 or 3 access points are popular for simple home Wi-Fi networks and have fast speeds with the latest generation 802.11ax (WiFi 6) devices.
For more advanced home networks, Ubiquity Unifi is popular and makes a variety of advanced router & wireless access point devices that  

#### Advantages
- For compatible hardware, open source software provides longer security update lifecycle and can add new functionality over time compared to commercial products. For example, [Google is discontinuing support for OnHub Wi-Fi routers after 6 years](https://support.google.com/googlenest/answer/11257354), after which users won't be way to change network settings. 
- More features & configuration flexibilty on low end hardware. Running OpenWRT on an old consumer-grade Wi-Fi router can enable advanced networking functionality like VLANs.
- More security features 
- Reduce e-waste by repurposing older hardware. An old PC that may be too slow for running Windows 10 day to day can still run pfSense or OPNsense with good performance.

#### Disadvantages
- Open source software can run only on some hardware. OpenWRT is incompatible with most Wi-Fi routers that use Broadcom chipset due to poor driver support.
- For example, OpenWRT is typically incompatible with the latest Wi-Fi routers as it takes some time for a developer to add support for a new device. 
- More difficult setup. Setting up & configuring OpenWRT or pfSense/OPNsense requires more expertise and is not easy for beginners. This guide is meant to help.
- DIY support through internet forums. If there's a problem, you may have to spend a lot time yourself to diagnose and troubleshoot. Netgate offers 24x7 paid support starting at $400/yr.

## Hardware choices

### pfSense or OPNsense
pfSense and OPNsense runs on x86 based PCs and network appliances.

#### Network Appliance
While pfSense and OPNsense software is free & open source, each software project is affliated with official hardware manufacturer ([Netgate](https://www.netgate.com/pfsense-plus-software/how-to-buy#appliances) with pfSense & [Deciso](https://www.deciso.com/product-catalog/) with OPNsense) that create hardware specifically designed to run the software. Buying the official hardware appliances financially supports the development of the software, but costs more than installing the software on an old PC.  

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


#### Old PC + PCIe Network Card
The easiest option is to use an old desktop PC (ex: Intel 4th gen Core i3 dual core CPU) with a PCIe x4 expansion slot. But the desktop PC needs to meet a few special requirements: 
- You'll need a PC with at least 2 network ports (1 for WAN and 1 for LAN) or a PCIe  2.x x4 expansion slot to add a network card.
- PC with low power consumption. The PC will be running 24x7, so electricity costs add up. **1 Watt = ~$1 of electricity per year.**  

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

#### DIY network appliance (Thin Client + PCIe Network Card)
Thin clients are low power PCs originally designed for office remote desktop use that is a popular choice for running pfSense or OPNsense as they use similar hardware (ex: [AMD G-series embedded CPUs](https://www.amd.com/en/products/embedded-thin-client-solutions)) as pfSense/OPNsense network appliances at a lower cost. Used models from corporate leases can be found in good condition on eBay for $80 to $200. Choose a model from last 3 to 8 years with dual or quad core embedded CPUs, upgradeable RAM slots, upgradeable storage, and with a PCIe x4 expansion slot for adding a network card. Using a USB network adapter is not recommended due to slower speeds and network instability.

Popular thin-client choices:
- HP T730, T620 plus, T610 plus thin client with low profile PCIe x4 expansion slot
- Dell Wyse 5060 extended thin client with low profile PCIe x4 expansion slot
- Fujitsu Futuro S930, S920, S900 thin client with low profile PCIe x4 expansion slot

#### PCIe Network Card
If your PC only has 1 network port, then you'll need to add a PCIe network card to add additional network ports so you can use 1 port for WAN and 1 or more ports for LAN network.  
Used server-grade dual-port and quad-port 1Gbps PCIe network cards can be found on eBay for $30-$60. [ServeTheHome forum has a great list with eBay search links and pfSense compatibility.](https://forums.servethehome.com/index.php?threads/list-of-nics-and-their-equivalent-oem-parts.20974/post-195275)

Popular network card choices compatible with pfSense and OPNsense:
- Intel i340-T4 quad-port or i340-T2 dual-port 1Gbps (PCI-E 2.0 x4, 4.3W)  
- Intel i350-T4 quad-port or i350-T2 dual-port 1Gbps (PCI-E 2.1 x4, 5W)  
  

*Note 1:* If your thin client or PC only supports half-height low profile cards, you can still buy a card with a full height bracket and buy the low profile bracket separately and then swap the brackets.  
*Note 2:* pfSense and OPNsense are based on the BSD operating system rather than Linux, so hardware driver support is more limited. 