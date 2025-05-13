# How to assign a fixed IP address to a NAT gateway



## Scenario description {#case-description}

You need to assign an IP address (or a pool of IP addresses) to your NAT gateway.

## Solution {#case-resolution}

A [NAT gateway](../../../vpc/concepts/ips) provides an IP address from a dedicated range of public IP addresses, so you cannot assign a static IP. If your scenario requires a static IP address, we recommend considering a [NAT instance](../../../solutions/routing/nat-instance).
