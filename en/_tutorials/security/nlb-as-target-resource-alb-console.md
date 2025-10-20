# Migrating services from an external NLB to an L7 ALB with an internal NLB as a target using the management console


To migrate a service from an external network load balancer to an L7 load balancer:

1. [See the service migration recommendations](#recommendations).
1. [Create a migration infrastructure](#before-you-begin).
1. [Create a {{ sws-name }} profile](#create-profile-sws).
1. [Create an internal network load balancer for the NGINX Ingress Controller](#create-internal-nlb).
1. [Create an L7 load balancer](#create-alb). At this step, you will associate the {{ sws-name }} profile with a virtual host of the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate user traffic from the external network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Create your infrastructure {#before-you-begin}

1. [Create subnets](../../vpc/operations/subnet-create.md) in three availability zones for the L7 load balancer.

1. Create [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) that allow the L7 load balancer to receive inbound traffic and send it to the targets and allow the targets to receive inbound traffic from the load balancer.

1. When using HTTPS, [add the TLS certificate](../../certificate-manager/operations/import/cert-create.md#create-certificate) of your service to [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. Optionally, [reserve an L3-L4 DDoS-protected static public IP address](../../vpc/operations/get-static-ip.md) for the L7 load balancer.

## Create a {{ sws-name }} profile {#create-profile-sws}

{% include [create-profile-sws](../_tutorials_includes/migration-from-nlb-to-alb/create-profile-sws.md) %}

## Create an internal network load balancer for the NGINX Ingress Controller {#create-internal-nlb}

{% include [create-internal-nlb](../_tutorials_includes/migration-from-nlb-to-alb/create-internal-nlb.md) %}

## Create an L7 load balancer {#create-alb}

1. [Create a target group](../../application-load-balancer/operations/target-group-create.md) for the L7 load balancer. Under **{{ ui-key.yacloud.alb.label_targets }}**, select **{{ ui-key.yacloud.alb.label_target-private-ip }}** and specify an internal IP address for the internal network load balancer. Click **{{ ui-key.yacloud.alb.button_add-target }}** and then **{{ ui-key.yacloud.common.create }}**.

1. [Create a backend group](../../application-load-balancer/operations/backend-group-create.md) with the following settings:

    1. Select `{{ ui-key.yacloud.alb.label_proto-http }}` as the backend group type.
    1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}** and set up the backend:

        * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_target-group }}`.
        * **{{ ui-key.yacloud.alb.label_target-groups }}**: Target group you created earlier.
        * **{{ ui-key.yacloud.alb.label_port }}**: TCP port configured for your internal network load balancer's listener. Usually, this is port `80` for HTTP and port `443` for HTTPS.
        * Under **{{ ui-key.yacloud.alb.label_protocol-settings }}**, select `{{ ui-key.yacloud.alb.label_proto-http-plain }}` or `{{ ui-key.yacloud.alb.label_proto-http-tls }}` depending on the protocol used by your service.
        * Under **HTTP health check**, delete the health check. Do not add it, as the network load balancer used as the target is a fault-tolerant service.

1. [Create an HTTP router](../../application-load-balancer/operations/http-router-create.md).

    Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}** and configure the virtual host:

    * **{{ ui-key.yacloud.alb.label_authority }}**: Your service domain name.
    * **{{ ui-key.yacloud.alb.label_security-profile-id }}**: {{ sws-name }} profile you created earlier.

        {% note warning %}

        {{ sws-name }} cannot be made operational without linking a security profile to the L7 load balancer's virtual host.

        {% endnote %}

    * Click **{{ ui-key.yacloud.alb.button_add-route }}** and configure the route:

        * **{{ ui-key.yacloud.alb.label_path }}**: `Starts with` `/`.
        * **{{ ui-key.yacloud.alb.label_route-action }}**: `{{ ui-key.yacloud.alb.label_route-action-route }}`.
        * **{{ ui-key.yacloud.alb.label_backend-group }}**: Backend group you created earlier.

    You can add multiple domains by clicking **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.

1. [Create an L7 load balancer](../../application-load-balancer/operations/application-load-balancer-create.md) by selecting **{{ ui-key.yacloud.alb.label_alb-create-form }}**:

    1. Specify the security group you created earlier.

        {% note warning %}

        The node groups in the {{ managed-k8s-name }} cluster must have inbound security group rules allowing traffic from the L7 load balancer on ports 30000-32767, coming either from its subnets or its security group.

        {% endnote %}

    1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select subnets in three availability zones for the load balancer nodes. Enable traffic in these subnets.
    1. Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, specify the [minimum number of resource units](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) per availability zone based on expected load.
    1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}** and set up the listener:

        1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**, specify:

            * **{{ ui-key.yacloud.alb.label_port }}**: TCP port configured for your internal network load balancer's listener. Usually, this is port `80` for HTTP and port `443` for HTTPS.
            * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.alb.label_address-list }}`. Select a public IP address from the list. If you plan to enable DDoS protection at levels L3-L4, select a static public IP address with DDoS protection installed.
        1. Under **{{ ui-key.yacloud.alb.section_common-address-specs }}**, specify:

            * **{{ ui-key.yacloud.alb.label_listener-type }}**: `{{ ui-key.yacloud.alb.label_listener-type-http }}`.
            * **{{ ui-key.yacloud.alb.label_protocol-type }}**: Select `{{ ui-key.yacloud.alb.label_proto-http-plain }}` or `{{ ui-key.yacloud.alb.label_proto-http-tls }}` depending on the protocol your service uses.
            * If you select `{{ ui-key.yacloud.alb.label_proto-http-tls }}`, specify the TLS certificate you added to {{ certificate-manager-name }} earlier in the **{{ ui-key.yacloud.alb.label_certificate }}** field.
            * **{{ ui-key.yacloud.alb.label_http-router }}**: Select the HTTP router you created earlier.

## Test the L7 load balancer {#test}

1. Wait until the L7 load balancer goes `Active`.

1. Navigate to the new L7 load balancer and select **{{ ui-key.yacloud.alb.label_healthchecks }}** on the left. Make sure you get `HEALTHY` for all checks.

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate user traffic from the external network load balancer to the L7 load balancer {#migration-nlb-to-alb}

Select one of these migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep the public IP address for your service](#not-save-public-ip).

### Keep the public IP address for your service {#save-public-ip}

1. If your external network load balancer is using a dynamic public IP address, [convert it to a static one](../../vpc/operations/set-static-ip.md).

1. Delete the external network load balancer. Select an option that agrees with the method you initially used to deploy your NGINX Ingress Controller:

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

    * Using a manifest

        Delete the `Service` resource for the external network load balancer using this command:

        ```bash
        kubectl delete service <name_of_Service_resource_for_external_network_load_balancer>
        ```

    {% endlist %}

1. Wait until the external network load balancer for the NGINX Ingress Controller and its respective `Service` object are deleted. You can use this command to view information about the services:

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

1. After the IP address changes, your service will again be available through the L7 load balancer. Monitor the L7 load balancer's user traffic on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the now free static public IP address you selected when creating the L7 load balancer.

### Do not keep the public IP address for your service {#not-save-public-ip}

{% include [nlb-alb-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/nlb-alb-not-save-public-ip.md) %}
