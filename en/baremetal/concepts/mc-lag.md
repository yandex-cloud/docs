---
title: Reserving a {{ baremetal-full-name }} network connection using MC-LAG
description: This article describes the specifics and benefits of using MC-LAG to reserve a {{ baremetal-full-name }} network connection.
---

# Reserving a {{ baremetal-name }} network connection using MC-LAG

For critical tasks that require high fault tolerance of physical network infrastructure, {{ baremetal-full-name }} provides a solution for reserving a network connection using [MC-LAG](https://en.wikipedia.org/wiki/Multi-chassis_link_aggregation_group).

MC-LAG (multi-chassis link aggregation group) is a type of link aggregation groups that reserve a connection to [network switches](https://en.wikipedia.org/wiki/Network_switch). MC-LAG is supported in {{ baremetal-name }} server [configurations](./server-configurations.md) with two network interfaces connected to each of the networks, a [public](./network.md#public-network) and a [private](./network.md#private-network) one.

In each network, servers supporting MC-LAG use two independent network adapter ports to simultaneously connect to two different switches, which make up an MC-LAG pair. If one of the network adapters or switches fails, the second active connection ensures network connectivity of the server and provides fault tolerance.

## Configuring aggregation groups and network interfaces {#additional-setup}

Servers with MC-LAG support are simultaneously connected to each of the networks using two network adapters. Each adapter, in turn, is connected to a separate network switch over LACP 802.3ad. Network interface pairs connected to the networks form _aggregation groups_ on the server side.

When you install the server OS with MC-LAG support from a public [{{ marketplace-short-name }} image](./images.md#marketplace-images), aggregation groups are configured automatically during the OS installation, no manual setup required.

When you install the OS from a [custom image](./images.md#user-images), server network interfaces will not form aggregation groups, and only one of the two interfaces connected to each of the networks (public and private) will be active. You will need to [configure](../operations/servers/set-up-mc-lag.md) aggregation groups manually. When configuring aggregation groups, you must disable [DHCP](./dhcp.md) for the network interfaces and enable it for the aggregation groups.

To learn more about configuring MC-LAG on the server side, see [{#T}](../operations/servers/set-up-mc-lag.md).

#### See also {#see-also}

* [{#T}](./network.md)
* [{#T}](./dhcp.md)
* [{#T}](./network-restrictions.md)
* [{#T}](./images.md)
* [{#T}](../operations/servers/set-up-mc-lag.md)