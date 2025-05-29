# Migrating services from an external NLB to L7 ALB, with an internal NLB as a target, using the management console


To migrate a service from an external network load balancer to an L7 load balancer:

1. [See the recommendations for service migration](#recommendations).
1. [Complete the prerequisite steps](#before-you-begin).
1. [Create a {{ sws-name }} profile](#create-profile-sws).
1. [Create an internal network load balancer for the NGINX Ingress controller](#create-internal-nlb).
1. [Create an L7 load balancer](#create-alb). At this step, you will associate the {{ sws-name }} security profile with a virtual host of the L7 load balancer.
1. [Migrate user load from the external network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Getting started {#before-you-begin}

1. [Create subnets](../../vpc/operations/subnet-create.md) in three availability zones for the L7 load balancer.

1. Create [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) that allow the L7 load balancer to receive incoming traffic and send it to the targets and allow the targets to receive incoming traffic from the load balancer.

1. When using HTTPS, [add the TLS certificate of your service](../../certificate-manager/operations/import/cert-create.md#create-certificate) to [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. [Reserve a static public IP address with DDoS protection](../../vpc/operations/get-static-ip.md) at Layer 3 – Layer 4 for the L7 load balancer. See the [service migration recommendations](#recommendations).

## Create a {{ sws-name }} security profile {#create-profile-sws}

[Create](../../smartwebsecurity/operations/profile-create.md) a {{ sws-name }} security profile by selecting **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

Use these settings when creating the profile:

* In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
* For the **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** rule, enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**.

These settings are limited to logging the info about the traffic without applying any actions to it. This will reduce the risk of disconnecting users due to profile configuration issues. As you move along, you will be able to disable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** and configure deny rules in the security profile.

## Create an internal network load balancer for the NGINX Ingress controller {#create-internal-nlb}

{% include [create-internal-nlb](../_tutorials_includes/migration-from-nlb-to-alb/create-internal-nlb.md) %}

## Create an L7 load balancer {#create-alb}

1. [Create a target group](../../application-load-balancer/operations/target-group-create.md) for the L7 load balancer. Under **{{ ui-key.yacloud.alb.label_targets }}**, select **{{ ui-key.yacloud.alb.label_target-private-ip }}** and specify an internal IP address for the internal network load balancer. Click **{{ ui-key.yacloud.alb.button_add-target }}** and then **{{ ui-key.yacloud.common.create }}**.

1. [Create a group of backends](../../application-load-balancer/operations/backend-group-create.md) with the following parameters:

    1. Select `{{ ui-key.yacloud.alb.label_proto-http }}` as the backend group type.
    1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}** and set up the backend:

        * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_target-group }}`.
        * **{{ ui-key.yacloud.alb.label_target-groups }}**: Target group you created earlier.
        * **{{ ui-key.yacloud.alb.label_port }}**: TCP port configured for your internal network load balancer's listener. Usually, this is port `80` for HTTP and port `443` for HTTPS.
        * Under **{{ ui-key.yacloud.alb.label_protocol-settings }}**, select a protocol, `{{ ui-key.yacloud.alb.label_proto-http-plain }}` or `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, based on your service.
        * Under **HTTP health check**, delete the health check. Do not add it, as the network load balancer used as the target is a fault-tolerant service.

1. [Create an HTTP router](../../application-load-balancer/operations/http-router-create.md).

    Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}** and configure the virtual host:

    * **{{ ui-key.yacloud.alb.label_authority }}**: Your service domain name.
    * **{{ ui-key.yacloud.alb.label_security-profile-id }}**: {{ sws-name }} profile you created earlier.

        {% note warning %}

        Linking your security profile to a virtual host of the L7 load balancer is the key step for enabling {{ sws-name }}.

        {% endnote %}

    * Click **{{ ui-key.yacloud.alb.button_add-route }}** and configure the route:

        * **{{ ui-key.yacloud.alb.label_path }}**: `Starts with` `/`.
        * **{{ ui-key.yacloud.alb.label_route-action }}**: `{{ ui-key.yacloud.alb.label_route-action-route }}`.
        * **{{ ui-key.yacloud.alb.label_backend-group }}**: Backend group you created earlier.

    You can add multiple domains by clicking **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.

1. [Create an L7 load balancer](../../application-load-balancer/operations/application-load-balancer-create.md) by selecting **{{ ui-key.yacloud.alb.label_alb-create-form }}**:

    * Specify the previously created security group.

        {% note warning %}

        The {{ managed-k8s-name }} cluster node groups must have security group rules that allow incoming connections from the L7 load balancer to a range of ports (30000-32767) from the subnets hosting the L7 load balancer or from its security group.

        {% endnote %}

    * Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select the subnets in three availability zones for the load balancer nodes. Enable traffic in these subnets.
    * Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, specify the [minimum number of resource units](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) per availability zone based on expected load.

        We recommend selecting the number of resource units based on the load expressed in:

        * Number of requests per second (RPS)
        * Number of concurrent active connections
        * Number of new connections per second
        * Traffic processed per second

    * Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}** and set up the listener:

        * Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, specify:

            * **{{ ui-key.yacloud.alb.label_port }}**: TCP port configured for your internal network load balancer's listener. Usually, this is port `80` for HTTP and port `443` for HTTPS.
            * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_address-list }}`. Select from the list a public IP address with DDoS protection at L3-L4. For more information, see the [service migration recommendations](#recommendations).
        * Under **{{ ui-key.yacloud.alb.section_common-address-specs }}**, specify:

            * **{{ ui-key.yacloud.alb.label_listener-type }}**: `{{ ui-key.yacloud.alb.label_listener-type-http }}`.
            * **{{ ui-key.yacloud.alb.label_protocol-type }}**: Depending on your service, select `{{ ui-key.yacloud.alb.label_proto-http-plain }}` or `{{ ui-key.yacloud.alb.label_proto-http-tls }}`.
            * If you select `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, specify the TLS certificate you added to {{ certificate-manager-name }} earlier in the **{{ ui-key.yacloud.alb.label_certificate }}** field.
            * **{{ ui-key.yacloud.alb.label_http-router }}**: HTTP router you created earlier.

1. Wait until the L7 load balancer goes `Active`.

1. Go to the new L7 load balancer and select **{{ ui-key.yacloud.alb.label_healthchecks }}** on the left. Make sure you get `HEALTHY` for all the L7 load balancer's health checks.

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate the user load from the external load balancer to the L7 load balancer {#migration-nlb-to-alb}

Select one of the migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep public IP address for your service](#not-save-public-ip).

### Keep the public IP address for your service {#save-public-ip}

1. If your external network load balancer is using a dynamic public IP address, [convert it to a static one](../../vpc/operations/set-static-ip.md).

1. Delete the external network load balancer. Select an option that agrees with the method you initially used to deploy your NGINX Ingress controller:

    {% list tabs %}

    * Using a Helm chart

        1. In the `values.yaml` file you used to initially configure the NGINX Ingress controller, under `controller.service.external`, set `enabled: false`. Do not change the other parameters in the file.

            ```bash
            controller:
              service:
                external:
                  enabled: false
                ...
            ```

        1. Use this command to apply the NGINX Ingress controller configuration changes:

            ```bash
            helm upgrade <NGINX_Ingress_controller_name> -f values.yaml <chart_for_NGINX_Ingress_controller> -n <namespace>
            ```

    * Using a manifest

        Delete the `Service` resource for the external network load balancer using this command:

        ```bash
        kubectl delete service <name_of_Service_resource_for_external_network_load_balancer>
        ```

    {% endlist %}

1. Wait until the external network load balancer for the NGINX Ingress controller and its respective `Service` object are deleted. You can use this command to view information about the services:

    ```bash
    kubectl get service
    ```

    This will make your service unavailable through the external network load balancer.

1. In the L7 load balancer, assign to the listener the public IP address previously assigned to the external network load balancer.

    {% list tabs group=instructions %}

    * CLI {#cli}

        {% include [include](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        To change the public IP address, run this command:

        ```bash
        yc application-load-balancer load-balancer update-listener <load_balancer_name> \
           --listener-name <listener_name> \
           --external-ipv4-endpoint address=<service_public_IP_address>,port=<service_port>
        ```

        Where `address` is the public IP address previously assigned to the external network load balancer.

    {% endlist %}

1. After the IP address changes, your service will again be available through the L7 load balancer. Monitor the L7 load balancer's user load on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the now free static public IP address you selected when creating the L7 load balancer.

### Do not keep the public IP address for your service {#not-save-public-ip}

1. To migrate the user load from an external network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, change the A record value for the service domain name to the public IP address of the L7 load balancer. If the public domain zone was created in [{{ dns-full-name }}](../../dns/), change the record using [this guide](../../dns/operations/resource-record-update.md).

    {% note info %}

    The propagation of DNS record updates depends on the time-to-live (TTL) value and the number of links in the DNS request chain. This process can take a long time.

    {% endnote %}

1. As the DNS record updates propagate, follow the increase of requests to the L7 load balancer on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Follow the decrease of the external network load balancer load using the `processed_bytes` and `processed_packets` [load balancer metrics](../../monitoring/metrics-ref/network-load-balancer-ref.md). You can also [create a dashboard](../../monitoring/operations/dashboard/create.md) to visualize these metrics. The absence of load on the external network load balancer for a prolonged period of time indicates that the user load has been transferred to the L7 load balancer.

1. Optionally, [delete the external network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating the user load to the L7 load balancer. Select an option that agrees with the method you initially used to deploy your NGINX Ingress controller:

    {% list tabs %}

    * Using a Helm chart

        1. In the `values.yaml` file you used to initially configure the NGINX Ingress controller, under `controller.service.external`, set `enabled: false`. Do not change the other parameters in the file.

            ```bash
            controller:
              service:
                external:
                  enabled: false
                ...
            ```

        1. Use this command to apply the NGINX Ingress controller configuration changes:

            ```bash
            helm upgrade <NGINX_Ingress_controller_name> -f values.yaml <chart_for_NGINX_Ingress_controller> -n <namespace>
            ```

        {% note warning %}

        When you update to the NGINX Ingress controller configuration, your service will be temporarily unavailable.

        {% endnote %}

    * Using a manifest

        Delete the `Service` resource for the external network load balancer using this command:

        ```bash
        kubectl delete service <name_of_Service_resource_for_external_network_load_balancer>
        ```

    {% endlist %}

1. Wait until the external network load balancer for the NGINX Ingress controller and its respective `Service` object are deleted. You can use this command to view information about the services:

    ```bash
    kubectl get service
    ```
