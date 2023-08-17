---
title: "Network load balancer"
description: "A network load balancer is used to evenly distribute the load across cloud resources. The {{ yandex-cloud }} network load balancer runs at layer 4 of the OSI model. It also uses technologies running at layer 3 to speed up data packet processing."
---

# Network load balancer. Overview

A *network load balancer* is used to evenly distribute the load across cloud resources. A load balancer is created in a folder and can serve resources from multiple availability zones. You can attach only one target group to each load balancer. The health of resources in such a group is monitored through a [health check](health-check.md). Traffic receipt is managed by the load balancer's [listener](listener.md).

The {{ yandex-cloud }} network load balancer runs at layer 4 of the OSI model. It also uses technologies running at layer 3 to speed up data packet processing.

Traffic is distributed using the 5-tuple approach, i.e., based on the source IP, source port, destination IP, and destination port of the recipient cloud resource, as well as on the protocol type.

When creating a network load balancer, a pre-created [target group](target-resources.md) is attached to it with cloud resources the incoming traffic will be distributed across. Each cloud resource in a target group is defined by a pair of the [internal IPv4 address](../../vpc/concepts/address.md) and [subnet](../../vpc/concepts/network.md#subnet) ID. Targets within a single group must be located in the same cloud network. Targets within a single availability zone must be located in the same subnet.

By hosting resources in different availability zones, you ensure their fault tolerance: if there are targets in every availability zone and they are ready to receive traffic, the traffic is distributed across all zones. If all targets in an availability zone fail, the traffic will no longer be routed to this zone and will be distributed across the remaining zones.

For detailed recommendations on how to use a load balancer, see [Best practices](../best-practices/index.md).


## Network load balancer status {#lb-statuses}

A load balancer you create can have one of the following statuses:

* `CREATING`: Load balancer is being created.
* `STARTING`: Load balancer is being started.
* `ACTIVE`: Load balancer is running, performing health checks, and routing traffic to the target group resources.
* `STOPPING`: Load balancer is being stopped.
* `STOPPED`: Load balancer is stopped and is not performing health checks or distributing traffic.
* `DELETING`: Load balancer is being deleted.
* `INACTIVE`: Load balancer has no listeners or the target groups attached to it contain no targets. The load balancer is not performing any checks or distributing any traffic.