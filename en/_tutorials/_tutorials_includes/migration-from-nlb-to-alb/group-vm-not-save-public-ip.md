1. Monitor the [status](../../../network-load-balancer/operations/check-resource-health.md) of your network load balancer’s targets. Wait until the targets are automatically deleted from the target group.

1. [Create a target group](../../../network-load-balancer/operations/target-group-create.md) for the network load balancer. Add the VMs recreated when updating the instance group.

1. In the network load balancer, [attach the target group](../../../network-load-balancer/operations/target-group-attach.md) created in the previous step. When attaching the target group, configure the same health checks as in the original target group.

1. Wait until the [health checks](../../../network-load-balancer/operations/check-resource-health.md) for the VMs in the network load balancer’s target group return `Healthy`. This will make your service once again available through the network load balancer.

1. To migrate user traffic from a network load balancer to an L7 load balancer, in your domain's public zone DNS service, change the A record for the service domain name to the L7 load balancer's public IP address. If the public domain zone was created in [{{ dns-full-name }}](../../../dns/), update the record using [this guide](../../../dns/operations/resource-record-update.md).

    {% note info %}

    The migration may take a while because the propagation of DNS record's updates depends on its time-to-live (TTL) and the number of links in the DNS request chain.

    {% endnote %}

1. As the DNS record updates propagate, monitor the increase in requests to the L7 load balancer on the [load balancer statistics](../../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Monitor the decrease in traffic on the network load balancer using the `processed_bytes` and `processed_packets` [load balancer metrics](../../../monitoring/metrics-ref/network-load-balancer-ref.md). You can [create a dashboard](../../../monitoring/operations/dashboard/create.md) to visualize these metrics. If there is no load on the network load balancer for a long time, the migration to the L7 load balancer is complete.

1. Optionally, [delete the network load balancer](../../../network-load-balancer/operations/load-balancer-delete.md) after migrating user traffic to the L7 load balancer.
