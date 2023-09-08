# Target groups

An L7 load balancer target group is a set of IP addresses of VMs that your network applications are running on. To enable the load balancer to distribute routing requests between the VMs of the target group, specify it in the [backend group](backend-group.md) configuration.

The main targets in a group are VMs connected to {{ vpc-name }} [subnets](../../vpc/concepts/network.md#subnet). For your L7 load balancer to run properly, make sure the target subnets are located in the same [cloud network](../../vpc/concepts/network.md#network).


You can also add to a target group targets residing outside {{ vpc-name }}, e.g., in your data center connected to {{ yandex-cloud }} through [{{ interconnect-name }}](../../interconnect/index.yaml). The IP addresses of targets must be within the [RFC 1918 private ranges](https://datatracker.ietf.org/doc/html/rfc1918#section-3). For more information, see [Subnets](../../vpc/concepts/network.md#subnet).

You can create target groups:

* [Manually](../operations/target-group-create.md). In this case, if you change the VM internal IP address, for example, when moving it to another subnet, make sure to update the target group: first remove the VM and then add the modified VM back to it.
* [Using {{ ig-name }}](../../compute/operations/instance-groups/create-with-load-balancer.md). When you change the VM configuration, {{ ig-name }} automatically updates IP addresses of VMs in the target group. If the target group is connected to a backend group, {{ ig-name }} also monitors health check results delivered by the L7 load balancer.

{% include [target-group-deletion-restriction](../../_includes/application-load-balancer/target-group-deletion-restriction.md) %}