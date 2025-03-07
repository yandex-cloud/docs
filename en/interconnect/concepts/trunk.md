---
title: Trunks in {{ interconnect-full-name }}
description: In this article, you will learn what a trunk is used for and which features it has.
---

# Trunk 

Trunks are mainly used for:

* Providing a [physical connection](#links) from external equipment to the {{ yandex-cloud }} equipment at a [point of presence](./pops.md).
* Enabling [traffic multiplexing](#mux) for private and public connections using **Ethernet 802.1Q**. 

{% note warning %}

You can set up one or more trunks per [point of presence](./pops.md), per client. However, you cannot set up multiple [private connections](./priv-con.md) to a single cloud network through different trunks at the same point of presence. To ensure fault tolerance, we recommend setting up multiple (at least two) trunks, one at each [point of presence](./pops.md).


{% endnote %}

## Physical port settings on the {{ yandex-cloud }} equipment {#phy-port}

All physical ports on the {{ yandex-cloud }} equipment have the following default settings:

* No auto negotiation of the transmission rate is supported on physical ports. Make sure to explicitly set the transmission rate and disable auto negotiation on your equipment.
* On the {{ yandex-cloud }} equipment, a physical port always works in trunk mode with 802.1Q tagging. No connection in access port mode (without tagging) is supported.
* The default MTU size supports transfer of jumbo frames.

{% note warning %}

If you need to, you can group multiple physical ports into a single bundle via [LACP](https://en.wikipedia.org/wiki/Link_aggregation#Link_Aggregation_Control_Protocol) in `Active` mode. When setting up a bundle, all its physical ports must use [transceivers](./transceivers.md) of the same type. You cannot combine transceivers of different types within a single bundle.

The [MC-LAG technology](https://en.wikipedia.org/wiki/Multi-chassis_link_aggregation_group) for aggregate channels on the {{ yandex-cloud }} equipment is not supported.

{% endnote %}

## Physical connection topologies {#links}

The following physical connection setup options are supported on the {{ yandex-cloud }} equipment:

* [Direct client connection](#direct-link): Connection of your own equipment at the point of presence directly to the {{ yandex-cloud }} equipment.
* [Connection via a telecom provider](#sp-link): You have no equipment of your own at the point of presence and you enlist the services of a telecom provider who connects you to the {{ yandex-cloud }} equipment.

### Direct client connection {#direct-link}
This is a connection of your own equipment at the [point of presence](./pops.md) directly to the {{ yandex-cloud }} equipment.

A trunk in this setup option has the following components:

* Physical port on your equipment.
* Optical transceiver connected to the physical port on your equipment.
* Physical port reserved on the {{ yandex-cloud }} equipment.
* Optical transceiver connected to the physical port on the {{ yandex-cloud }} equipment.
* Cross connection that is used to connect to the optical transceiver on your equipment's port and to the optical transceiver on the {{ yandex-cloud }} equipment. 

One may outline this connection as follows:

![direct-link](../../_assets/interconnect/interconnect-phy-1.svg)

The client equipment is located at a [point of presence](./pops.md) and connected to the {{ yandex-cloud }} equipment directly through an optical cross-connection routed within the point of presence.

The transceiver transmitting side (Tx) on the {{ yandex-cloud }} equipment is connected to the transceiver receiving side (Rx) on the client equipment using optical fiber. The transceiver transmitting side (Tx) on the client equipment is connected to the transceiver receiving side (Rx) on the {{ yandex-cloud }} equipment with optical fiber. A pair of these optical fibers makes up an optical cross-connect.

### Connecting via a telecom provider {#sp-link}

If a client does not have their own equipment at the appropriate [point of presence](./pops.md), they can use a telecom provider that has equipment at the appropriate point of presence to connect to the {{ yandex-cloud }} equipment. 

One may outline this connection as follows:

![direct-link](../../_assets/interconnect/interconnect-phy-2.svg)

A trunk in this setup option has the following components:

* Physical port on the telecom provider's equipment.
* Optical transceiver connected to the physical port on the telecom provider's equipment.
* Physical port reserved on the {{ yandex-cloud }} equipment.
* Optical transceiver connected to the physical port on the {{ yandex-cloud }} equipment.
* Cross connection that is used to connect to the optical transceiver on the telecom provider's equipment and to the optical transceiver on the {{ yandex-cloud }} equipment.

{% note info %}

The telecom provider has to set up a connection between the client equipment and its own equipment at the appropriate point of presence and ensure traffic between the client equipment and the {{ yandex-cloud }} equipment.

{% endnote %}


## Connection multiplexing (802.1Q) {#mux}

### VLAN-ID {#vlan-id}

**Ethernet 802.1Q** allows you to transmit different types of traffic, i.e., enables traffic multiplexing. Each private or public connection in a trunk is assigned its own unique **VLAN-ID**.

{% note warning %}

When setting up a private or public connection, you can only use the VLAN ID values ranging from `2` to `4000`, inclusive.

{% endnote %}

### Connection multiplexing options {#mux-options}

You can combine different types of connections in a trunk:

* One [private connection](./priv-con.md).
* One [public connection](./pub-con.md).
* Multiple private connections and/or public connections.

You can leverage the following multiplexing options:

* [Direct connection at a point of presence](#mux-direct).
* [Connection via a telecom provider (L2 transit)](#mux-sp-L2).
* [Connection via a telecom provider (L3VPN)](#mux-sp-L3).

#### Direct connection at a point of presence {#mux-direct}

![trunk-over-direct-link](../../_assets/interconnect/interconnect-trn-1.svg)

This option assumes setting up a 802.1Q trunk over a direct physical connection between the client equipment at the [point of presence](./pops.md) and the {{ yandex-cloud }} equipment.

#### Connection via a telecom provider (L2 transit) {#mux-sp-L2}

![trunk-over-sp-l2](../../_assets/interconnect/interconnect-trn-2.svg)

This option is used when the client does not have their own equipment at the point of presence. In which case:

* The 802.1Q trunk is set up at the point of presence through a telecom provider that provides L2 transit.
* The 802.1Q trunk is set up between the client equipment and the {{ yandex-cloud }} equipment.
* When connecting the client equipment, the provider uses its own communication circuits. If the client needs to change connection VLAN IDs (enable VLAN ID translation) on their equipment, the telecom provider needs to agree upon the translation scenario with the client for consistent operation of the client and telecom provider equipment.


#### Connection via a telecom provider (L3VPN) {#mux-sp-L3}

![trunk-over-sp-l3vpn](../../_assets/interconnect/interconnect-trn-3.svg)

This option is used when the client does not have their own equipment at the point of presence. In which case:

* The 802.1Q trunk is set up at the point of presence through a telecom provider.
* The 802.1Q trunk is set up between the telecom provider's equipment at the point of presence and the {{ yandex-cloud }} equipment.
* Connectivity between the telecom provider's equipment at the point of presence and the client equipment is ensured by providing the L3VPN service to the client. This setup option is usually used when the client cannot technically ensure BGP connectivity to the {{ yandex-cloud }} equipment on their own and delegates this to a telecom provider that ensures connectivity by providing an L3VPN service to the client.


## Connection capacity {#policer}

At the trunk level, {{ yandex-cloud }} equipment limits data receive/send rates from/to external equipment in bits per second and packets per second according to the [connection capacity](../pricing.md) selected by the client. 

To limit the rate of receiving and sending data on the {{ yandex-cloud }} equipment, one uses the **RateLimit (Policing)** tool. When the data transfer speed in bits per second or packets per second is exceeded, the data may be rejected. As a result, uniform traffic may be transmitted at a faster speed than the traffic transmitted in sudden bursts.


## Use cases {#examples}

* [{#T}](../tutorials/trunk-priv-add.md)
* [{#T}](../tutorials/trunk-pub-add.md)
* [{#T}](../tutorials/trunk-capacity-change.md)
* [{#T}](../tutorials/trunk-del.md)