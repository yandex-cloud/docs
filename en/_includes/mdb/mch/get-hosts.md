# Getting a list of cluster hosts

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

   {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-ch }} host list \
      --cluster-name=<cluster_name>
   ```

   ```text
   +----------------------------+--------------+---------+--------+---------------+
   |            NAME            |  CLUSTER ID  |  ROLE   | HEALTH |    ZONE ID    |
   +----------------------------+--------------+---------+--------+---------------+
   | rc1b...{{ dns-zone }} | c9qp71dk1... | MASTER  | ALIVE  | {{ region-id }}-b |
   | rc1a...{{ dns-zone }} | c9qp71dk1... | REPLICA | ALIVE  | {{ region-id }}-a |
   +----------------------------+--------------+---------+--------+---------------+
   ```

   You can request the cluster name with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- API {#api}

   To get a list of cluster hosts, use the [listHosts](../../../managed-clickhouse/api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../../../managed-clickhouse/api-ref/Cluster/index.md) resource or the [ClusterService/ListHosts](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md).

{% endlist %}
