# Migrating services from an NLB with a {{ managed-k8s-full-name }} cluster as a target to L7 ALB using {{ TF }}


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the service migration recommendations](#recommendations).
1. [Create your infrastructure](#deploy). At this step, you will associate the {{ sws-name }} profile with a virtual host of the L7 load balancer.
1. [Install an {{ alb-name }} ingress controller and create resources in your {{ managed-k8s-name }} cluster](#install-ingress-nginx). At this step, you will associate your {{ sws-name }} profile with the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate user traffic from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [k8s-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/k8s-recommendations.md) %}

## Create your infrastructure {#deploy}

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Download the configuration file to the same working directory based on the protocol you are using:
    * `HTTP`: [alb-k8s-http.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-k8s-migration/blob/main/alb-k8s-http.tf) configuration file
    * `HTTPS`: [alb-k8s-https.tf](https://github.com/yandex-cloud-examples/yc-nlb-alb-k8s-migration/blob/main/alb-k8s-https.tf) configuration file

    These files describe:

    * [Subnets](../../vpc/concepts/network.md#subnet) for the L7 load balancer.
    * [Security group](../../vpc/concepts/security-groups.md) for the L7 load balancer.
    * Static address for the L7 load balancer.
    * Importing a TLS certificate to {{ certificate-manager-name }} (if using `HTTPS`).
    * {{ sws-name }} profile.

1. Specify the following variables in the configuration file:

    * `domain_name`: Your service domain name.
    * `network_id`: ID of the network containing the VMs from the network load balancer's target group.
    * `certificate` (for `HTTPS`): Path to the self-signed custom certificate.
    * `private_key` (for `HTTPS`): Path to the private key file.

1. Make sure the {{ TF }} configuration files are correct using this command:

    ```bash
    terraform validate
    ```

    {{ TF }} will show any errors found in your configuration files.

1. Create the required infrastructure:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

## Install an {{ alb-name }} ingress controller and create resources in your {{ managed-k8s-name }} cluster {#install-ingress-nginx}

{% include [k8s-install-ingress-nginx](../_tutorials_includes/migration-from-nlb-to-alb/k8s-install-ingress-nginx.md) %}

## Test the L7 load balancer {#test}

{% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate user traffic from the network load balancer to the L7 load balancer {#migration-nlb-to-alb}

Select one of these migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep the public IP address for your service](#not-save-public-ip).

### Keep the public IP address for your service {#save-public-ip}

1. If your external network load balancer uses a dynamic public IP address, [convert it to a static one](../../vpc/operations/set-static-ip.md).

1. [Delete all listeners](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address. This will make your service unavailable through the network load balancer.

1. In the L7 load balancer, assign to the listener the public IP address previously used by the network load balancer:

    1. Open the YAML file that describes the `Ingress` resource.
    1. Under `annotations`, in the `ingress.alb.yc.io/external-ipv4-address` field, specify the public IP address previously assigned to the network load balancer.
    1. Apply the changes using this command:

        ```bash
        kubectl apply -f <Ingress_resource_file>
        ```

1. Wait for the `Ingress` resource to finish switching its public IP address. You can view resource information using this command:

    ```bash
    kubectl get ingress <Ingress_resource_name> -w
    ```

    After the IP address changes, your service will again be available through the L7 load balancer.

1. Navigate to the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), navigate to the folder with the {{ managed-k8s-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster.
    1. Select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left and then the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer's user traffic on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the released static public IP address previously reserved for the L7 load balancer.

    1. Open the configuration file you used to create the L7 load balancer (`alb-k8s-http.tf` or `alb-k8s-https.tf`).

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

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating user traffic to the L7 load balancer.

### Do not keep the public IP address for your service {#not-save-public-ip}

1. To migrate user traffic from a network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, update the `A` record value for the service domain name to point to the public IP address of the L7 load balancer. If the public domain zone was created in [{{ dns-full-name }}](../../dns/), update the record using [this guide](../../dns/operations/resource-record-update.md).

    {% note info %}

    The propagation of DNS record updates depends on the time-to-live (TTL) value and the number of links in the DNS request chain. This process can take a while.

    {% endnote %}

1. As the DNS record updates propagate, monitor the increase in requests to the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), navigate to the folder with the {{ managed-k8s-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster.
    1. Select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left and then the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer's user traffic on the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Monitor the decrease in traffic on the network load balancer using the `processed_bytes` and `processed_packets` [load balancer metrics](../../monitoring/metrics-ref/network-load-balancer-ref.md). You can [create a dashboard](../../monitoring/operations/dashboard/create.md) to visualize these metrics. No traffic on the external network load balancer over time indicates the L7 load balancer is now handling all user traffic.

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating user traffic to the L7 load balancer.
