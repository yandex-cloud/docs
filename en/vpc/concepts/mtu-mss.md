---
description: "MTU is the maximum size of a data packet, in bytes, that can be communicated over a network segment. The standard MTU is 1500 bytes, but MTUs may vary in different networks that packets are transmitted through."
keywords:
  - mtu
  - what is mtu
---

# MTU and TCP MSS

[MTU](https://en.wikipedia.org/wiki/Maximum_transmission_unit) is the maximum size of a data packet, in bytes, that can be communicated over a network segment.

The standard MTU is 1500 bytes, but MTUs may vary in different networks that packets are transmitted through. For example, when [DDoS Protection](../ddos-protection/index.md) or VPN tunnels are used, the MTU value should be lower to make sure that packets are not lost. Packet loss due to MTU problems may look like an unresponsive TCP session, for example, during the TLS Handshake or SSH access.

There are several ways to impact the size of transmitted packets:
1. Set the MTU through your VM interface: this will affect all types of transmitted packets.
1. Set the TCP [MSS](https://en.wikipedia.org/wiki/Maximum_segment_size). The TCP MSS can only be set for certain packets, for example, those passed via the default route.


If DDoS Protection is enabled, we recommend setting the MTU to 1450 (if you need to limit the size of all packets), and the TCP MSS to 1410 (if you need to limit the size of TCP packets only).


If you use VPN tunnels, reduce the MTU and TCP MSS values to the size of the tunnel headers and TCP headers that are used.