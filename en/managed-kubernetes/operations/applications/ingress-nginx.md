---
title: Installing Ingress NGINX
description: Learn how to install Ingress NGINX in a {{ managed-k8s-name }} cluster.
---

# Installing Ingress NGINX


[Ingress NGINX](https://docs.nginx.com/nginx-ingress-controller/overview/about/) is an Ingress controller for NGINX that balances the load between the WebSocket, gRPC, TCP, or UDP applications. Ingress NGINX is installed in a {{ managed-k8s-name }} cluster and is set up using the {{ k8s }} [ConfigMap](https://docs.nginx.com/nginx-ingress-controller/configuration/global-configuration/configmap-resource/) and [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) objects, including the [annotations](https://docs.nginx.com/nginx-ingress-controller/configuration/ingress-resources/advanced-configuration-with-annotations/).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the cluster name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Ingress NGINX](/marketplace/products/yc/ingress-nginx) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:

   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) for Ingress NGINX or create a new one.
   * **Application name**: Specify the app name.
   * **Number of controller replicas**: Set the number of Ingress controller replicas to improve fault tolerance. If only one replica is used, then, in case of its failure, the applications deployed using the Ingress controller will be unavailable.

      The default value is `1`.

   * **Controller IP address**: Specify a reserved IP address. You can [reserve it](../../../vpc/operations/get-static-ip.md) using {{ vpc-full-name }}.

      If you do not fill in the field, the Ingress controller will be assigned a dynamic IP address.

   * **Traffic management policy**: Select a policy for external traffic management. It matches the `externalTrafficPolicy` parameter in the {{ k8s }} specifications. The possible values are:

      * **Cluster**: Traffic is routed to different {{ k8s }} nodes (default). As the result, traffic is distributed evenly; however, such an approach has some disadvantages:

         * The package may come to one node's proxy and get rerouted to another node. Such behavior leads to delays in performing operations and sending packages.
         * The pod that receives the package sees the IP address of the proxying node rather than the one of the client. As the result, the original IP address of the client is not preserved.

      * **Local**: Traffic is proxied and distributed between pods on the same node. The traffic is routed to the node via the port specified in the {{ k8s }} `Service` object of the [LoadBalancer or NodePort type](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types).

         The traffic comes to a specific node, so it is distributed unevenly between nodes; however, the client IP address is preserved.

      For more information about policies for external traffic management, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/networking/virtual-ips/#external-traffic-policy).

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Helm install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Kubectl install](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with an NGINX Ingress controller, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_ingress-nginx.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_ingress-nginx.helmChart.tag }} \
      --untar && \
   helm install \
      --namespace <namespace> \
      --create-namespace \
      ingress-nginx ./ingress-nginx/
   ```

## Use cases {#examples}

* [{#T}](../create-load-balancer-with-ingress-nginx.md)
* [{#T}](../../tutorials/ingress-cert-manager.md)
* [{#T}](../../tutorials/nginx-ingress-certificate-manager.md)

## See also {#see-also}

* [Ingress NGINX documentation](https://docs.nginx.com/nginx-ingress-controller/)
* [GitHub documentation](https://github.com/kubernetes/ingress-nginx)
* [Ingress NGINX use cases](https://github.com/kubernetes/ingress-nginx/tree/main/docs/examples)
* [Known issues](https://github.com/kubernetes/ingress-nginx/issues)
