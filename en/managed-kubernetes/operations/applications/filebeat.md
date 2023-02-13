# Installing Filebeat

[Filebeat](https://www.elastic.co/beats/filebeat) is a plugin that helps collect and forward logs to the Elastic Stack ecosystem: {{ ES }}, Kibana, Logstash. [Filebeat](/marketplace/products/yc/filebeat) deploys to a [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster), collects cluster and [pod](../../concepts/index.md#pod) logs, and forwards them to [{{ mes-full-name }}](../../../managed-elasticsearch/).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Make sure that the {{ managed-k8s-name }} cluster is located in the same [cloud network](../../../vpc/concepts/network.md) as the {{ mes-name }} cluster.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ managed-k8s-name }}**.
1. Click the name of the desired {{ k8s }} cluster and select the ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}** tab.
1. Under **Applications available for installation**, select [Filebeat](/marketplace/products/yc/filebeat) and click **Use**.
1. Configure the application:
   * **Namespace**: Select a [namespace](../../concepts/index.md#namespace) or create a new one.
   * **Application name**: Enter an application name such as `filebeat`.
   * **{{ ES }} username**: Enter the login Filebeat will use to connect to the {{ mes-name }} cluster.
   * **{{ ES }} connection password**: Enter the account password for the {{ mes-name }} cluster.
   * **{{ ES }} FQDN**: Enter the {{ mes-name }} cluster URL and port, such as `https://c-c9q07rjo9c11q4e1p0om.rw.mdb.yandexcloud.net:9200`. For more information about connecting to a cluster, see the [service documentation](../../../managed-elasticsearch/operations/cluster-connect.md).
1. Click **Install**.
1. [Connect to the Kibana web interface](../../../managed-elasticsearch/quickstart.md#connect-kibana) and make sure that {{ k8s }} cluster events are coming in.

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Filebeat, run the following command:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/filebeat/chart/filebeat \
     --version 7.16.3-4 \
     --untar && \
   helm install \
     --namespace <namespace> \
     --create-namespace \
     --set app.url='<{{ mes-name }} cluster URL and port>' \
     --set app.username='<{{ ES }} cluster username>' \
     --set app.password='<{{ ES }} cluster user password>' \
     filebeat ./filebeat
   ```

   This command also creates a new namespace required for Filebeat.
1. Make sure the Filebeat pod has changed its status to `Running`:

   ```bash
   kubectl get pods --namespace=filebeat -l app=filebeat-filebeat -w
   ```

1. [Connect to the Kibana web interface](../../../managed-elasticsearch/quickstart.md#connect-kibana) and make sure that {{ k8s }} cluster events are coming in.

## See also {#see-also}

[{{ mes-name }} documentation](../../../managed-elasticsearch/).
[Filebeat documentation](https://www.elastic.co/guide/en/beats/filebeat/master/index.html).