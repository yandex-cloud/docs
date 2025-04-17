---
title: Networking in {{ baremetal-full-name }}
description: In this article, you will learn about public and private networks in {{ baremetal-full-name }}.
---

# Network

![baremetal-network](../../_assets/baremetal/baremetal-network.svg)

## Public network {#public-network}

A network with internet access, to which all servers are physically connected. On [some](./network-restrictions.md#blocked-ports) TCP and UDP ports, network traffic between the private network and the internet is limited.

When working with a public network and internet access, make sure to comply with the [terms of use](https://yandex.ru/legal/cloud_termsofuse/).

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

#### See also {#see-also}

* [{#T}](./network-restrictions.md)