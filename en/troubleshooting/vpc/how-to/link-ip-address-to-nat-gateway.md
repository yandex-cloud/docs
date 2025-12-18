# How to assign a fixed IP address to a NAT gateway



## Case description {#case-description}

You need to assign an IP address or a pool of IP addresses to your NAT gateway.

## Solution {#case-resolution}

A NAT gateway provides an [IP address from a dedicated range of public IP addresses](../../../vpc/concepts/ips.md), so you cannot assign a static IP address. 
If your scenario requires a static IP address, you may want to consider using a [NAT instance](../../../tutorials/routing/nat-instance/index.md).
