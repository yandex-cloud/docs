# Managing hosts

You can add hosts to an {{ ES }} cluster, delete hosts from the cluster, and get a list of hosts in the cluster.

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mes-name }}**.
  1. Click on the name of the cluster you need and select the **Hosts** tab.

- API

  Use the `listHosts` API method: pass the ID of the desired cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding hosts to a cluster {#add-hosts}

{% list tabs %}

- API

  Use the `addHosts` API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

  Add the required number of `hostSpecs` parameters with the host's settings (one parameter for each new host).

{% endlist %}

## Deleting hosts from a cluster {#delete-hosts}

{% list tabs %}

- API

  Use the `deleteHosts` API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

  In one or more `hostNames[]` parameters, specify the names of the hosts you wish to delete from the cluster.

{% endlist %}

