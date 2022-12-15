# Selecting a different primary replica

If a cluster has [several replicas](../concepts/replication.md), you can select a different primary replica (master) as required.

Switching takes on average less than a minute. The cluster may be unavailable for writing for several seconds while switching is taking place.

For more information about selecting a different primary replica, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/rs.stepDown/).

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mmg-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Click ![options](../../_assets/horizontal-ellipsis.svg) in the row of the `PRIMARY` host and select **Change master**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change a cluster's primary replica, run the command:

   ```bash
   {{ yc-mdb-mg }} hosts stepdown <name of current primary replica> \
      --name=<cluster name>
   ```

   You can request the name of the shard primary replica with a [list of cluster hosts](hosts.md#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the API [stepdownHosts](../api-ref/Cluster/stepdownHosts.md) method and pass the following in the request:

   * In the `clusterId` parameter, the ID of the cluster where you want to change the primary replica. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   * In the `hostNames` parameter, the name of the current primary replica. To find out the name, request a [list of hosts in the cluster](hosts.md#list).

{% endlist %}
