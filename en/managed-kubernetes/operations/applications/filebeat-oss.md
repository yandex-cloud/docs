# Installing Filebeat OSS


[Filebeat OSS](https://www.elastic.co/beats/filebeat) is a plugin for collecting and forwarding logs to the {{ OS }} ecosystem. Installed in a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster), Filebeat OSS collects cluster and [pod](../../concepts/index.md#pod) logs, and forwards them to [{{ mos-full-name }}](../../../managed-opensearch/).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Make sure that the {{ managed-k8s-name }} cluster is located in the same [cloud network](../../../vpc/concepts/network.md) as the [{{ mos-name }} cluster](../../../managed-opensearch/concepts/index.md).
1. Enable the compatibility mode to support the Filebeat OSS client in {{ OS }}. For this, run the following query:

   ```bash
   wget "{{ crt-web-path }}" && \
   curl --user <username>:<password> --cacert CA.pem \
   --request PUT https://<DATA_host_name>:{{ port-mos }}/_cluster/settings \
   -H "Content-Type: application/json" -d \
   '{
   "persistent": {
     "compatibility": {
       "override_main_response_version": true
     }
   }
   }'
   ```

   Where:
   * `username`: {{ OS }} username.
   * `<password>`: {{ OS }} user password.
   * `<host_name>`: Name of the {{ mos-name }} host with the [DATA role](../../../managed-opensearch/concepts/host-roles.md#data), e.g., `rc1a-6khpaeo31lacqo21.mdb.yandexcloud.net`.

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

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the {{ managed-k8s-name }} cluster name and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Filebeat OSS](/marketplace/products/yc/filebeat-oss) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter a name for the application, e.g., `filebeat-oss`.
   * **{{ OS }} username**: Enter the username that Filebeat OSS will use to connect to the {{ mos-name }} cluster.
   * **{{ OS }} connection password**: Enter the user password for the {{ mos-name }} cluster.
   * **{{ OS }} FQDN**: Enter the URL and port for the {{ mos-name }} cluster host with the DATA role, e.g., `https://rc1a-6khpaeo31lacqo21.mdb.yandexcloud.net:9200`. For more information about connecting to a cluster, see the [service documentation](../../../managed-opensearch/operations/connect.md).
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Filebeat OSS, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_filebeat-oss.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_filebeat-oss.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set app.url='<URL_and_port_of_Managed_Service_for_{{ OS }}cluster_host_with_DATA_role>' \
     --set app.username='<{{ OS }}_cluster_username>' \
     --set app.password='<{{ OS }}_cluster_user_password>' \
     filebeatoss ./filebeat-oss/
   ```

   This command will also create a new namespace required for Filebeat OSS.
1. Make sure the Filebeat OSS pod has changed its status to `Running`:

   ```bash
   kubectl get pods --namespace=<namespace> -l app=filebeatoss-filebeat-oss -w
   ```

## Use cases {#examples}

* [Monitoring a {{ managed-k8s-name }} cluster using Filebeat OSS](../../tutorials/filebeat-oss-monitoring.md).

## See also {#see-also}

* [{{ mos-name }} documentation](../../../managed-opensearch/).
* [Filebeat documentation](https://www.elastic.co/guide/en/beats/filebeat/master/index.html).