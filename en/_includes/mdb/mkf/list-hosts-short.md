{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the appropriate folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.

- CLI {#cli}

   ```bash
   {{ yc-mdb-kf }} cluster list-hosts <cluster_name_or_ID>
   ```

   The FQDN is specified in the command output under `NAME`.

- API {#api}

   Use the [listHosts](../../../managed-kafka/api-ref/Cluster/listHosts.md) REST API method for the [Cluster](../../../managed-kafka/api-ref/Cluster/index.md) resource or the [ClusterService/listHosts](../../../managed-kafka/api-ref/grpc/cluster_service.md#ListHosts) gRPC API call and provide the cluster ID in the `clusterId` request parameter. To find out the cluster ID, [get a list of clusters in the folder](../../../managed-kafka/operations/cluster-list.md#list-clusters).

   The FQDN is specified in the response under `hosts[].name`.

{% endlist %}