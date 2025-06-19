---
title: Networking in {{ baremetal-full-name }}
description: In this article, you will learn about public and private networks in {{ baremetal-full-name }}.
---

# Network

![baremetal-network](../../_assets/baremetal/baremetal-network.svg)

## Public network {#public-network}

A network with internet access, to which all servers are physically connected. On [some](./network-restrictions.md#blocked-ports) TCP and UDP ports, network traffic between the private network and the internet is limited.

When working with a public network and internet access, make sure to comply with the [terms of use](https://yandex.ru/legal/cloud_termsofuse/).

### Ephemeral public subnet {#ephemeral-public-subnet}

An _ephemeral public subnet_ is a public subnet of the `/31` size that is randomly assigned to a {{ baremetal-name }} server from the range of public IPv4 addresses reserved for {{ baremetal-full-name }}.

Ephemeral public subnets are assigned to servers with **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** set to `{{ ui-key.yacloud.baremetal.label_public-ip-ephemeral }}` in their network parameters.

[DHCP is enabled](./dhcp.md#dhcp-ephemeral-public-subnet) in an ephemeral public subnet.

The lifecycle of an ephemeral public subnet depends on the lifecycle of the server this subnet is assigned to. When a server lease is cancelled, the ephemeral public subnet assigned to it will be automatically deleted and the server’s public IPv4 address will be released back to the {{ baremetal-name }} address pool.

You can [convert](../operations/reserve-public-subnet.md#transform-ephemeral-to-dedicated) an ephemeral public subnet to a [dedicated public subnet](#public-subnet) of size `/31`.

### Dedicated public subnet {#public-subnets}

A _dedicated public subnet_ is a public subnet made up of an IP address range that will be available to your servers in the selected [pools](./servers.md#server-pools). The IP address range is assigned to the dedicated public subnet automatically.

You can [order](../operations/reserve-public-subnet.md) a dedicated public subnet in the following sizes:

| Subnet size | Total number of IP addresses | Available IP addresses |
| --- | --- | --- |
| `/31`^1^ | 2 | 1 |
| `/29` | 8 | 6 |
| `/28` | 16 | 14 |
| `/27`^2^ | 32 | 30 |
| `/26`^2^ | 64 | 62 |
| `/25`^2^ | 128 | 126 |
| `/24`^2^ | 256 | 254 |

^1^ You can order a public subnet of size `/31` only by [converting](../operations/reserve-public-subnet.md#transform-ephemeral-to-dedicated) an [ephemeral public subnet](#ephemeral-public-subnet).
^2^ To order public subnets with sizes `/27`, `/26`, `/25`, and `/24`, [contact]({{ link-console-support }}/tickets/create) support.

{% include [public-subnet-no-dhcp](../../_includes/baremetal/public-subnet-no-dhcp.md) %}

{% include [public-subnet-address-info](../../_includes/baremetal/public-subnet-address-info.md) %}

When you cancel the lease of a server which has a dedicated public subnet assigned to it, its public IPv4 address is released back to the dedicated public subnet’s address pool so you can later use it for another server.

In {{ baremetal-full-name }}, dedicated public subnets are [billable](../pricing.md). The minimum lease period for a dedicated public subnet is one month, so you cannot delete such a subnet during the first month after the order date.

## Private network {#private-network}

A local network to which all servers are connected. Logically joins servers into isolated user networks.

### Private subnet {#private-subnet}

A network physically bounded by the network equipment of a single pool, isolated both from the internet and from other users' networks.

Within a single pool, L2 connectivity (VLAN) and L3 connectivity (VRF) are possible between leased servers. Between servers physically hosted in different pools, only L3 connectivity is available.

To configure networking between servers from different [pools](./servers.md), select the same [VRF](#vrf-segment) for the appropriate subnets under **Routing settings**.

{% include [internal-addressing-rules](../../_includes/baremetal/internal-addressing-rules.md) %}

### Virtual network segment (VRF) {#vrf-segment}

To provide L3 routing, private subnets with configured routing are aggregated into virtual network segments (VRFs).

Servers from the same or different pools connected to different private subnets aggregated into a VRF segment will be able to maintain L3 networking between them.

### Private connection to cloud networks {#private-connection-to-vpc}

To set up network connectivity between {{ baremetal-name }} [servers](./servers.md), {{ vpc-full-name }} private [subnets](../../vpc/concepts/network.md#subnet), and private subnets in the on-premise infrastructure, use [{{ interconnect-full-name }}](../../interconnect/concepts/priv-con.md).

## MAC addresses of network interfaces {#mac-addresses}

You can [look up](../operations/servers/get-info.md) the MAC addresses of the {{ baremetal-name }} server network interfaces on the server information page under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** and **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**.

#### See also {#see-also}

* [{#T}](./network-restrictions.md)