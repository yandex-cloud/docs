# Migrating services from an external NLB to L7 ALB, with an internal NLB as a target, using {{ TF }}


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the recommendations for service migration](#recommendations).
1. [Create your infrastructure](#deploy). At this step, you will associate the {{ sws-name }} security profile with a virtual host of the L7 load balancer.
1. [Create an internal network load balancer for the NGINX Ingress controller](#create-internal-nlb).
1. [Test the L7 load balancer](#test).
1. [Migrate the user load from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Create an internal network load balancer for the NGINX Ingress controller {#create-internal-nlb}

{% include [create-internal-nlb](../_tutorials_includes/migration-from-nlb-to-alb/create-internal-nlb.md) %}

## Create an infrastructure for the L7 load balancer {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Download the configuration file to the same working directory based on the protocol you are using:
    * `HTTP`: [alb-int-nlb-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-internal-lb-migration/blob/main/alb-int-nlb-http.tf) configuration file.
    * `HTTPS`: [alb-int-nlb-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-internal-lb-migration/blob/main/alb-int-nlb-https.tf) configuration file.

    These files describe:

    * [Subnets](../../vpc/concepts/network.md#subnet) for the L7 load balancer.
    * [Security group](../../vpc/concepts/security-groups.md) for the L7 load balancer.
    * Static address for the L7 load balancer.
    * Importing a TLS certificate to {{ certificate-manager-name }} (if `HTTPS` is used).
    * {{ sws-name }} security profile.
    * Target group, backend group, and HTTP router for the L7 load balancer.
    * L7 load balancer.

1. In the configuration file, set the following custom properties:

    1. Specify the values for the variables:

        * `domain_name`: Your service domain name.
        * `network_id`: ID of the network containing the VMs from the network load balancer's target group.
        * `ip_address_int_nlb`: Internal IP address of the internal load balancer you [created earlier](#create-internal-nlb).
        * `certificate` (for `HTTPS`): Path to the self-signed custom certificate.
        * `private_key` (for `HTTPS`): Path to the private key file.

1. Make sure the {{ TF }} configuration files are correct using this command:

    ```bash
    terraform validate
    ```

    If there are any errors in the configuration files, {{ TF }} will point them out.

1. Create the required infrastructure:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

1. Specify the autoscaling settings in the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), select the folder where you created the L7 load balancer.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
    1. Click the name of the load balancer you need.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, set the [resource unit](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) limit.

## Test the L7 load balancer {#test}

1. Wait until the L7 load balancer goes `Active`.

1. Go to the new L7 load balancer and select **{{ ui-key.yacloud.alb.label_healthchecks }}** on the left. Make sure you get `HEALTHY` for all the L7 load balancer's health checks.

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate the user load from the external load balancer to the L7 load balancer {#migration-nlb-to-alb}

Select one of the migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep the public IP address for your service.](#not-save-public-ip)

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

    1. Open the configuration file you used to create the L7 load balancer (`alb-int-nlb-http.tf` or `alb-int-nlb-https.tf`).

    1. In the load balancer description, change the `address` parameter value under `listener.endpoint.address.external_ipv4_address`:

        ```hcl
        resource "yandex_alb_load_balancer" "<load_balancer_name>" {
          ...
          listener {
            ...
            endpoint {
              address {
                external_ipv4_address {
                  address = <service_public_IP_address>
                }
              }
              ports = [ <service_port> ]
            }
          }
        }
        ```

        Where `address` is the public IP address previously used by the network load balancer.

    1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

1. After the IP address changes, your service will again be available through the L7 load balancer. Monitor the L7 load balancer's user load on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the now free static public IP address you selected when creating the L7 load balancer.

    1. Open the configuration file you used to create the L7 load balancer (`alb-int-nlb-http.tf` or `alb-int-nlb-https.tf`).

    1. Delete the `yandex_vpc_address` resource description from the file:

        ```hcl
        resource "yandex_vpc_address" "static-address" {
          description = "Static public IP address for the Application Load Balancer"
          name        = "alb-static-address"
          external_ipv4_address {
            zone_id                  = "ru-central1-a"
            ddos_protection_provider = "qrator"
          }
        }
        ```

    1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

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
