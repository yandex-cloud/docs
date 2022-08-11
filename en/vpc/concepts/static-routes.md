---
description: With static routing, you can route traffic from a subnet to the specified IP address ranges through the VMs specified as the next hop. Routing is based on route tables. Route tables are linked to a subnet and can't contain duplicate prefixes.
keywords:
  - static routing
  - routing
---

# Static routing

With static routing, you can route traffic from a subnet to the specified IP address ranges through the VMs specified as the [next hop](https://en.wikipedia.org/wiki/Hop_(networking)#Next_hop).

Routing is based on route tables. The tables contain static routes consisting of the target subnet's prefix in CIDR notation and the internal IP address of the next hop.

Route tables are linked to a subnet and can't contain duplicate prefixes. Traffic from the subnet with the linked table is routed to the prefixes specified in the routes through the appropriate next hop addresses.

You can also use the prefix `0.0.0.0/0` in routes. This means that all traffic, if it's not sent via other routes, is routed through the next hop specified for the prefix `0.0.0.0/0`.

For example, a subnet with CIDR `10.1.0.0/24` has a linked route table with the following routes:

Name | Prefix | Next hop
--- | --- | ---
`another-network` | `192.168.0.0/16` | `10.1.0.5`
`internet` | `0.0.0.0/0` | `10.1.0.10`

In this case, all traffic to subnet `192.168.0.0/16` in a different virtual network will be routed through the VM with the address `10.1.0.5`, provided that the VM has an interface in that virtual network. All other traffic is routed through the VM with the address `10.1.0.10`. Note that overriding the route for prefix `0.0.0.0/0` may [affect](#internet-routes) the external availability of the VM from the subnet with the table that contains this route.

{% note alert %}

Static routes can be used for routing between networks only if the next-hop interface is a VM that is simultaneously connected to subnets in two cloud networks and has two interfaces, each in its own network. Or if a VM has a VPN connection to a VM in another network.

{% endnote %}

You currently can't use prefixes from address ranges that are allocated to subnets within a virtual network. Only destination prefixes outside the virtual network are supported, such as subnet prefixes from another {{ yandex-cloud }} network or your local network. You also can't use link-local address prefixes which is `169.254.0.0/16` and smaller, for example `169.254.0.0/19`. 

When creating a route, you can set an unused internal IP that isn't linked to any VM as the next hop. In this case, the route is only used after you run a VM with the appropriate IP address.

The two main uses of static routes in {{ yandex-cloud }}:
1. Building a network route to the appropriate prefix through a single VM. The internal IP address is used as the VM ID. For more information about building network routes in {{ yandex-cloud }} and other virtual or local networks, see the tutorials [Routing through a NAT instance](../../tutorials/routing/nat-instance.md) and [Creating an IPSec VPN tunnel](../../tutorials/routing/ipsec-vpn.md).
1. A fail-safe routing scheme with routes in multiple availability zones. You can create VMs in different availability zones and route them to the same destination subnet. Note that different route tables should be linked to subnets in different availability zones, since you can't place routes to the same prefixes in the same table. If a VM in one of the availability zones fails, VMs from the other zones will remain linked to the destination subnet.

## Rerouting traffic to the internet {#internet-routes}

If the destination prefix of a route from the route table is specified as an internet address prefix, access to and from such addresses via the VM's public IPs from the subnets that this table is linked to is disabled.

For example, let's say there's a VM named `vm-1` with a public IP address connected to the `my-subnet` subnet. If you link a table named `my-route-table` with a route for the prefix `0.0.0.0/0` (all addresses) via the next hop `10.0.0.5` to the `my-subnet` subnet, then access via the `vm-1` public address is disabled. This happens because all traffic to and from the `my-subnet` subnet is now routed via the next hop address.

To keep cloud resources available from a public address, you can:
* Move resources with public IPs to a separate subnet.
* Instead of configuring a route to the internet, enable [internet access for the subnet via a NAT instance](../operations/enable-nat.md). The feature is at the [Preview stage](../../overview/concepts/launch-stages.md) and can be provided by technical support upon request.