---
description: "With static routing, you can route traffic from a subnet to the specified IP address ranges through the VMs specified as the next hop. Routing is based on route tables. Route tables are linked to a subnet and cannot contain duplicate prefixes."
keywords:
  - static routing
  - routing
---

# Static routing

With static routing, you can route traffic from a [subnet](network.md#subnet) to the specified [IP address](address.md) ranges through the [VMs](../../compute/concepts/vm.md) specified as the [next hop](https://en.wikipedia.org/wiki/Hop_(networking)#Next_hop) or through [NAT gateways](gateways.md#nat-gateway).

Routing is based on route tables. The tables contain static routes consisting of the target subnet's prefix in CIDR notation and the [internal IP address](address.md#internal-addresses) of the next hop.

Route tables are linked to a subnet and cannot contain duplicate prefixes. Traffic from the subnet with the linked table is routed to the prefixes specified in the routes through the appropriate next hop IPs.

You can also use the `0.0.0.0/0` prefix in routes. This means that all traffic, if it is not sent via other routes, will be routed through the next hop specified for the `0.0.0.0/0` prefix.

For example, a subnet with the `10.1.0.0/24` CIDR has a linked route table with the following routes:

| Name | Prefix | Next hop |
--- | --- | ---
| `another-network` | `192.168.0.0/16` | `10.1.0.5` |
| `internet` | `0.0.0.0/0` | `10.1.0.10` |

In this case, all traffic to the `192.168.0.0/16` subnet in a different [virtual network](network.md#network) will be routed through the VM with the `10.1.0.5` IP address, in case this VM has an interface in that virtual network. All other traffic will be routed through the VM with the `10.1.0.10` address. Note that overriding the route for the `0.0.0.0/0` prefix may [affect](#internet-routes) the external availability of the VM from the subnet with the table that contains this route.

{% note alert %}

Static routes can be used for routing between networks only if the next-hop interface is a VM that is simultaneously connected to subnets in two cloud networks and has two interfaces, each in its own network. Alternatively, it can also work when a VM has a VPN connection to a VM in another network.

{% endnote %}

Currently, you cannot use prefixes from IP address ranges that are allocated to subnets within a virtual network. Only destination prefixes outside the virtual network are supported, such as subnet prefixes from another {{ yandex-cloud }} network or your local network. In route tables, you cannot use prefixes of link-local IP addresses, such as `169.254.0.0/16`, and narrower ones, such as `169.254.0.0/19`.

When creating a route, you can set an unused internal IP that is not linked to any VM as the next hop. In this case, the route is only used after you run a VM with the appropriate IP address.

The two main uses of static routes in {{ yandex-cloud }} are:
1. Building a network route to the appropriate prefix through a single VM. The internal IP address is used as the VM ID. For more information about building network routes in {{ yandex-cloud }} and other virtual or local networks, see the [Routing through a NAT instance](../../tutorials/routing/nat-instance.md) and [Creating an IPSec VPN tunnel](../../tutorials/routing/ipsec-vpn.md) tutorials.
1. Fail-safe routing scheme with routes in multiple [availability zones](../../overview/concepts/geo-scope.md). You can create VMs in different availability zones and route them to the same destination subnet. Please note that different route tables should be linked to subnets in different availability zones, since you cannot place routes to the same prefixes in the same table. If a VM in one of the availability zones fails, VMs from the other zones will remain linked to the destination subnet.

## Rerouting traffic to the internet {#internet-routes}

If the destination prefix of a route from the route table is specified as an IP address prefix from the internet, access to and from such addresses will be disabled via the VM's [public IP addresses](address.md#public-addresses) from the subnets this table is linked to.

> For example, let's assume there is a VM named `vm-1` with a public IP address connected to the `my-subnet` subnet. If you link a table named `my-route-table` to a route for the `0.0.0.0/0` prefix (all IPs) via the `10.0.0.5` next hop to the `my-subnet` subnet, access via the `vm-1` public address is disabled. This happens because all traffic to and from `my-subnet` is now routed via the next hop IP address.

To preserve ingress connectivity with cloud resources via a public IP address, you can move the resources with public IPs to a separate subnet.