# Private connection

A private connection is a logical connection to your cloud [network](../../vpc/concepts/network.md#network), which is set up within a [trunk](./trunk.md). You can have multiple private connections to different cloud networks in a single trunk.

{% note warning %}

However, you cannot set up multiple private connections to a single cloud network at the same [point of presence](./pops.md). For redundancy purposes, you can set up multiple private connections per cloud network in different [points of presence](./pops.md); however, you cannot have more than one private connection per point of presence.

{% endnote %}
 
A private connection is set up inside a [trunk](./trunk.md) and has its own unique **VLAN-ID**. 

Maximum IP MTU for a private connection is **8,910 bytes**. Changing IP MTU on the {{ yandex-cloud }} equipment is not allowed.

## Point-to-point subnet {#priv-address}

To set up a private connection, you need a **point-to-point subnet**. It is used to configure IP connectivity between the {{ yandex-cloud }} equipment and the client or telecom provider equipment.

A point-to-point subnet can be either `/30` or `/31` in size. Other subnet sizes are not allowed.

You can use the following IP address ranges in point-to-point subnets:

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

The following private connection setup options are supported:

* [Private connection through a direct client connection](#prc-direct-link)
* [Private connection through a telecom provider connection (L2 transit)](#prc-sp-l2)
* [Private connection through a telecom provider connection (L3VPN)](#prc-sp-l3vpn)

### Private connection through a direct client connection {#prc-direct-link}

![prc-direct-link](../../_assets/interconnect/interconnect-bgp-1.svg)

This scenario implies setting up L3 and BGP connectivity between the client equipment at the point of presence and the {{ yandex-cloud }} equipment. In which case:

* It is your responsibility to ensure L3 connectivity from the equipment in your data center to your own equipment at the point of presence.
* You set up BGP connectivity between your equipment at the point of presence and the {{ yandex-cloud }} equipment.
* All route announcements over BGP from your equipment at the point of presence enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

### Private connection through a telecom provider connection (L2 transit) {#prc-sp-l2}

![prc-sp-l2](../../_assets/interconnect/interconnect-bgp-2.svg)

This scenario assumes you do not have your own equipment at the point of presence and you use the services of a telecom provider that ensures connectivity between {{ yandex-cloud }} and your own equipment. In which case:
* The telecom provider sets up L2 connectivity between its equipment at the point of presence and the {{ yandex-cloud }} equipment.
* L3 and BGP connectivity is set up between your equipment in your data center and the {{ yandex-cloud }} equipment at the point of presence.
* All route announcements over BGP from your equipment in your data center reach all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

### Private connection through a telecom provider connection (L3VPN) {#prc-sp-l3vpn}

![prc-sp-l3vpn](../../_assets/interconnect/interconnect-bgp-3.svg)

This scenario also assumes you do not have your own equipment at the point of presence and you use the services of a telecom provider that ensures connectivity between {{ yandex-cloud }} and your own equipment. You cannot set up BGP connectivity to the {{ yandex-cloud }} equipment on your own, technically. In which case:

* The telecom provider sets up L2 connectivity between its equipment at the point of presence and the {{ yandex-cloud }} equipment.
* L3 and BGP connectivity to {{ yandex-cloud }} is set up between the telecom provider's equipment and the {{ yandex-cloud }} equipment at the point of presence. This connection becomes a part of the client L3VPN, which ensures direct connectivity between your equipment in their data center and {{ yandex-cloud }}.
* All route announcements over BGP from the telecom provider's equipment at the point of presence enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).
* While providing the L3VPN service, the telecom provider can use both static and dynamic routing protocols.


## Cloud subnet announcements and communication with {{ vpc-short-name }} {#prc-announce}

To connect one or more cloud subnets to a private connection, you need to know the following:
* ID of the virtual network (`vpc_net_id`) that needs to be connected to the trunk.
* List of announced IPv4 prefixes of virtual network [subnets](../../vpc/concepts/network.md#subnet) with their distribution between [availability zones](../../overview/concepts/geo-scope.md). Typically, prefixes refer to the subnets configured in your cloud. In this case, the announced prefixes and the actual subnet address ranges match.

{% note info %}

Please keep in mind that the first IP address (default gateway) and the second IP address (default DNS server) in each subnet will not be available outside the cloud, regardless of the subnet announcement. Network traffic to these IP addresses can only be delivered from inside a {{ yandex-cloud }} VM. 

{% endnote %}

New subnets that will be created in the virtual network later will not be announced to the {{ interconnect-name }} private connection automatically. 

To add a new subnet to an existing private connection, file a request to [support]({{ link-console-support }}) to have a new announcement added to the {{ interconnect-name }} private connection.

{% note warning %}

When using {{ yandex-cloud }} load balancers: 
* [{{ network-load-balancer-short-name }}](../../network-load-balancer/) (NLB)
* [{{ alb-name }}](../../application-load-balancer/) (ALB)

their listener addresses are announced as IPv4 prefixes with the length of `/32`.

This enables you to use load balancers to distribute traffic coming from your infrastructure via {{ interconnect-name }} between cloud resources in different {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

{% endnote %}

Your equipment announces IPv4 prefixes from your infrastructure over BGP to the {{ yandex-cloud }} equipment. You can use the following types of prefixes in the announcements:
* Private IP subnets from [RFC-1918](https://www.ietf.org/rfc/rfc1918.txt)
* Default route: `0.0.0.0/0`
* Public IP subnets

These prefixes get to {{ vpc-short-name }} subnets through redistribution of routing information on the {{ yandex-cloud }} equipment.

After the {{ yandex-cloud }} equipment receives the client prefixes, they become available to all VMs and internal load balancers within the {{ vpc-short-name }} subnets.

No changes to the VM route tables are required to ensure IP connectivity between cloud resources and your infrastructure resources.

### Aggregated prefixes (aggregates) {#agg-subnets}

To automatically announce new subnets in {{ interconnect-name }}, you can use **aggregated prefixes** (aggregates) of subnets. This allows you to set up prefix announcements once and then just add new subnets to an existing {{ vpc-short-name }} without contacting support.

> For example, when setting up a private connection, you can specify an announcement of the following aggregated IPv4 prefixes:
>
> ```
> {{ region-id }}-a [10.128.0.0/16]
> {{ region-id }}-b [10.130.0.0/16]
> {{ region-id }}-d [10.140.0.0/16]
> ```
>
> If later you create a subnet with the `10.128.15.0/24` prefix in this network in the `{{ region-id }}-a` availability zone, it will automatically be available via {{ interconnect-name }} because the `10.128.15.0/24` subnet belongs to the already announced address space, `10.128.0.0/16`.


## Use cases {#examples}

* [{#T}](../tutorials/trunk-priv-add.md)
* [{#T}](../tutorials/priv-add.md)
* [{#T}](../tutorials/priv-prefixes-change.md)
* [{#T}](../tutorials/priv-del.md)
* [{#T}](../tutorials/cic-with-ngfw.md)