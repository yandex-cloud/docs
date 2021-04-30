---
description: A cloud network is similar to a traditional LAN in a data center. Cloud networks are created in folders and used for transmitting information between cloud resources and connecting resources to the internet.
keywords:
  - cloud network
  - cloud
  - network
---

# Cloud networks and subnets

## Cloud networks {#network}

_A cloud network_ is similar to a traditional LAN in a data center. Cloud networks are created in folders and used for transmitting information between cloud resources and connecting resources to the internet.

Public IP addresses are used for providing internet access to and from {{ compute-full-name }} VMs and database hosts.

### Filtering outgoing traffic {#egress-traffic-filter}

{% include [port-25.md](../../_includes/vpc/port-25.md) %}

## Subnets {#subnet}

_A subnet_ is a range of IP addresses in a cloud network. Addresses from this range can be assigned to cloud resources, such as VMs and DB clusters. Subnets can only be created in the folder the cloud network belongs to.

The size of a subnet is set using the Classless Inter-Domain Routing (CIDR) method. Subnets can only use private IPv4 addresses from the ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918):
* `10.0.0.0/8`
* `172.16.0.0/12`
* `192.168.0.0/16`

The maximum CIDR size in these ranges is /16 and the minimum is /28.

Subnet IP address ranges cannot overlap within the same cloud network. The first two addresses from any range are allocated to the gateway (x.x.x.1) and DNS server (x.x.x.2).

Traffic can be transmitted between subnets of the same network, but not subnets of different networks. To transfer traffic between subnets of different networks, use public IP addresses.

To have a resource connected to a subnet, make sure it resides in the same availability zone as the subnet. You cannot move subnets to different availability zones.