---
title: Trunks in {{ interconnect-full-name }}
description: In this article, you will learn about the features and parameters of a trunk.
---

# Trunk 

Trunks are mainly used for:

* Providing a [physical link](#links) between external hardware and the {{ yandex-cloud }} equipment at a [point of presence](./pops.md).
* Enabling [traffic multiplexing](#mux) for both private and public connections using **Ethernet 802.1Q**. 

{% note warning %}

Customers can have one or more trunks set up at a single [point of presence](./pops.md). However, you cannot set up multiple [private connections](./priv-con.md) to a single cloud network through different trunks at the same point of presence. To ensure fault tolerance, we recommend setting up multiple (at least two) trunks, one at each [point of presence](./pops.md).


{% endnote %}

## Physical port settings on the {{ yandex-cloud }} equipment {#phy-port}

All physical ports on the {{ yandex-cloud }} equipment have the following default settings:

* Physical port speed autonegotiation is not supported. Make sure to manually configure the speed and disable autonegotiation on your equipment.
* {{ yandex-cloud }} physical ports are always configured as 802.1Q tagged trunks. Access port (untagged) connections are not supported.
* The default MTU size supports jumbo frame transmission.

{% note warning %}

If you need to, you can group multiple physical ports into a single bundle using [LACP](https://en.wikipedia.org/wiki/Link_aggregation#Link_Aggregation_Control_Protocol) in `Active` mode. When setting up a bundle, all its physical ports must use [transceivers](./transceivers.md) of the same type. You cannot combine transceivers of different types within a single bundle.

{{ yandex-cloud }} equipment does not support [MC-LAG](https://en.wikipedia.org/wiki/Multi-chassis_link_aggregation_group) for aggregated links.

{% endnote %}

## Physical connection topologies {#links}

{{ yandex-cloud }} equipment supports the following physical connection options:

* [Direct customer connection](#direct-link): Connection of your own equipment at the point of presence directly to the {{ yandex-cloud }} equipment.
* [Connection via a telecom provider](#sp-link): You have no equipment of your own at the point of presence and use the services of a telecom provider to set up a connection to the {{ yandex-cloud }} equipment.

### Direct customer connection {#direct-link}
This is a connection of your own equipment at the [point of presence](./pops.md) directly to the {{ yandex-cloud }} equipment.

In this configuration, the trunk will comprise the following components:

* Physical port on your equipment.
* Optical transceiver connected to the physical port on your equipment.
* Physical port reserved on the {{ yandex-cloud }} equipment.
* Optical transceiver connected to the physical port on the {{ yandex-cloud }} equipment.
* Cross-connect linking the optical transceiver on your equipment's port and to the optical transceiver on the {{ yandex-cloud }} equipment. 

The following chart illustrates this connection option:

![direct-link](../../_assets/interconnect/interconnect-phy-1.svg)

The customer equipment is located at a [point of presence](./pops.md) and connected to the {{ yandex-cloud }} equipment directly through an optical cross-connect within the point of presence.

The transceiver transmitting side (Tx) on the {{ yandex-cloud }} equipment is connected to the transceiver receiving side (Rx) on the customer equipment using optical fiber. The transceiver transmitting side (Tx) on the customer equipment is connected to the transceiver receiving side (Rx) on the {{ yandex-cloud }} equipment with optical fiber. This optical fiber pair forms an optical cross-connect.

### Connection via a telecom provider {#sp-link}

If the customer does not have their own equipment at the appropriate [point of presence](./pops.md), they can engage a telecom provider that has equipment at that point of presence to connect to the {{ yandex-cloud }} equipment. 

The following chart illustrates this connection option:

![direct-link](../../_assets/interconnect/interconnect-phy-2.svg)

In this configuration, the trunk will comprise the following components:

* Physical port on the telecom provider equipment.
* Optical transceiver connected to the physical port on the telecom provider equipment.
* Physical port reserved on the {{ yandex-cloud }} equipment.
* Optical transceiver connected to the physical port on the {{ yandex-cloud }} equipment.
* Cross-connect linking the optical transceiver on the telecom provider equipment port and to the optical transceiver on the {{ yandex-cloud }} equipment.

{% note info %}

The telecom provider is responsible for setting up a connection between the customer equipment and its own equipment at the appropriate point of presence and ensuring traffic between the customer equipment and the {{ yandex-cloud }} equipment.

{% endnote %}


## Connection multiplexing (802.1Q) {#mux}

### VLAN-ID {#vlan-id}

**Ethernet 802.1Q** enables transmitting various traffic types concurrently, i.e., traffic multiplexing. Each private or public connection in a trunk is assigned its own unique **VLAN-ID**.

{% note warning %}

When setting up a private or public connection, you can only use the VLAN ID values ranging from `2` to `4000`, inclusive.

{% endnote %}

### Connection multiplexing options {#mux-options}

A single trunk can accommodate a mix of different connection types:

* One [private connection](./priv-con.md).
* One [public connection](./pub-con.md).
* Multiple private connections and/or public connections.

You can leverage the following multiplexing options:

* [Direct connection at a point of presence](#mux-direct).
* [Connection via a telecom provider (L2 transit)](#mux-sp-L2).
* [Connection via a telecom provider (L3VPN)](#mux-sp-L3).

#### Direct connection at a point of presence {#mux-direct}

![trunk-over-direct-link](../../_assets/interconnect/interconnect-trn-1.svg)

This option assumes setting up an 802.1Q trunk through a direct physical connection between the customer equipment at the [point of presence](./pops.md) and the {{ yandex-cloud }} equipment.

#### Connection via a telecom provider (L2 transit) {#mux-sp-L2}

![trunk-over-sp-l2](../../_assets/interconnect/interconnect-trn-2.svg)

This option is used when the customer does not have their own equipment at the point of presence. In this case, the following applies:

* An 802.1Q trunk is set up at the point of presence via a telecom provider enabling L2 transit.
* An 802.1Q trunk is set up between the customer equipment and the {{ yandex-cloud }} equipment.
* When connecting the customer equipment, the provider uses its own communication circuits. If the customer needs to change connection VLAN IDs (enable VLAN ID translation) on their equipment, the telecom provider needs to agree with the customer on the translation scenario to ensure seamless operation between the customer and telecom provider equipment.


#### Connection via a telecom provider (L3VPN) {#mux-sp-L3}

![trunk-over-sp-l3vpn](../../_assets/interconnect/interconnect-trn-3.svg)

This option is used when the customer does not have their own equipment at the point of presence. In this case, the following applies:

* An 802.1Q trunk is set up at the point of presence via a telecom provider.
* An 802.1Q trunk is set up between the telecom provider equipment at the point of presence and the {{ yandex-cloud }} equipment.
* Telecom provider enables L3VPN for the customer to establish connectivity between the telecom provider equipment at the point of presence and the customer equipment. This option is generally used when the customer lacks technical resources to ensure BGP peering to the {{ yandex-cloud }} equipment on their own and delegates this to a telecom provider that enables such peering through L3VPN.


## Connection capacity {#policer}

At the trunk level, {{ yandex-cloud }} equipment uses reception and transmission speed limits for data from/to external equipment in bits per second and packets per second according to the [connection capacity](../pricing.md) selected by the customer. 

{{ yandex-cloud }} equipment utilizes **RateLimit (Policing)** to limit data reception and transmission speeds. When transmission speeds exceed the specified bits per second or packets per second, the equipment may drop the data. This can result in evenly transmitted traffic being processed at a higher speed than traffic transmitted in sudden bursts.


## Use cases {#examples}

* [{#T}](../tutorials/trunk-priv-add.md)
* [{#T}](../tutorials/trunk-pub-add.md)
* [{#T}](../tutorials/trunk-capacity-change.md)
* [{#T}](../tutorials/trunk-del.md)