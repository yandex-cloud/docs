# Network load balancer

*A network load balancer* is used to evenly distribute the load across cloud resources. A load balancer is created in a folder and can serve resources from multiple availability zones. Only one target group can be attached to each load balancer. The health of resources in that group is monitored through a [health check](health-check.md).

The Yandex.Cloud Load Balancer uses Layer 3 technologies of the OSI model. 

Traffic is distributed using the 5-tuple affinity, using the source IP, source port, destination IP, and destination port of the recipient cloud resource, and the protocol type.

When creating a load balancer, a pre-created [target group](target-resources.md) is attached to it with cloud resources that incoming traffic will be distributed across. Each cloud resource in a target group is defined by a pair of  [internal IPv4 address](../../vpc/concepts/address.md) and the [subnet](../../vpc/concepts/network.md#subnet) ID. Targets within one group must be located in the same cloud network. Targets within a single availability zone must be located in the same subnet.

By hosting resources in different availability zones, you ensure their fault tolerance: if all the resources within one zone fail, the load balancer will redirect incoming traffic to resources in other zones. For detailed recommendations on how to use a load balancer, see [Best practices](../best-practices.md).

## Network load balancer status {#lb-statuses}

A created load balancer can have one of the following statuses:

* `CREATING`: the load balancer is being created.
* `STARTING`: the load balancer is being started.
* `ACTIVE`: the load balancer is running, performing health checks, and routing traffic to the target group resources.
* `STOPPING`: the load balancer is being stopped.
* `STOPPED`: the load balancer is stopped and is not performing health checks or distributing traffic.
* `DELETING`: the load balancer is being deleted.
* `INACTIVE`: the load balancer has no listeners or the target groups attached to it contain no targets. The load balancer is not performing any checks or distributing any traffic.

