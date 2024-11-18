{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  To get a list of cluster hosts, run the command:

  ```bash
  {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
  ```

  You can request the cluster ID and name with a [list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

- API {#api}

  To get a list of cluster hosts, use the [listHosts](../../../managed-kafka/api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../../../managed-kafka/api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../../../managed-kafka/api-ref/grpc/Cluster/listHosts.md) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

{% endlist %}
