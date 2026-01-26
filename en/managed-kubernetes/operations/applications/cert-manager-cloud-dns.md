---
title: Installing cert-manager with the {{ dns-full-name }} ACME webhook plugin
description: Follow this guide to install cert-manager with the {{ dns-name }} ACME webhook plugin.
---

# Installing cert-manager with the {{ dns-full-name }} ACME webhook plugin


[cert-manager](https://cert-manager.io) is an application that adds certificates and certificate issuers as resource types in [{{ managed-k8s-name }} clusters](../../concepts/index.md#kubernetes-cluster), which makes it easier to get, renew, and use such certificates. For example, to get [Let's Encrypt®](https://letsencrypt.org/) certificates, you can pass the following [challenges](https://letsencrypt.org/docs/challenge-types/) to prove domain ownership:

* [DNS-01](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge). To pass this challenge, use [{{ dns-full-name }}](../../../dns/). Together with cert-manager, you need to install the {{ dns-full-name }} ACME webhook plugin for integration with the service.
* [HTTP-01](https://letsencrypt.org/docs/challenge-types/#http-01-challenge). To pass this challenge, use an Ingress controller installed in a cluster.

{% note info %}

The cert-manager application with the {{ dns-full-name }} ACME webhook plugin supports [wildcard certificates](https://en.wikipedia.org/wiki/Public_key_certificate#Wildcard_certificate).

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Make sure your {{ managed-k8s-name }} cluster is located in the same [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) as the [public {{ dns-name }} zone](../../../dns/concepts/dns-zone.md#public-zones).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [configure-cert-manager](../../../_includes/managed-kubernetes/security-groups/configure-cert-manager.md) %}
1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Create](../../../iam/operations/sa/create.md) a service account to run cert-manager.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `dns.editor` role for the folder hosting the public DNS zone.
1. [Create](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) an authorized key for this service account and save it to the `key.json` file.

## Installation from {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [cert-manager with the {{ dns-full-name }} ACME webhook plugin](/marketplace/products/yc/cert-manager-webhook-yandex) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `cert-manager-dns-space`. If you leave the default namespace, cert-manager with the {{ dns-full-name }} plugin may work incorrectly.
   * **Application name**: Specify the application name, e.g., `cert-manager`.
   * **Service account key**: Paste the contents of the `key.json` file or create a new [key](../../../iam/concepts/authorization/key.md).
   * **Folder ID**: Specify the ID of the folder hosting the {{ dns-name }} zone, to confirm domain ownership at the DNS-01 challenge.
   * **Email address to get notifications from Let's Encrypt**: Specify the email address for Let's Encrypt® notifications.
   * **Let's Encrypt server address**: Select a Let's Encrypt® server address from the list:
     * `https://acme-v02.api.letsencrypt.org/directory`: Primary URL.
     * `https://acme-staging-v02.api.letsencrypt.org/directory`: Test URL.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with cert-manager and the {{ dns-full-name }} plugin, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_cert-manager-webhook-yandex.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_cert-manager-webhook-yandex.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file config.auth.json=key.json \
     --set config.email='<email_address_for_notifications_from_Lets_Encrypt>' \
     --set config.folder_id='<ID_of_folder_with_Cloud_DNS_zone>' \
     --set config.server='Lets_Encrypt_server_URL' \
     cert-manager-webhook-yandex ./cert-manager-webhook-yandex/
   ```

   As a Let's Encrypt® server URL, use these:
   * `https://acme-v02.api.letsencrypt.org/directory`: Primary URL.
   * `https://acme-staging-v02.api.letsencrypt.org/directory`: Test URL.

   This command will also create a new namespace required for cert-manager.

   If you set `namespace` to the default namespace, cert-manager may work incorrectly. We recommend specifying a value different from all the existing namespaces, e.g., `cert-manager-dns-space`.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Make sure the cert-manager [pod](../../concepts/index.md#pod) has changed its status to `Running`:

   ```bash
   kubectl get pods --namespace=<namespace> -l app=cert-manager-webhook-yandex -w
   ```

## Getting a test certificate {#issue-certificate}

To test the installed application, get a test certificate. We are going to use `yc-clusterissuer` to issue a certificate. It is created when you install cert-manager and pre-configured to work with Let's Encrypt®.

1. Create a file named `certificate.yaml` with a request for a test certificate:

   ```yaml
   apiVersion: cert-manager.io/v1
   kind: Certificate
   metadata:
     name: domain-name
     namespace: <namespace>
   spec:
     secretName: domain-name-secret
     issuerRef:
       # ClusterIssuer created along with the {{ dns-full-name }} ACME webhook.
       name: yc-clusterissuer
       kind: ClusterIssuer
     dnsNames:
       # The domain must belong to your public {{ dns-name }} zone.
       # Make sure to specify the domain name, e.g., test.example.com, rather than the DNS record name.
       - <domain_name>
   ```

1. Install the certificate in the {{ managed-k8s-name }} cluster:

   ```bash
   kubectl apply -f certificate.yaml
   ```

1. Check if the certificate is available:

   ```bash
   kubectl get certificate
   ```

   Result:

   ```text
   NAME         READY  SECRET              AGE
   domain-name  True   domain-name-secret  45m
   ```

    The `True` status in the `READY` column means that the certificate was issued successfully.

1. Optionally, get detailed information about the certificate:

    ```bash
    kubectl -n <namespace> describe certificate domain-name
    ```

    {% include [cert-manager-events-explained](../../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

## Use cases {#examples}

* [{#T}](../../tutorials/dnschallenge.md)
* [{#T}](../../tutorials/ingress-cert-manager.md)

## See also {#see-also}

* [Let's Encrypt® documentation](https://letsencrypt.org/docs/client-options/)
* [cert-manager documentation](https://cert-manager.io/docs/configuration/)
