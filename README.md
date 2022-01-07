# open-home-network
Setup guide for advanced home wireless networking with better security using open source software and low cost hardware

## Overview
There so are many choices when setting up advanced home wireless network that it can be overwhelming. This guide is for anyone who wants to upgrade their home wireless network from a single Wi-Fi router device to advanced home network  with better security using open source software and low cost hardware. 

Features:
- Separate Guest Wi-Fi network
- Separate Wi-Fi network for untrusted smarthome IOT devices
- Advanced firewall
- VPN (ex: Wireguard)
- Network level blocking of ads & trackers

Ubiquity Unifi products are popular and provide these features, but the same scenarios can be accomplished at a lower cost with more configuration flexibility by using open source software.

Software & hardware used
- PfSense or OPNsense on an old PC for routing & firewall
- OpenWRT on an old compatible Wi-Fi router for Wi-Fi Access Point and managed switching
- Managed switch that supports VLANs
