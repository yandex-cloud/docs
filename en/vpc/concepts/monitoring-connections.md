# Monitoring network connections

To ensure the performance of a network load balancer and security groups, {{ vpc-short-name }} monitors network connections.

Two records are created for each connection: one for incoming VM traffic and one for outgoing VM traffic. The records are deleted once the following conditions are met:

{% include [conditions-for-deleting-records](../../_includes/vpc/conditions-for-deleting-records.md) %}

Learn more about [viewing connection charts](../operations/connections-view.md).

You can create up to 10,0000 records, which corresponds to 50,000 connections. When this limit is reached, new connections are discarded. The limit on the number of records doesn't depend on the size or number of VM network interfaces. To increase the limit, [contact]({{ link-console-support }}) support.

When using [security groups](security-groups.md), a record is created if the first packet is received in the direction that has a rule allowing traffic. Therefore, we recommend setting the `keepalive` parameter to a value less than three minutes for the VM operating system and your applications.

> For example, set the sysctl system parameters for a Linux-based operating system as follows:
> * net.ipv4.tcp_keepalive_idle = 120
> * net.ipv4.tcp_keepalive_intvl = 60
> * net.ipv4.tcp_keepalive_probes = 4
