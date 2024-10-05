#!/bin/sh
#/etc/hotplug.d/iface/30-wanled
#written for TP-LINK Google OnHub LED names in mind, will need change values for other devices

[ "$INTERFACE" = wan ] || exit 0
if [ "$ACTION" = ifup ] ; then
  # WAN interface went up
  for i in 0 1 2 3 4 5 
  do
    echo "default-on" > /sys/class/leds/blue:status-$i/trigger
    echo "none" > /sys/class/leds/green:status-$i/trigger
    echo "none" > /sys/class/leds/red:status-$i/trigger
  done
fi
if [ "$ACTION" = ifdown ] ; then
  # WAN interface went down
  for i in 0 1 2 3 4 5 
  do
    echo "none" > /sys/class/leds/blue:status-$i/trigger
    echo "none" > /sys/class/leds/green:status-$i/trigger
    echo "default-on" > /sys/class/leds/red:status-$i/trigger
  done
fi
if [ "$ACTION" = free ] ; then
  # WAN wire disconnected physically
  for i in 0 1 2 3 4 5 
  do
    echo "none" > /sys/class/leds/blue:status-$i/trigger
    echo "none" > /sys/class/leds/green:status-$i/trigger
    echo "none" > /sys/class/leds/red:status-$i/trigger
  done
fi
exit 0