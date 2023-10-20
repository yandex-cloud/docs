---
title: "Network load balancer types"
description: "You can deploy the following types of network load balancers in {{ yandex-cloud }}: EXTERNAL to handle internet traffic, and INTERNAL to handle traffic inside {{ vpc-name }}."
---

# Network load balancer types

{% note info %}

{% include [type-update](../../_includes/network-load-balancer/type-update.md) %}

{% endnote %}

Here are the options for deploying a network load balancer in {{ yandex-cloud }}:

* An external load balancer (`EXTERNAL`) is created by default. It is used to handle Internet traffic.
* An internal load balancer (`INTERNAL`) is used for handling traffic within {{ vpc-name }}.

These load balancers operate similarly, but you should keep the following distinctions in mind:

| **Load balancer property** | **External** | **Internal** |
| --- | --- | --- |
| Listener IP address | [Public](../../vpc/concepts/ips.md) IP addresses only | IP addresses from [RFC-1918](https://www.ietf.org/rfc/rfc1918.txt) only |
| Blocking the listener target port for traffic on target VMs | blocked | blocked |
| Blocking the listener target port for health checks on target VMs | active | blocked |
| Locality in traffic processing | - | [specifics apply](./specifics.md#nlb-int-locality) |
| Use of static routes | - | [specifics apply](./specifics.md#nlb-int-routing) |

Explanation of the table:
* The VM ports (Target-Port) used to receive traffic from the internal load balancer and health checks become unavailable for connecting.
The VMs will only receive traffic from the internal load balancer. The same restriction will not allow a VM from the load balancer's target group to access it through the port being used.
* The VM ports (Target-Port) used to receive traffic from the external load balancer become unavailable for connection. The VMs will only receive traffic from the external load balancer. The same restriction will not allow a VM from the load balancer's target group to access it through the port being used.
* For example, [in the scheme](./scenarios.md#nlb-vm), port `8080` of <q>Listener-2</q> for the `vm-a2` and `vm-b2` VMs will be blocked for connection from cloud resources in the 10.0.1.0/24 and 10.0.2.0/24 subnets, respectively.
