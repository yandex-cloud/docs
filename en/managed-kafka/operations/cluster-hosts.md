# Managing Apache Kafka® cluster hosts

You can get a list of broker hosts in your {{ KF }} cluster.

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the name of the cluster and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-kf }} cluster list-hosts <cluster name>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of cluster hosts, use the [listHosts](../api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
