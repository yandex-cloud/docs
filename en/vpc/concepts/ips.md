---
title: Public IP address ranges in {{ yandex-cloud }}
description: Ranges of public IPv4 addresses of {{ yandex-cloud }} resources connected to {{ vpc-name }}.
---

# Public IP address ranges

Below are the ranges of public IPv4 addresses of {{ yandex-cloud }} resources connected to {{ vpc-name }}. These ranges are used by resources across various cloud services and clients and are not allocated to a specific NAT gateway.


{% include [vpc-ip-ru](../../_includes/public-ip/ru/vpc-ipv4.md) %}



For example, the resources assigned such IP address ranges are:

* [{{ compute-name }} VMs](../../compute/concepts/vm.md)
* [Database hosts](../../managed-greenplum/qa/cluster-hosts.md#what-is-cluster)
* [NAT instances](../tutorials/nat-instance/index.md)
* [NAT gateways](./gateways.md)
* [Network load balancers](../../network-load-balancer/concepts/index.md) and [application load balancers](../../application-load-balancer/concepts/application-load-balancer.md)

For the full list of public IP ranges in {{ yandex-cloud }}, see [{#T}](../../overview/concepts/public-ips.md) of **Platform overview**.

#### Useful links {#see-also}

* [Specifics of NAT gateway public IP addresses](./gateways.md#nat-gateway)
