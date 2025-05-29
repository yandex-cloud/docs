# Migrating services from an NLB with a {{ managed-k8s-full-name }} cluster as a target to an L7 ALB using the management console


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the recommendations for service migration](#recommendations).
1. [Complete the prerequisite steps](#before-you-begin).
1. [Create a {{ sws-name }} profile](#create-profile-sws).
1. [Install an {{ alb-name }} Ingress controller and create resources in your {{ managed-k8s-name }} cluster](#install-ingress-nginx). At this step, you will associate the {{ sws-name }} profile with the L7 load balancer.
1. [Migrate the user load from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [k8s-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/k8s-recommendations.md) %}

## Getting started {#before-you-begin}

1. [Create subnets](../../vpc/operations/subnet-create.md) in three availability zones for the L7 load balancer.

1. Create [security groups](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) that allow the L7 load balancer to receive incoming traffic and send it to the targets and allow the targets to receive incoming traffic from the load balancer.

1. When using HTTPS, [add the TLS certificate of your service](../../certificate-manager/operations/import/cert-create.md#create-certificate) to [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. [Reserve a static public IP address with DDoS protection](../../vpc/operations/get-static-ip.md) at Layer 3 – Layer 4 for the L7 load balancer. See the [service migration recommendations](#recommendations).

1. The {{ managed-k8s-name }} services used as backends must be of the `NodePort` type. If your services employ another type, change it to `NodePort`. For more information about this type, see [this {{ k8s }} article](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

## Create a {{ sws-name }} profile {#create-profile-sws}

[Create](../../smartwebsecurity/operations/profile-create.md) a {{ sws-name }} security profile by selecting **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

Use these settings when creating the profile:

* In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
* For the **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** rule, enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**.

These settings are limited to logging the info about the traffic without applying any actions to it. This will reduce the risk of disconnecting users due to profile configuration issues. As you move along, you will be able to disable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** and configure deny rules in the security profile.

## Install an {{ alb-name }} Ingress controller and create resources in your {{ managed-k8s-name }} cluster {#install-ingress-nginx}

{% include [k8s-install-ingress-nginx](../_tutorials_includes/migration-from-nlb-to-alb/k8s-install-ingress-nginx.md) %}

1. {% include [test](../_tutorials_includes/migration-from-nlb-to-alb/test.md) %}

## Migrate the user load from the network load balancer to the L7 load balancer {#migration-nlb-to-alb}

Select one of the migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep public IP address for your service](#not-save-public-ip).

### Keep the public IP address for your service {#save-public-ip}

1. If your external network load balancer uses a dynamic public IP address, [convert it to a static one](../../vpc/operations/set-static-ip.md).

1. [Delete all listeners](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address. This will make your service unavailable through the network load balancer.

1. In the L7 load balancer, assign to the listener the public IP address previously used by the network load balancer:

    1. Open the YAML file that describes the `Ingress` resource.
    1. Under `annotations`, for the `ingress.alb.yc.io/external-ipv4-address` field, specify the public IP address previously assigned to the network load balancer.
    1. Apply the changes using this command:

        ```bash
        kubectl apply -f <Ingress_resource_file>
        ```

1. Wait for the `Ingress` resource to finish changing its public IP address. You can view resource information using this command:

    ```bash
    kubectl get ingress <Ingress_resource_name> -w
    ```

    After the IP address changes, your service will again be available through the L7 load balancer.

1. Go to the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), go to the folder the {{ managed-k8s-name }} cluster is in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster.
    1. Select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left, and the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer user load in the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the released static public IP address previously reserved for the L7 load balancer.

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating the user load to the L7 load balancer.

### Do not keep the public IP address for your service {#not-save-public-ip}

1. To migrate the user load from a network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, change the A record value for the service domain name to the public IP address of the L7 load balancer. If the public domain zone was created in [{{ dns-full-name }}](../../dns/), change the record using [this guide](../../dns/operations/resource-record-update.md).

    {% note info %}

    The propagation of DNS record updates depends on the time-to-live (TTL) value and the number of links in the DNS request chain. This process can take a long time.

    {% endnote %}

1. As the DNS record updates propagate, monitor the increase of requests coming to the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), go to the folder the {{ managed-k8s-name }} cluster is in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster.
    1. Select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left, and the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer user load in the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. You can monitor the decrease of the network load balancer load using the `processed_bytes` and `processed_packets` [load balancer metrics](../../monitoring/metrics-ref/network-load-balancer-ref.md). You can also [create a dashboard](../../monitoring/operations/dashboard/create.md) to visualize these metrics. The absence of load on the network load balancer for a prolonged period of time indicates that the user load has been transferred to the L7 load balancer.

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating the user load to the L7 load balancer.
