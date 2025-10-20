1. To migrate user traffic from an external network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, update the `A` record value for the service domain name to point to the L7 load balancer's public IP address. If the public domain zone was created in [{{ dns-full-name }}](../../../dns/), update the record using [this guide](../../../dns/operations/resource-record-update.md).

    {% note info %}

    The migration may take a while because the propagation of DNS record's updates depends on its time-to-live (TTL) and the number of links in the DNS request chain.

    {% endnote %}

1. As the DNS record updates propagate, monitor the increase in requests to the L7 load balancer on the [load balancer statistics](../../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Monitor the decrease in traffic on the external network load balancer using the `processed_bytes` and `processed_packets` [load balancer metrics](../../../monitoring/metrics-ref/network-load-balancer-ref.md). You can [create a dashboard](../../../monitoring/operations/dashboard/create.md) to visualize these metrics. If there is no load on the network load balancer for a long time, the migration to the L7 load balancer is complete.

1. Optionally, once migration is complete, [delete the external network load balancer](../../../network-load-balancer/operations/load-balancer-delete.md). Select an option that agrees with the method you initially used to deploy your NGINX Ingress Controller:

    {% list tabs %}

    * Using a Helm chart

        1. In the `values.yaml` file you used to initially configure the NGINX Ingress Controller, under `controller.service.external`, set `enabled: false`. Leave the other parameters in the file unchanged.

            ```bash
            controller:
              service:
                external:
                  enabled: false
                ...
            ```

        1. Use this command to apply the configuration changes for the NGINX Ingress Controller:

            ```bash
            helm upgrade <NGINX_Ingress_Controller_name> -f values.yaml <chart_for_NGINX_Ingress_Controller> -n <namespace>
            ```

        {% note warning %}

        When you update the NGINX Ingress Controller configuration, your service will be temporarily unavailable.

        {% endnote %}

    * Using a manifest

        Delete the `Service` resource for the external network load balancer using this command:

        ```bash
        kubectl delete service <name_of_Service_resource_for_external_network_load_balancer>
        ```

    {% endlist %}

1. Optionally, wait until the external network load balancer for the NGINX Ingress Controller and its respective `Service` object are deleted. You can use this command to view information about the services:

    ```bash
    kubectl get service
    ```
