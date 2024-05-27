# Information about {{ GP }} cluster hosts

You can get a list of hosts (masters and segments) in a {{ mgp-name }} cluster. To do this:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
   1. Click the cluster name and select the ![hosts.svg](../../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

   In the list of hosts, the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_role }}** column shows the role of each host:

   * `MASTER`: Primary master host to receive user connections.
   * `REPLICA`: Standby master host to replicate data of the primary master host.
   * `SEGMENT`: Segment host to store part of the cluster data.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of cluster master hosts, run the command:

   ```bash
   {{ yc-mdb-gp }} hosts list master \
      --cluster-name=<cluster_name>
   ```

   To get a list of cluster segment hosts, run the command:

   ```bash
   {{ yc-mdb-gp }} hosts list segment \
      --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](../cluster-list.md#list-clusters).

- API {#api}

   To get a list of cluster hosts, use the [listMasterHosts](../../api-ref/Cluster/listMasterHosts.md) and [listSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) REST API methods for the [Cluster](../../api-ref/Cluster/index.md) resource or the [ClusterService/ListMasterHosts](../../api-ref/grpc/cluster_service.md#ListMasterHosts) and [ClusterService/ListSegmentHosts](../../api-ref/grpc/cluster_service.md#ListSegmentHosts) gRPC API calls and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

{% endlist %}


{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
