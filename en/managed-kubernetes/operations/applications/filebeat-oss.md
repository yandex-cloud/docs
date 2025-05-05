---
title: Installing Filebeat OSS
description: Follow this guide to install Filebeat OSS.
---

# Installing Filebeat OSS


[Filebeat OSS](https://www.elastic.co/beats/filebeat) is a plugin for collecting and forwarding logs to the {{ OS }} ecosystem. Installed in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster), Filebeat OSS collects cluster and [pods](../../concepts/index.md#pod) logs and forwards them to [{{ mos-full-name }}](../../../managed-opensearch/).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Make sure that the {{ managed-k8s-name }} cluster is located in the same [cloud network](../../../vpc/concepts/network.md) as the [{{ mos-name }} cluster](../../../managed-opensearch/concepts/index.md).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Enable the compatibility mode to support the Filebeat OSS client in {{ OS }}. For this, run the following query:

   ```bash
   wget "{{ crt-web-path }}" && \
   curl \
   --user <username>:<password> --cacert CA.pem \
   --request PUT https://<name_of_host_with_DATA_role>:{{ port-mos }}/_cluster/settings \
   --header "Content-Type: application/json" \
   --data \
   '{
   "persistent": {
     "compatibility": {
       "override_main_response_version": true
     }
   }
   }'
   ```

   Where:
   * `<username>`: {{ OS }} username.
   * `<password>`: {{ OS }} user password.
   * `<host_name>`: Name of the {{ mos-name }} host with the [DATA role](../../../managed-opensearch/concepts/host-roles.md#data), e.g., `rc1a-7hkolet********.{{ dns-zone }}`.

   A successful response will have this format:

   ```json
   {
     "acknowledged":true,
     "persistent":
     {
       "compatibility":
       {
         "override_main_response_version":"true"
       }
     },
     "transient":{}
   }
   ```

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the {{ managed-k8s-name }} cluster you need and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Filebeat OSS](/marketplace/products/yc/filebeat-oss) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Create a new [namespace](../../concepts/index.md#namespace), e.g., `filebeat-oss-space`. If you leave the default namespace, Filebeat OSS may work incorrectly.
   * **Application name**: Specify the app name, e.g., `filebeat-oss`.
   * **{{ OS }} username**: Enter the username that Filebeat OSS will use to connect to the {{ mos-name }} cluster.
   * **{{ OS }} connection password**: Enter the user password for the {{ mos-name }} cluster.
   * **{{ OS }} FQDN**: Enter the URL and port for the {{ mos-name }} cluster host with the DATA role, e.g., `https://rc1a-7hkolet********.{{ dns-zone }}:9200`. For more information about connecting to a cluster, see the [service documentation](../../../managed-opensearch/operations/connect.md).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Install Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Filebeat OSS, run the following command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_filebeat-oss.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_filebeat-oss.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set app.url='<URL_and_port_for_Managed_Service_for_{{ OS }}_cluster_with_DATA_role>' \
     --set app.username='<{{ OS }}_cluster_username>' \
     --set app.password='<{{ OS }}_cluster_user_password>' \
     filebeatoss ./filebeat-oss/
   ```

   This command will also create a new namespace required for Filebeat OSS.

   If you set `namespace` to the default namespace, Filebeat OSS may work incorrectly. We recommend you to specify a value different from all existing namespaces (e.g., `filebeat-oss-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Make sure the Filebeat OSS pod has changed its status to `Running`:

   ```bash
   kubectl get pods --namespace=<namespace> -l app=filebeatoss-filebeat-oss -w
   ```

## Use cases {#examples}

* [{{ managed-k8s-name }} cluster monitoring with Filebeat OSS](../../tutorials/filebeat-oss-monitoring.md)

## See also {#see-also}

* [{{ mos-name }} documentation](../../../managed-opensearch/).
* [Filebeat documentation](https://www.elastic.co/guide/en/beats/filebeat/master/index.html).
