---
title: '{{ cr-full-name }} terminology'
description: You can find the key {{ cr-full-name }} terms below.
---

# {{ cr-name }} terminology

* **Hybrid Cloud**: Type of IT infrastructure that combines internal IT resources of the company, on one hand, and resources in public clouds, on the other hand.

* **On-prem**: The customer's site hosting their IT resources and network hardware for connection to {{ yandex-cloud }} via [{{ interconnect-name }}](../../interconnect/concepts/index.md).

* [Cloud network (VPC, Network)](../../vpc/concepts/network.md): A {{ vpc-name }} resource. A cloud network is used for ensuring network connectivity in all [availability zones](../../overview/concepts/geo-scope.md) of the same region.

* [Subnet](../../vpc/concepts/network.md#subnet): A {{ vpc-name }} resource. Belongs to a cloud network. Each subnet has an IP prefix (CIDR). Each subnet is always linked to a single [availability zone](../../overview/concepts/geo-scope.md). Cloud resources are connected to a subnet.

* [Private connection (PRC)](../../interconnect/concepts/priv-con.md): A [{{ interconnect-name }}](../../interconnect/concepts/index.md) resource.

* [Routing instance (RI)](./routing-instance.md) is a resource you can use create a specific network topology which may include:
  * IP prefixes of [subnets](../../vpc/concepts/network.md#subnet) of one or multiple networks.
  * Private connections The number of private connections depends on the network topology type.
