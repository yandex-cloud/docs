# Private connection

A private connection is a logical link of your on-prem infrastructure to a virtual network in a cloud. A private connection’s destination in the cloud network is a [routing instance](../../cloud-router/concepts/routing-instance.md).

Here is an example of using two private connections to set up fault-tolerant IP connectivity:

![topology](../../_assets/cloud-router/ri-topology-3.svg)

{% note warning %}

However, you cannot set up multiple private connections to a single cloud network at the same [point of presence](./pops.md). For redundancy purposes, you can set up multiple private connections per cloud network in different [points of presence](./pops.md).

{% endnote %}

The main components of a private connection are: 
* [Point-to-point subnet](#priv-address)
* [BGP connectivity](#bgp-peering)

The cloud network and on-prem infrastructure will then exchange routes via the configured BGP to start sending traffic between on-prem and cloud network resources.

A private connection is set up within a [trunk](./trunk.md). You can have multiple private connections to different cloud networks in a single trunk.

A private connection is set up inside a [trunk](./trunk.md) and has its own unique **VLAN ID**. 

The maximum IP MTU for a private connection is **8,910 bytes**. {{ yandex-cloud }} equipment does not support changing the IP MTU.

## Point-to-point subnet {#priv-address}

To set up a private connection, you need a **point-to-point subnet**. It is used to configure IP connectivity between the {{ yandex-cloud }} equipment and the customer or telecom provider equipment.

A point-to-point subnet can be either `/30` or `/31` in size. You cannot use subnets of other sizes.

You can use the following IP address ranges in your point-to-point subnet:

* `10.0.0.0/8`
* `172.16.0.0/12`
* `192.168.0.0/16`
* `169.254.0.0/16`

IP addressing in other ranges is not allowed.

{% note info %}

When setting up a private connection, you can only use IPv4 addresses.
Currently, you cannot use IPv6 addresses.

{% endnote %}


{% include [bgp](../../_includes/interconnect/bgp.md) %}


## Private connection topologies {#priv-top}

The following options for setting up private connections are supported:

* [Private connection through a direct customer connection](#prc-direct-link).
* [Private connection through a telecom provider connection (L2 transit)](#prc-sp-l2).
* [Private connection through a telecom provider connection (L3VPN)](#prc-sp-l3vpn).

### Private connection through a direct customer connection {#prc-direct-link}

This scenario implies setting up L3 and BGP connectivity between the customer equipment at the point of presence and the {{ yandex-cloud }} equipment. In this case, the following applies:

* You independently provide L3 connectivity between your equipment in your data center and your equipment at the point of presence.
* Your equipment at the point of presence establishes BGP peering with the {{ yandex-cloud }} equipment.
* All BGP route announcements from your equipment at the point of presence enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

### Private connection through a telecom provider connection (L2 transit) {#prc-sp-l2}

This scenario assumes you do not have your own equipment at the point of presence and you use the services of a telecom provider that ensures connectivity between {{ yandex-cloud }} and your own equipment. In this case, the following applies:
* The telecom provider sets up L2 connectivity between its equipment at the point of presence and the {{ yandex-cloud }} equipment.
* Your equipment in your data center establishes L3 connectivity and BGP peering with the {{ yandex-cloud }} equipment at the point of presence.
* All BGP route announcements from your equipment in your data center enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

### Private connection through a telecom provider connection (L3VPN) {#prc-sp-l3vpn}

This scenario also assumes you do not have your own equipment at the point of presence and you use the services of a telecom provider that ensures connectivity between {{ yandex-cloud }} and your own equipment. You cannot technically set up BGP peering with the {{ yandex-cloud }} equipment on your own. In this case, the following applies:

* The telecom provider sets up L2 connectivity between its equipment at the point of presence and the {{ yandex-cloud }} equipment.
* The telecom provider equipment establishes L3 connectivity and BGP peering with the {{ yandex-cloud }} equipment at the point of presence. This connection integrates into the customer L3VPN, which ensures direct connectivity between your equipment in your data center and {{ yandex-cloud }}.
* All BGP route announcements from the telecom provider equipment at the point of presence enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).
* While providing L3VPN, the telecom provider can use both static and dynamic routing protocols.


## Use cases {#examples}

* [{#T}](../tutorials/trunk-priv-add.md)
* [{#T}](../tutorials/priv-add.md)
* [{#T}](../tutorials/priv-del.md)
* [{#T}](../tutorials/cic-with-ngfw.md)
