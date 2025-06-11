# Migrating services from an NLB with an instance group as a target to an L7 ALB using {{ TF }}


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the recommendations for service migration](#recommendations).
1. [Create your infrastructure](#deploy). At this step, you will associate your {{ sws-name }} profile with a virtual host of the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate user traffic from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

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
    * {{ sws-name }} profile.
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

        * `subnet_id`: ID of the subnet hosting the VM.
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

    {{ TF }} will show any errors found in your configuration files.

1. Create the required infrastructure:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

1. Specify the autoscaling settings in the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), select the folder where you created the L7 load balancer.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
    1. Click the name of your load balancer.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Under **{{ ui-key.yacloud.alb.section_autoscale-settings }}**, set the [resource unit](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) limit.

## Test the L7 load balancer {#test}

1. Wait until the L7 load balancer goes `Active`.

1. Go to the new L7 load balancer and select **{{ ui-key.yacloud.alb.label_healthchecks }}** on the left. Make sure you get `HEALTHY` for all the L7 load balancer's health checks.

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate user traffic from the network load balancer to the L7 load balancer {#migration-nlb-to-alb}

{% note warning %}

Migration involves recreating the backend VMs.

{% endnote %}

If the network load balancer listener uses a public IP address without DDoS protection, save the current [health check](../../network-load-balancer/concepts/health-check.md) settings for the network load balancer target group before proceeding to the next step.

1. Update the target group integration for the instance group:

    1. In the [management console]({{ link-console-main }}), select the folder containing your instance group.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
    1. Select the group to update.
    1. In the top-right corner of the page, click **{{ ui-key.yacloud.common.edit }}**.
    1. Under **{{ ui-key.yacloud.compute.groups.create.section_alb }}**, enable **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
    1. Specify the name of the L7 load balancer target group and, optionally, other [target group settings](../../compute/concepts/instance-groups/balancers.md#settings-alb).
    1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

    When you update your instance group:

    * The system automatically [recreates VMs in the group](../../compute/concepts/instance-groups/deploy/instance.md#ch-gr-affect).
    * The system removes targets from the network load balancer target group and the remaining targets take over the user traffic. The service becomes partially unavailable to users through the network load balancer during this period.
    * Once the target group is empty, it gets deleted. The service becomes unavailable through the network load balancer.

    Proceed to the next step without waiting for the instance group update to complete.

1. [Update](../../application-load-balancer/operations/backend-group-update.md#update-backend) the target group for the backend in the L7 load balancer backend group. Specify only the target group created in the previous step.

    As you complete the previous step, the system automatically adds VMs from the instance group to the L7 load balancer target group.

1. Select one of the following options to further migrate user traffic from the network load balancer to the L7 load balancer based on whether your NLB listener's public IP address is DDoS-protected:

    * [Your network load balancer listener uses a public IP address with DDoS protection](#ip-with-ddos-protection). During migration, the public IP address for your service will remain the same.
    * [Your network load balancer listener uses a public IP address without DDoS protection](#ip-without-ddos-protection). During migration, your service will get a new public IP address.

### Your network load balancer listener uses a public IP address with DDoS protection {#ip-with-ddos-protection}

1. [Delete the listener](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address.

1. In the L7 load balancer, assign to the listener the public IP address previously used by the network load balancer:

    1. Open the configuration file you used to create the L7 load balancer (`alb-vm-http.tf` or `alb-vm-https.tf`).

    1. In the load balancer description, update the `address` parameter under `listener.endpoint.address.external_ipv4_address`:

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

1. After the IP address changes, your service will again be available through the L7 load balancer. Monitor the L7 load balancer's user traffic on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

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

1. Optionally, once migration is complete, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md).

### Your network load balancer listener uses a public IP address without DDoS protection {#ip-without-ddos-protection}

1. Monitor the NLB [target status](../../network-load-balancer/operations/check-resource-health.md). Wait until the targets are automatically removed from the target group.

1. [Create a target group](../../network-load-balancer/operations/target-group-create.md) for the network load balancer. Add the VMs recreated when updating the instance group.

1. In the network load balancer, [attach the target group](../../network-load-balancer/operations/target-group-attach.md) created in the previous step. When attaching the target group, configure the same health checks as in the original target group.

1. Wait until the [health checks](../../network-load-balancer/operations/check-resource-health.md) for the VMs in the network load balancer target group return `Healthy`. This will make your service once again available through the network load balancer.

1. To migrate user traffic from a network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, update the A record value for the service domain name to point to the public IP address of the L7 load balancer. If the public domain zone was created in [{{ dns-full-name }}](../../dns/), update the record using [this guide](../../dns/operations/resource-record-update.md).

    {% note info %}

    The propagation of DNS record updates depends on the time-to-live (TTL) value and the number of links in the DNS request chain. This process can take a long time.

    {% endnote %}

1. As the DNS record updates propagate, monitor the increase in requests to the L7 load balancer on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Monitor the decrease in traffic on the network load balancer using the `processed_bytes` and `processed_packets` [load balancer metrics](../../monitoring/metrics-ref/network-load-balancer-ref.md). You can [create a dashboard](../../monitoring/operations/dashboard/create.md) to visualize these metrics. No traffic on the network load balancer over time indicates that the L7 load balancer is now handling all user traffic.

1. Optionally, once migration is complete, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md).
