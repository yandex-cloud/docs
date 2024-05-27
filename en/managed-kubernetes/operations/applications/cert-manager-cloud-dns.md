# Installing cert-manager with the {{ dns-full-name }} ACME webhook plugin


[cert-manager](https://cert-manager.io) is an application that adds certificates and certificate issuers as resource types in [{{ managed-k8s-name }} clusters](../../concepts/index.md#kubernetes-cluster) to facilitate obtaining, renewal, and use of such certificates. For example, to get [Let's Encrypt®](https://letsencrypt.org/) certificates, you can pass the following [challenges](https://letsencrypt.org/docs/challenge-types/) to prove domain ownership:

* [DNS-01](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge). To pass this challenge, use [{{ dns-full-name }}](../../../dns/). Together with cert-manager, you need to install the ACME webhook {{ dns-full-name }} plugin for integration with the service.
* [HTTP-01](https://letsencrypt.org/docs/challenge-types/#http-01-challenge). To pass this challenge, use an Ingress controller installed in a cluster.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Make sure that the {{ managed-k8s-name }} cluster is located in the same [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) as the [{{ dns-name }} public zone](../../../dns/concepts/dns-zone.md#public-zones).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

   {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Create](../../../iam/operations/sa/create.md) a service account to run cert-manager.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `dns.editor` role for the folder hosting the public DNS zone.
1. [Create](../../../iam/operations/authorized-key/create.md) an authorized key for the service account and save it to the `key.json` file.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the {{ managed-k8s-name }} cluster name and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [cert-manager with a plugin for {{ dns-full-name }} ACME webhook](/marketplace/products/yc/cert-manager-webhook-yandex) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter a name for the application, e.g., `cert-manager`.
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

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with cert_manager and the {{ dns-full-name }} plugin, run this command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_cert-manager-webhook-yandex.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_cert-manager-webhook-yandex.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set-file config.auth.json=key.json \
     --set config.email='<email_address_to_receive_Lets_Encrypt_notifications>' \
     --set config.folder_id='<ID_of_folder_with_Cloud_DNS_zone>' \
     --set config.server='Lets_Encrypt_server_URL' \
     cert-manager-webhook-yandex ./cert-manager-webhook-yandex/
   ```

   As a Let's Encrypt® server URL, use:
   * `https://acme-v02.api.letsencrypt.org/directory`: Primary URL.
   * `https://acme-staging-v02.api.letsencrypt.org/directory`: Test URL.

   This command also creates a new namespace required for cert-manager.

1. Make sure the cert-manager [pod](../../concepts/index.md#pod) has changed its status to `Running`:

   ```bash
   kubectl get pods --namespace=<namespace> -l app=cert-manager-webhook-yandex -w
   ```

## Getting a test certificate {#issue-certificate}

To test the installed application, get a test certificate. To issue the certificate, we will use the `yc-clusterissuer` issuer. It is created when you install cert-manager and pre-configured to work with Let's Encrypt®.

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
       # Make sure to specify the domain name (e.g., test.example.com) rather than the DNS record name.
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

1. (Optional) Get detailed information about the certificate:

   ```bash
   kubectl -n <namespace> describe certificate domain-name
   ```

   {% include [cert-manager-events-explained](../../../_includes/managed-kubernetes/cert-manager-events-explained.md) %}

## Use cases {#examples}

* [{#T}](../../tutorials/dnschallenge.md).
* [{#T}](../../tutorials/ingress-cert-manager.md).

## See also {#see-also}

* [Let's Encrypt® documentation](https://letsencrypt.org/docs/client-options/)
* [cert-manager documentation](https://cert-manager.io/docs/configuration/)