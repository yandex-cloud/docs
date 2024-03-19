# Restarting a host

You may need to restart hosts to promptly address such issues as the following:

* Resource overrun
* Memory leak
* Deadlock between requests
* Unresponsive {{ CH }} operations and internal processes

To restart a host:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
   1. In the required host row, click ![icon](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_restart-host }}**.
   1. Confirm the host restart.

- CLI {#cli}

   {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

   To restart a host, run this command:

   ```bash
   {{ yc-mdb-ch }} host restart <host_name> \
      --cluster-name=<cluster_name>
   ```

   You can request the host name with a list of cluster hosts, and the cluster name, with a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

- API {#api}

   To restart a host, use the [restartHosts](../../../managed-clickhouse/api-ref/Cluster/restartHosts.md) REST API method for the [Cluster](../../../managed-clickhouse/api-ref/Cluster/index.md) resource or the [ClusterService/RestartHosts](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#RestartHosts) gRPC API call and provide the following in your request:

   * In the `clusterId` parameter, the ID of the cluster where you want to change the host. To find out the cluster ID, get a [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
   * In the `hostNames` parameter, the name of the host you want to restart. To find out the host name, get a list of hosts in the cluster.

{% endlist %}
