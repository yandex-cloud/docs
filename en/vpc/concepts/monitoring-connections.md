# Monitoring network connections

To ensure the performance of the [network load balancer](../../network-load-balancer) and [security groups](./security-groups.md), {{ vpc-short-name }} monitors network connections.

A network connection refers to the [traffic flow](https://en.wikipedia.org/wiki/Traffic_flow_%28computer_networking%29) in any direction. Five parameters uniquely define a connection: source IP address, source port, target IP address, target port, and network protocol. The target and source order is disregarded.

When using security groups, a connection is created if the first packet is received in the direction that has a rule allowing traffic.

The network connection lifecycle ends in the following cases:

{% include [conditions-for-deleting-records](../../_includes/vpc/conditions-for-deleting-records.md) %}

Therefore, we recommend setting the `keepalive` parameter to less than three minutes for the VM operating system and your applications.

> For example, set the `sysctl` system parameters for a Linux-based operating system as follows:
>
> * net.ipv4.tcp_keepalive_time = 120
> * net.ipv4.tcp_keepalive_intvl = 60
> * net.ipv4.tcp_keepalive_probes = 4

The connection number limit is 350,000 when using security groups. Please note that the limit applies only if a user-created security group is assigned to the VM. Upon reaching this limit, new connections are discarded. The limit applies to a specific network interface of the virtual machine.

You can learn more about viewing connection charts [here](../operations/connections-view.md).
