# Managing hosts in a cluster

You can get a list of {{ MS }} cluster hosts.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

  1. Go to the folder page and select **{{ mms-name }}**.

  1. Click on the name of the cluster you need and select the **Hosts** tab.

- API

  Use the [listHosts](../api-ref/Cluster/listHosts.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

