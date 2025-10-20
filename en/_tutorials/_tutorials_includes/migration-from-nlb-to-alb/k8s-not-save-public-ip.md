1. To migrate user traffic from a network load balancer to an L7 load balancer, in your domain's public zone DNS service, change the A record for the service domain name to the L7 load balancer's public IP address. If the public domain zone was created in [{{ dns-full-name }}](../../../dns/), update the record using [this guide](../../../dns/operations/resource-record-update.md).

    {% note info %}

    The migration may take a while because the propagation of DNS record's updates depends on its time-to-live (TTL) and the number of links in the DNS request chain.

    {% endnote %}

1. As the DNS record updates propagate, monitor the increase in requests to the L7 load balancer.

    1. In the [management console]({{ link-console-main }}), navigate to the folder with the {{ managed-k8s-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster in question.
    1. Select ![image](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left and then the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer's user traffic on the [load balancer statistics](../../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Monitor the decrease in traffic on the network load balancer using the `processed_bytes` and `processed_packets` [load balancer metrics](../../../monitoring/metrics-ref/network-load-balancer-ref.md). You can [create a dashboard](../../../monitoring/operations/dashboard/create.md) to visualize these metrics. If there is no load on the network load balancer for a long time, the migration to the L7 load balancer is complete.

1. Optionally, [delete the network load balancer](../../../network-load-balancer/operations/load-balancer-delete.md) after migrating user traffic to the L7 load balancer.
