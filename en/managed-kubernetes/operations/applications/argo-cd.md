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

You can open Argo CD via [localhost](#open-via-localhost), using a [dedicated IP address](#go-to-static-address) through [{{ network-load-balancer-full-name }}](../../../network-load-balancer), or by [URL](#open-via-alb) through an L7 [{{ alb-full-name }}](../../../application-load-balancer). The first method is easier to configure and does not require additional costs for load balancers. However, the application is only available through `localhost` as long as port redirection is active and load balancers provide continuous access to Argo CD.

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

### Opening the application through a dedicated IP address via {{ network-load-balancer-name }} {#go-to-static-address}

1. Save the following specification for creating a `LoadBalancer` type service to a file named `load-balancer.yaml`. This will create you a [{{ network-load-balancer-name }}](../../../network-load-balancer/index.yaml):

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

1. Get the IP address of the network load balancer you created:

   {% list tabs group=instructions %}

   * Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder the {{ managed-k8s-name }} cluster is deployed in.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.

         The **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_list }}** section shows a network load balancer with the `k8s` prefix in its name and the unique {{ k8s }} cluster ID in its description.

      1. Copy the **{{ ui-key.yacloud.load-balancer.network-load-balancer.column_ip-address }}** field value for the load balancer of interest.

   {% endlist %}

1. Follow the `https://<load_balancer_IP_address>` link and log in with administrator credentials.

### Opening the application by URL through {{ alb-name }} {#open-via-alb}

1. {% include [create-zone](../../../_includes/managed-kubernetes/create-public-zone.md) %}

1. {% include [add-certificate](../../../_includes/managed-kubernetes/certificate-add.md) %}

1. {% include [get-certificate-id](../../../_includes/managed-kubernetes/certificate-get-id.md) %}

1. [Configure](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) the security groups required for an L7 {{ alb-name }}.

1. [Install the {{ alb-name }}](alb-ingress-controller.md) ingress controller.

1. While you need a `NodePort` service to work with an L7 {{ alb-name }}, Argo CD runs a server with a `ClusterIP` service. Change the service type:

   1. Open the file with the `Service` object description:

      ```bash
      kubectl -n <namespace> edit svc <app_name>-argocd-server
      ```

   1. Replace the `type` value with `NodePort`:

        ```yaml
        spec:
          ... 
          type: NodePort
          ...
        ```

1. The L7 {{ alb-name }} removes TLS encryption from inbound traffic. To avoid infinite redirection, disable HTTP to HTTPS redirection for Argo CD:

   1. Open the `argocd-cmd-params-cm` configuration file:

      ```bash
      kubectl -n <namespace> edit configmap argocd-cmd-params-cm
      ```

   1. Replace the `server.insecure` value with `true`:

      ```yaml
      data:
        ...
        server.insecure: "true"
        ...
      ```

1. Create a file named `ingress.yaml` and specify the settings for your L7 {{ alb-name }} in it:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: argocd-ingress
      namespace: argo-cd-space
      annotations:
        ingress.alb.yc.io/subnets: <load_balancer_subnet_ID>
        ingress.alb.yc.io/security-groups: <load_balancer_security_group_ID>
        ingress.alb.yc.io/external-ipv4-address: auto
        ingress.alb.yc.io/group-name: my-ingress-group
    spec:
      tls:
        - hosts:
            - <domain_name>
          secretName: yc-certmgr-cert-id-<TLS_certificate_ID>
      rules:
        - host: <domain_name>
          http:
            paths:
              - path: /
                pathType: Prefix
                backend:
                  service:
                    name: argo-cd-argocd-server
                    port:
                      number: 80
    ```

    To learn more about these settings, see [Configuring an L7 {{ alb-full-name }} using an ingress controller](../../tutorials/alb-ingress-controller.md#create-ingress-and-apps).

1. In the `ingress.yaml` file directory, run this command:

    ```bash
    kubectl apply -f ingress.yaml
    ```

    This will create an `Ingress` resource. ALB Ingress Controller will use its configuration to automatically deploy your L7 {{ alb-name }}.

1. Make sure you created the L7 load balancer. To do this, run the following command:

    ```bash
    kubectl get ingress argocd-ingress
    ```

    View the command output. If you created the L7 load balancer, its IP address should appear in the `ADDRESS` field:

    ```bash
    NAME            CLASS   HOSTS           ADDRESS        PORTS    AGE
    argocd-ingress  <none>  <domain_name>  51.250.**.***  80, 443  15h
    ```    

1. [Add an A record](../../../dns/operations/resource-record-create.md) to your domain's zone. In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the public IP address of your L7 {{ alb-name }}.

1. Open the `https://<domain_name>` link in your browser and log in with administrator credentials.

   {% include [check-sg-if-url-unavailable-lvl3](../../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Use cases {#examples}

* [{#T}](../../tutorials/marketplace/argo-cd.md)

## See also {#see-also}

* [Argo CD documentation](https://argo-cd.readthedocs.io/en/stable/operator-manual/).
