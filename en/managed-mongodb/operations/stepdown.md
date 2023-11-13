# Selecting a different primary replica

If a cluster has [several replicas](../concepts/replication.md), you can select a different primary replica (master) as required.

Switching takes on average less than a minute. The cluster may be unavailable for writing for several seconds while switching is taking place.

For more information about selecting a different primary replica, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/rs.stepDown/).

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}** tab.
   1. Click ![options](../../_assets/horizontal-ellipsis.svg) in the row of the `PRIMARY` host and select **{{ ui-key.yacloud.mongodb.hosts.action_stepdown-host }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a cluster's primary replica, run the command:

   ```bash
   {{ yc-mdb-mg }} hosts stepdown <name_of_current_primary_replica> \
      --name=<cluster_name>
   ```

   You can request the name of the shard primary replica with a [list of cluster hosts](hosts.md#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To switch to a different primary replica, use the [stepdownHosts](../api-ref/Cluster/stepdownHosts.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/StepdownHosts](../api-ref/grpc/cluster_service.md#StepdownHosts) gRPC API call and provide the following in the request:

   * In the `clusterId` parameter, the ID of the cluster where you want to change the primary replica. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * In the `hostNames` parameter, the name of the current primary replica. To find out the name, request a [list of hosts in the cluster](hosts.md#list).

{% endlist %}
