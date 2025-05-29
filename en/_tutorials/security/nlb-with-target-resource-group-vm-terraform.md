# Migrating services from an NLB with an instance group as a target to an L7 ALB using {{ TF }}


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the recommendations for service migration](#recommendations).
1. [Create your infrastructure](#deploy). At this step, you will associate the {{ sws-name }} security profile with a virtual host of the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate the user load from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [group-vm-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/group-vm-recommendations.md) %}

## Create your infrastructure {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Download the configuration file to the same working directory based on the protocol you are using:
    * `HTTP`: [alb-vm-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-ig-migration/blob/main/alb-vm-http.tf) configuration file.
    * `HTTPS`: [alb-vm-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-ig-migration/blob/main/alb-vm-https.tf) configuration file.

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
        * `certificate` (for `HTTPS`): Path to the self-signed custom certificate.
        * `private_key` (for `HTTPS`): Path to the private key file.

    1. For the `yandex_alb_target_group` resource, add as many `target` sections as there are virtual machines in your network load balancer's target group.

        ```hcl
        resource "yandex_alb_target_group" "alb-target-group" {
          ...
          target {
            subnet_id    = "<subnet_ID>"
            ip_address   = "<VM_1_internal_IP_address>"
          }
          target {
            subnet_id    = "<subnet_ID>"
            ip_address   = "<VM_2_internal_IP_address>"
          }
          ...
          target {
            subnet_id    = "<subnet_ID>"
            ip_address   = "<VM_N_internal_IP_address>"
          }
        }
        ```

        Where:

        * `subnet_id`: ID of the subnet the VM is located in.
        * `ip_address`: Internal IP address of the VM specified in the target group of your network load balancer.

    1. If your service needs one and the same backend resource processing requests within a single user session, enable [session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) for the backend group by uncommenting the section for the `yandex_alb_backend_group` resource.

        ```hcl
        session_affinity {
          connection {
            source_ip = true
          }
        }
        ```

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

## Migrate the user load from the network load balancer to the L7 load balancer {#migration-nlb-to-alb}

{% note warning %}

Backend VMs will be recreated during the migration process.

{% endnote %}

If the network load balancer's listener uses a public IP address without DDoS protection, take note of the current [health check](../../network-load-balancer/concepts/health-check.md) settings for the target group in the network load balancer before proceeding to the next step.

1. Change the integration with the target group for the VM group:

    1. In the [management console]({{ link-console-main }}), select the folder containing your VM group.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
    1. Select the group to update.
    1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
    1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
    1. Specify the name of the L7 load balancer target group and, optionally, other [target group settings](../../compute/concepts/instance-groups/balancers.md#settings-alb).
    1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

    When updating the VM group:

    * VMs in the group are automatically [recreated](../../compute/concepts/instance-groups/deploy/instance.md#ch-gr-affect).
    * Targets are removed from the network load balancer target group, and the user load is distributed among the remaining targets. The service becomes partially unavailable to users through the network load balancer during this period.
    * After all targets are deleted, the target group is deleted. The service becomes unavailable through the network load balancer.

    Proceed to the next step without waiting for the VM group update to complete.

1. In the L7 load balancer backend group, [change the backend](../../application-load-balancer/operations/backend-group-update.md#update-backend) target group. Specify only the target group created in the previous step.

    As you perform the operation specified in the previous step, VMs from the VM group will be automatically added to the L7 load balancer target group.

1. Select one of the options to further migrate the user load from the network load balancer to the L7 load balancer depending on whether the network load balancer listener has a public IP address with or without DDoS protection:

    * [The network load balancer listener uses a public IP address with DDoS protection](#ip-with-ddos-protection). During migration, your service will keep its public IP address.
    * [The network load balancer listener uses a public IP address without DDoS protection](#ip-without-ddos-protection). During migration, your service will get a new public IP address.

### The network load balancer listener uses a public IP address with DDoS protection {#ip-with-ddos-protection}

1. [Delete the listener](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address.

1. In the L7 load balancer, assign to the listener the public IP address previously used by the network load balancer:

    1. Open the configuration file you used to create the L7 load balancer (`alb-vm-http.tf` or `alb-vm-https.tf`).

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

    1. Open the configuration file you used to create the L7 load balancer (`alb-vm-http.tf` or `alb-vm-https.tf`).

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

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating the user load to the L7 load balancer.

### The network load balancer listener uses a public IP address without DDoS protection {#ip-without-ddos-protection}

1. Monitor the [status of targets](../../network-load-balancer/operations/check-resource-health.md) of your network load balancer. Wait until the targets are automatically deleted from the target group.

1. [Create a target group](../../network-load-balancer/operations/target-group-create.md) for the network load balancer. Add the VMs recreated when updating the VM group.

1. In the network load balancer, [connect the target group](../../network-load-balancer/operations/target-group-attach.md) created in the previous step. When connecting the target group, configure the health checks the original target group had.

1. Wait until the VM [health checks](../../network-load-balancer/operations/check-resource-health.md) in the network load balancer target group go `Healthy`. This will make your service once again available through the network load balancer.

1. To migrate the user load from a network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, change the A record value for the service domain name to the public IP address of the L7 load balancer. If the public domain zone was created in [{{ dns-full-name }}](../../dns/), change the record using [this guide](../../dns/operations/resource-record-update.md).

    {% note info %}

    The propagation of DNS record updates depends on the time-to-live (TTL) value and the number of links in the DNS request chain. This process can take a long time.

    {% endnote %}

1. As the DNS record updates propagate, follow the increase of requests to the L7 load balancer on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Follow the decrease of the network load balancer load using the `processed_bytes` and `processed_packets` [load balancer metrics](../../monitoring/metrics-ref/network-load-balancer-ref.md). You can also [create a dashboard](../../monitoring/operations/dashboard/create.md) to visualize these metrics. The absence of load on the network load balancer for a prolonged period of time indicates that the user load has been transferred to the L7 load balancer.

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating the user load to the L7 load balancer.
