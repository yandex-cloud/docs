# Migrating services from an NLB with VMs as targets to an L7 ALB using {{ TF }}


To migrate a service from a network load balancer to an L7 load balancer using {{ TF }}:

1. [See the recommendations for service migration](#recommendations).
1. [Create your infrastructure](#deploy). At this step, you will associate the {{ sws-name }} security profile with a virtual host of the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate the user load from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [recommendations](../_tutorials_includes/migration-from-nlb-to-alb/recommendations.md) %}

## Create your infrastructure {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Download the configuration file to the same working directory based on the protocol you are using:
    * `HTTP`: [alb-vm-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-vm-migration/blob/main/alb-vm-http.tf) configuration file.
    * `HTTPS`: [alb-vm-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-vm-migration/blob/main/alb-vm-https.tf) configuration file.

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

    1. If your service needs one and the same backend resource processing requests within a single user session, enable [session affinity](../../application-load-balancer/concepts/backend-group.md#session-affinity) for the backend group by uncommenting the section for the `yandex_alb_backend_group` resource:

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

Select one of the migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep public IP address for your service](#not-save-public-ip).

### Keep the public IP address for your service {#save-public-ip}

1. If your external network load balancer uses a dynamic public IP address, [convert it to a static one](../../vpc/operations/set-static-ip.md).

1. [Delete the listener](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address. This will make your service unavailable through the network load balancer.

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

1. After the IP addresses changes, your service will again be available through the L7 load balancer. Monitor the L7 load balancer's user load on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the now free static public IP address you selected when creating the L7 load balancer:

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

### Do not keep the public IP address for your service {#not-save-public-ip}

{% include [vm-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/vm-not-save-public-ip.md) %}
