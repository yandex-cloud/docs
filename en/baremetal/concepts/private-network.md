---
title: Private network in {{ baremetal-full-name }}
description: In this tutorial, you will learn about private networks and subnets in {{ baremetal-full-name }}.
---

# Private network {#private-network}

A _private network_ is a local network to which all servers from a single server [pool](./servers.md#server-pools) are connected. Logically joins servers into isolated user networks. Some {{ baremetal-name }} server [configurations](./server-configurations.md) support reserving [MC-LAG](./mc-lag.md) private network channels.

Within a single pool, you can have network connectivity between leased servers at the [OSI network model](https://en.wikipedia.org/wiki/OSI_model) levels L2 ([private subnet](#private-subnet)) and L3 ([VRF](#vrf-segment)).

Between servers physically residing in different pools, only VRF-enabled L3 connectivity is available.

## Private subnet {#private-subnet}

A _private subnet_ is a [virtual local area network (VLAN)](https://en.wikipedia.org/wiki/VLAN) that groups servers together within one pool. This network is physically isolated from the internet and logically from other users' virtual networks.

Each private subnet automatically gets a unique [IEEE 802.1Q](https://en.wikipedia.org/wiki/IEEE_802.1Q) VLAN ID. The subnet gets this VLAN ID not when created but when attached to any {{ baremetal-name }} server.

{% note info %}

A VLAN ID is removed from a private subnet if it remains unattached to any server for 30 consecutive days. If the subnet is later attached to a {{ baremetal-name }} server, it will get a new VLAN ID; however, the new ID may be different from the one removed earlier.

{% endnote %}

You can [attach](../operations/servers/set-up-tagged-vlan.md) several private subnets (one [primary](#native-vlan-subnet) and several [secondary](#tagged-vlan-subnet)) to the server's [network interface](./servers.md#network-interfaces) (or MC-LAG aggregation group) connected to a private network at the same time. The same private subnet can serve as the primary subnet on some servers and as a secondary subnet on others.

### Primary private subnet {#native-vlan-subnet}

Each {{ baremetal-name }} server must have one private subnet attached as its _primary_ subnet. The primary private subnet is a virtual network with a native (`native`) VLAN. All untagged traffic arriving at the server's network interface (aggregation group) is routed to this subnet.

Within the server's primary private subnet, [DHCP](./dhcp.md) can be used.

You can replace the primary private subnet only on servers that have no secondary private subnets attached.

{% note tip %}

If you need to replace the primary private subnet on a server with secondary subnets:
1. Detach all secondary private subnets from the server.
1. Replace the primary private subnet.
1. Reattach the secondary private subnets to the server.
1. Update the network settings in the server's OS.

{% endnote %}

### Secondary private subnet {#tagged-vlan-subnet}

You can attach _secondary private subnets_ to a {{ baremetal-name }} server. A secondary private subnet is a virtual network with a tagged (`tagged`) VLAN. This secondary subnet receives traffic bound for the server's network interface (aggregation group) and tagged consistently with the subnet's unique VLAN ID (tagged traffic).

By default, only one private subnet, the primary one, can be attached to a {{ baremetal-name }} server's network interface. To be able to attach secondary private subnets, contact [support]({{ link-console-support }}) to have your `baremetal.privateSubnetsPerServerInterface.count` [quota](./limits.md#baremetal-quotas) increased.

You can attach a secondary private subnet to a server when modifying the latter. For more information, see [{#T}](../operations/servers/server-update.md).

After a secondary private subnet is attached, you should manually configure the VLAN on the network interface in the server's OS. For more information, see [{#T}](../operations/servers/set-up-tagged-vlan.md).

{% include [additional-private-subnet-dhcp-notice](../../_includes/baremetal/additional-private-subnet-dhcp-notice.md) %}

## Virtual network segment (VRF) {#vrf-segment}

To provide L3 routing, private subnets with configured routing are aggregated into virtual network segments (VRFs).

Servers from the same or different pools connected to different private subnets, grouped together under VRF, will be able to maintain L3 networking between them. To configure such networking, select the same VRF for the relevant subnets under **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.

{% include [internal-addressing-rules](../../_includes/baremetal/internal-addressing-rules.md) %}

## Private connection to cloud networks {#private-connection-to-vpc}

To set up network connectivity between {{ baremetal-name }} [servers](./servers.md), {{ vpc-full-name }} private [subnets](../../vpc/concepts/network.md#subnet), and private subnets in the on-premise infrastructure, use [{{ interconnect-full-name }}](../../interconnect/concepts/priv-con.md).

#### See also {#see-also}

* [{#T}](./network.md)
* [{#T}](./public-network.md)
* [{#T}](./dhcp.md)
* [{#T}](./mc-lag.md)
* [{#T}](../operations/network-create.md)
* [{#T}](../operations/subnet-create.md)
* [{#T}](../operations/create-vpc-connection.md)