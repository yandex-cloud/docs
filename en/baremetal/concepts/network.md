---
title: Networking in {{ baremetal-full-name }}
description: In this article, you will learn about public and private networks in {{ baremetal-full-name }}.
---

# Network

![baremetal-network](../../_assets/baremetal/baremetal-network.svg).

{% note info %}

You will be able to use {{ interconnect-name }} with {{ baremetal-name }} servers starting April 2025.

{% endnote %}

## Public network {#public-network}

A network with internet access, to which all servers are physically connected. On [some](./traffic-restrictions.md) TCP and UDP ports, network traffic between the private network and the internet is limited.

## Private network {#private-network}

A local network to which all servers are connected. Logically joins servers into isolated user networks.

### Private subnet {#private-subnet}

A network physically bounded by the network equipment of a single pool, isolated both from the internet and from other users' networks.

Within a single pool, L2 connectivity (VLAN) and L3 connectivity (VRF) are possible between leased servers. Between servers physically hosted in different pools, only L3 connectivity is available.

To configure networking between servers from different [pools](./servers.md), select the same [VRF](#vrf-segment) for the appropriate subnets under **Routing settings**.

{% include [internal-addressing-rules](../../_includes/baremetal/internal-addressing-rules.md) %}

### Virtual routing and forwarding (VRF) {#vrf-segment}

To provide L3 routing, private subnets with configured routing are aggregated into virtual routing and forwarding segments (VRFs).

Servers from the same or different pools connected to different private subnets aggregated into a VRF will be able to maintain L3 networking between them.

#### See also {#see-also}

* [{#T}](./traffic-restrictions.md)