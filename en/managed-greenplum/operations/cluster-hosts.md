# Managing hosts in a cluster

You can get a list of hosts (masters and segments) in a {{ mgp-name }} cluster.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![hosts.svg](../../_assets/mdb/hosts.svg) **Hosts** tab.

   In the list of hosts, the **Role** column shows the role of each host:

   * `MASTER`: A primary master host. Receives user connections.
   * `REPLICA`: A standby master host. Replicates data of the primary master host.
   * `SEGMENT`: A segment host. Stores some of the cluster data.

- API

   Use the [listMasterHosts](../api-ref/Cluster/listMasterHosts.md) and [listSegmentHosts](../api-ref/Cluster/listSegmentHosts.md) API methods and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
