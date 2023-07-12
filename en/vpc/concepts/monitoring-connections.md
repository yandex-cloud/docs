# Monitoring network connections

To ensure the performance of the network load balancer and [security groups](security-groups.md), {{ vpc-short-name }} monitors network connections.

{% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

Two records are created for each connection: one for incoming VM traffic and another one for outgoing VM traffic. The records are deleted once the following conditions are met:

{% include [conditions-for-deleting-records](../../_includes/vpc/conditions-for-deleting-records.md) %}

You can learn more about viewing connection charts [here](../operations/connections-view.md).

You can create up to 100,000 records, which corresponds to 50,000 connections. When this limit is reached, new connections are discarded. The limit on the number of records does not depend on the size or number of VM network interfaces. To increase the limit, [contact]({{ link-console-support }}) support.

When using security groups, a record is created if the first packet is received in the direction that has a rule allowing traffic. Therefore, we recommend setting the `keepalive` parameter to a value less than three minutes for the VM operating system and your applications.

> For example, set the sysctl system parameters for a Linux-based operating system as follows:
> * net.ipv4.tcp_keepalive_time = 120
> * net.ipv4.tcp_keepalive_intvl = 60
> * net.ipv4.tcp_keepalive_probes = 4
