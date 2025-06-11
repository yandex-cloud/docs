# Targets and target groups

*Target group* is a set of resources that receive traffic from a listener. Essentially, this is a list of IP addresses of [VM](../../compute/concepts/vm.md) network interfaces in {{ yandex-cloud }}.

To create a target group, you need to specify its name and the list of resources (IP addresses) that will be included in this group.

You can connect a single target group to multiple load balancers.

If a load balancer uses multiple traffic listeners, the incoming traffic to these listeners will be distributed simultaneously across all target groups connected to this load balancer.

Each resource in a target group is identified by a pair: the [internal IPv4 address](../../vpc/concepts/address.md) of the VM network interface and the [subnet](../../vpc/concepts/network.md#subnet) ID. Resources of the same group must be located in the same [cloud network](../../vpc/concepts/network.md). You cannot add resources from different networks or outside {{ yandex-cloud }} to a target group. Within a single availability zone, resources in a target group must be in the same subnet.

You can only connect a VM network interface to one target group. You cannot connect a VM network interface to multiple target groups at once.

If you need to include a VM in multiple target groups, you can create a VM with multiple network interfaces and include each of them in a different target group.

## Load balancing {#distribution}


Placing resources in different availability zones ensures fault tolerance of a service running a network load balancer. If resources are available in all availability zones and are ready to receive traffic, the traffic is distributed across all zones. If all targets in an availability zone fail, the traffic will no longer be routed to this zone and will be distributed across the remaining zones.

The traffic is always distributed roughly equally between availability zones. If the number of target resources behind the network load balancer varies across the zones, the load on individual resources in each zone will also be different.

For example, if in one group of target resources there are two resources in zone A and four resources in zone B, the load on each resource in zone A will be about 25% (50%/2) of the total traffic, and the load on each resource in zone B will be about 12.5% (50%/4).

{% note alert %}

Keep in mind that the load distribution among target resources is a complex process that depends on many factors. The algorithm for distributing traffic among target resources may change moving forward; this is why you should build your solutions without dependencies on the distribution algorithm implementation and follow the [recommendations](./best-practices.md#create-reserves).

{% endnote %}

## Combining listeners and target groups {#lsn-group}

You can implement the following use cases on a network load balancer:

1. One listener and one target group. This is the minimum configuration possible. Resources in a target group can be located in one or more availability zones.
2. One listener and multiple target groups. You can add resources from different availability zones in different groups.
3. Multiple listeners and one target group. Each listener accepts traffic on a dedicated port.
4. Multiple listeners and multiple target groups:
    * Each listener has its own target groups (one or more).
    * Node groups (one or more) are shared across all listeners.


## Use cases {#examples}

* [{#T}](../tutorials/web-service.md)
* [{#T}](../tutorials/updating-under-load.md)
* [{#T}](../tutorials/dns-integration.md)
* [{#T}](../tutorials/exchange.md)
* [{#T}](../tutorials/mssql-alwayson-lb.md)
* [{#T}](../tutorials/storage-vpc-access.md)
* [{#T}](../tutorials/vpc-cr-access.md)
* [{#T}](../tutorials/migration-from-nlb-to-alb/index.md)