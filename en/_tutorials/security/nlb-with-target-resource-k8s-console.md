# Migrating services from an NLB with a {{ managed-k8s-full-name }} cluster as a target to an L7 ALB using the management console


To migrate a service from a network load balancer to an L7 load balancer:

1. [See the service migration recommendations](#recommendations).
1. [Create a migration infrastructure](#before-you-begin).
1. [Create a {{ sws-name }} profile](#create-profile-sws).
1. [Install an {{ alb-name }} ingress controller and create resources in your {{ managed-k8s-name }} cluster](#install-ingress-nginx). At this step, you will associate your {{ sws-name }} profile with the L7 load balancer.
1. [Test the L7 load balancer](#test).
1. [Migrate user traffic from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

{% include [k8s-recommendations](../_tutorials_includes/migration-from-nlb-to-alb/k8s-recommendations.md) %}

## Create your infrastructure {#before-you-begin}

1. [Create subnets](../../vpc/operations/subnet-create.md) in three availability zones for the L7 load balancer.

1. Create [security groups](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) that allow the L7 load balancer to receive inbound traffic and send it to the targets and allow the targets to receive inbound traffic from the load balancer.

1. When using HTTPS, [add the TLS certificate](../../certificate-manager/operations/import/cert-create.md#create-certificate) of your service to [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. Optionally, [reserve an L3-L4 DDoS-protected static public IP address](../../vpc/operations/get-static-ip.md) for the L7 load balancer.

1. The {{ managed-k8s-name }} services used as backends must be of the `NodePort` type. If your service type is different, change it to `NodePort`. For more information about this type, see [this {{ k8s }} article](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

## Create a {{ sws-name }} profile {#create-profile-sws}

{% include [create-profile-sws](../_tutorials_includes/migration-from-nlb-to-alb/create-profile-sws.md) %}

## Install an {{ alb-name }} ingress controller and create resources in your {{ managed-k8s-name }} cluster {#install-ingress-nginx}

{% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

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

1. Optionally, [delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating user traffic to the L7 load balancer.

### Do not keep the public IP address for your service {#not-save-public-ip}

{% include [k8s-not-save-public-ip](../_tutorials_includes/migration-from-nlb-to-alb/k8s-not-save-public-ip.md) %}
