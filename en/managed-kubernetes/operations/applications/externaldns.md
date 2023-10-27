# Installing ExternalDNS with the {{ dns-full-name }} plugin

[ExternalDNS](https://github.com/kubernetes-sigs/external-dns) allows you to create [DNS records](../../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../../dns/) automatically. ExternalDNS makes {{ k8s }} resources discoverable through public DNS servers.

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md) for {{ dns-name }}.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `dns.editor` role.
1. [Create an authorized key](../../../iam/operations/authorized-key/create.md) for the [service account](../../../iam/concepts/users/service-accounts.md) in JSON format and save it to the `key.json` file:

   ```bash
   yc iam key create \
     --service-account-name <service_account_name> \
     --format json \
     --output key.json
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) name and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [ExternalDNS with a plugin for {{ dns-full-name }}](/marketplace/products/yc/externaldns) and click **Use**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for ExternalDNS.
   * **Application name**: Enter an application name.
   * **Service account key**: Paste the contents of the `key.json` file or create a new authorized key for the service account. The service account must have the `dns.editor` [role](../../../iam/concepts/access-control/roles.md).
   * **Folder ID**: Specify the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) hosting the [{{ dns-name }} zone](../../../dns/concepts/dns-zone.md).
1. Click **Install**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with ExternalDNS, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_externaldns.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_externaldns.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set config.folder_id=<ID_of_folder_with_Cloud_DNS_zone> \
     --set-file config.auth.json=<path_to_file_with_authorized_service_account_key> \
     externaldns ./externaldns/
   ```

## See also {#see-also}

* [ExternalDNS documentation](https://github.com/kubernetes-sigs/external-dns/).