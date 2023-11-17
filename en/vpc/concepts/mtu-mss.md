---
description: "MTU is the maximum size of a data packet, in bytes, that can be communicated over a network segment. Generally, MTU is 1500 bytes; however, MTUs may vary in different networks the packets are transmitted through."
keywords:
  - mtu
  - what is mtu
---

# MTU and TCP MSS

The maximum transmission unit ([MTU](https://en.wikipedia.org/wiki/Maximum_transmission_unit)) is the maximum size of a data packet, in bytes, that can be communicated over a [network](network.md#network) segment.

Generally, MTU is 1500 bytes; however, MTUs may vary in different networks the packets are transmitted through. For example, when using [{{ ddos-protection-full-name }}](../ddos-protection/index.md) or VPN tunnels, the MTU value should be lower to avoid losing packets. Packet loss due to MTU issues may look like an unresponsive TCP session, such as during a TLS handshake or SSH access.

There are two ways to impact the size of transmitted packets:

1. Set the MTU through your [VM](../../compute/concepts/vm.md) interface: this will affect all types of transmitted packets.
1. Set the TCP [MSS](https://en.wikipedia.org/wiki/Maximum_segment_size). The TCP MSS can only be set for certain packets, for example, those transmitted through the default route.


{% note alert %}

When you enable {{ ddos-protection-name }}, you should set the MTU to 1450 bytes if you need to limit the size of all packets, and the TCP MSS to 1410 if you only need to limit the size of TCP packets.

You can learn how to configure the MTU for various platforms in {{ yandex-cloud }} [here](../operations/adjust-mtu-ddos-protection.md).

{% endnote %}


If you use VPN tunnels, reduce the MTU and TCP MSS values to the size of the tunnel headers and TCP headers, respectively.
