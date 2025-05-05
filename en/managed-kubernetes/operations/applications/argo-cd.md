---
title: Installing Argo CD
description: Follow this guide to install Agro CD.
---

# Installing Argo CD


[Argo CD](https://argo-cd.readthedocs.io) is a declarative GitOps tool for continuous delivery to {{ k8s }}.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Argo CD](/marketplace/products/yc/argo-cd) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `argo-cd-space`. If you leave the default namespace, Argo CD may work incorrectly.
   * **Application name**: Specify the application name.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Argo CD, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_argo-cd.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_argo-cd.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     argo-cd ./argo-cd/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   If you set `namespace` to the default namespace, Argo CD may work incorrectly. We recommend you to specify a value different from all existing namespaces (e.g., `argo-cd-space`).

## Access to the application {#application-access}

You can open Argo CD via [localhost](#open-via-localhost) or [dedicated IP address](#go-to-static-address). The first method is easier to configure and does not require additional network load balancer costs. The second method allows you to get permanent access to Argo CD. The application is available through `localhost` only for as long as port redirection is active.

Before you set up access to Argo CD, get the administrator password (`admin`):

```bash
kubectl --namespace <namespace> get secret argocd-initial-admin-secret \
  --output jsonpath="{.data.password}" | base64 -d
```

You will need the password for authorization in Argo CD.

### Opening the application via localhost {#open-via-localhost}

1. Configure Argo CD port redirection to your local computer:

   ```bash
   kubectl port-forward service/<app_name>-argocd-server \
     --namespace <namespace> 8080:443
   ```

   In the command, specify the application name you had set during installation.

1. Follow the `https://localhost:8080` link and log in with administrator credentials.

### Opening the application via a dedicated IP address {#go-to-static-address}

1. Save the following specification for creating a `LoadBalancer` type service to a file named `load-balancer.yaml`. This will create you a [{{ network-load-balancer-full-name }}](../../../network-load-balancer/index.yaml):

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: argocd-load-balancer
     namespace: <namespace>
   spec:
     type: LoadBalancer
     ports:
     - port: 443
       name: load-balancer-port-ssl
       targetPort: 8080
     # Selector {{ k8s }} label used in the Deployment object named <application_name>-argocd-server.
     selector:
       app.kubernetes.io/name: argocd-server
   ```

   In the specification, specify the namespace you installed Argo CD in.

   The specification giving no IP address, the load balancer will get a dynamic public IP address. You can add a field named `spec.loadBalancerIP` and specify a [pre-reserved](../../../vpc/operations/get-static-ip.md) static IP address in it.

   For details on the specification, see [this service reference](../../nlb-ref/service.md).

1. Apply the specification and create a network load balancer:

   ```bash
   kubectl apply -f load-balancer.yaml --namespace <namespace>
   ```

1. Get the IP address of the load balancer you created:

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder the {{ managed-k8s-name }} cluster is deployed in.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

         The **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** section shows a network load balancer with the `k8s` prefix in its name and the unique {{ k8s }} cluster ID in its description.

      1. Copy the **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** field value for the load balancer of interest.

   {% endlist %}

1. Follow the `https://<load_balancer_IP_address>` link and log in with administrator credentials.

## Use cases {#examples}

* [{#T}](../../tutorials/marketplace/argo-cd.md)

## See also {#see-also}

* [Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/).
