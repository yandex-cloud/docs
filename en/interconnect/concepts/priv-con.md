# Private connection

A private connection is a logical link to your cloud [network](../../vpc/concepts/network.md#network), set up within a [trunk](./trunk.md). You can have multiple private connections to different cloud networks in a single trunk.

{% note warning %}

However, you cannot set up multiple private connections to a single cloud network at the same [point of presence](./pops.md). For redundancy purposes, you can set up multiple private connections per cloud network in different [points of presence](./pops.md).

{% endnote %}
 
A private connection is set up inside a [trunk](./trunk.md) and has its own unique **VLAN-ID**. 

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

![prc-direct-link](../../_assets/interconnect/interconnect-bgp-1.svg)

This scenario implies setting up L3 and BGP connectivity between the customer equipment at the point of presence and the {{ yandex-cloud }} equipment. In this case, the following applies:

* You independently provide L3 connectivity between your equipment in your data center and your equipment at the point of presence.
* Your equipment at the point of presence establishes BGP peering with the {{ yandex-cloud }} equipment.
* All BGP route announcements from your equipment at the point of presence enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

### Private connection through a telecom provider connection (L2 transit) {#prc-sp-l2}

![prc-sp-l2](../../_assets/interconnect/interconnect-bgp-2.svg)

This scenario assumes you do not have your own equipment at the point of presence and you use the services of a telecom provider that ensures connectivity between {{ yandex-cloud }} and your own equipment. In this case, the following applies:
* The telecom provider sets up L2 connectivity between its equipment at the point of presence and the {{ yandex-cloud }} equipment.
* Your equipment in your data center establishes L3 connectivity and BGP peering with the {{ yandex-cloud }} equipment at the point of presence.
* All BGP route announcements from your equipment in your data center enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

### Private connection through a telecom provider connection (L3VPN) {#prc-sp-l3vpn}

![prc-sp-l3vpn](../../_assets/interconnect/interconnect-bgp-3.svg)

This scenario also assumes you do not have your own equipment at the point of presence and you use the services of a telecom provider that ensures connectivity between {{ yandex-cloud }} and your own equipment. You cannot technically set up BGP peering with the {{ yandex-cloud }} equipment on your own. In this case, the following applies:

* The telecom provider sets up L2 connectivity between its equipment at the point of presence and the {{ yandex-cloud }} equipment.
* The telecom provider equipment establishes L3 connectivity and BGP peering with the {{ yandex-cloud }} equipment at the point of presence. This connection integrates into the customer L3VPN, which ensures direct connectivity between your equipment in your data center and {{ yandex-cloud }}.
* All BGP route announcements from the telecom provider equipment at the point of presence enter all {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).
* While providing L3VPN, the telecom provider can use both static and dynamic routing protocols.


## Cloud subnet announcements and communication with {{ vpc-short-name }} {#prc-announce}

To connect one or more cloud subnets to a private connection, you need to know the following:
* ID of the virtual network (`vpc_net_id`) to connect to the trunk.
* List of announced IPv4 prefixes of virtual network [subnets](../../vpc/concepts/network.md#subnet), distributed by [availability zones](../../overview/concepts/geo-scope.md). Typically, prefixes refer to the subnets configured in your cloud. In this case, the announced prefixes and the actual subnet address ranges match.

{% note info %}

Please keep in mind that the first IP address (default gateway) and the second IP address (default DNS server) in each subnet will not be available outside the cloud, regardless of the subnet announcement. Network traffic to these IP addresses can only be delivered from within a {{ yandex-cloud }} VM. 

{% endnote %}

New subnets created in the virtual network after the initial setup will not be automatically announced to the {{ interconnect-name }} private connection. 

To add a new subnet to an existing private connection, file a request to [support]({{ link-console-support }}) to have a new announcement added to the {{ interconnect-name }} private connection.

{% note warning %}

When using {{ yandex-cloud }} load balancers, specifically: 
* [{{ network-load-balancer-short-name }}](../../network-load-balancer/) (NLB)
* [{{ alb-name }}](../../application-load-balancer/) (ALB)

LB listener addresses are announced as `/32` IPv4 prefixes.

This enables you to use load balancers to distribute traffic coming from your infrastructure via {{ interconnect-name }} across cloud resources in different {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

{% endnote %}

Your equipment announces IPv4 prefixes from your infrastructure over BGP towards the {{ yandex-cloud }} equipment. You can use the following types of prefixes in the announcements:
* Private IP subnets from [RFC-1918](https://www.ietf.org/rfc/rfc1918.txt).
* Default route: `0.0.0.0/0`.
* Public IP subnets.

{{ yandex-cloud }} equipment uses route redistribution to send these prefixes to {{ vpc-short-name }} subnets.

Once the {{ yandex-cloud }} equipment receives customer prefixes, they become available to all VMs and internal load balancers within the {{ vpc-short-name }} subnets.

No changes to the VM route tables are required to ensure IP connectivity between cloud resources and your infrastructure resources.

### Aggregated prefixes (aggregates) {#agg-subnets}

To automatically announce new subnets to {{ interconnect-name }}, you can use **aggregated subnet prefixes** (aggregates). This way, you only need to set up prefix announcements once, and then you can add new subnets to your {{ vpc-short-name }} without needing to contact support.

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