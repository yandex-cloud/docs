# Managing hosts in a cluster

You can retrieve a list of {{ MS }} cluster hosts and manage host settings.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.

   1. Click the name of the desired cluster and select the ![hosts.svg](../../_assets/mdb/hosts.svg) **Hosts** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of cluster hosts, run the command:

   ```bash
   {{ yc-mdb-ms }} host list \
      --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   Use the [listHosts](../api-ref/Cluster/listHosts.md) API method: pass the ID of the desired cluster in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Changing a host {#update}

You can modify public access settings for every host in a {{ mms-short-name }} cluster.

{% list tabs %}

- Management console

   To change the parameters of the cluster host:

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mms-name }}**.
   1. Click the name of the desired cluster and select the ![hosts.svg](../../_assets/mdb/hosts.svg) **Hosts** tab.
   1. Click the ![image](../../_assets/options.svg) icon in the same row as the desired host and select **Edit**.
   1. Enable **Public access** if a host must be accessible from outside {{ yandex-cloud }}.
   1. Click **Save**.

- API

   To change the parameters of the host, use the [updateHosts](../api-ref/Cluster/updateHosts.md) API method and pass the following in the query:

   1. In the `clusterId` parameter, the ID of the cluster where you want to change the host. To find out the cluster ID, get a [list of clusters in the folder](cluster-list.md#list-clusters).
   1. In the `updateHostSpecs.hostName` parameter, the name of the host you want to change. To find out the name, request a [list of hosts in the cluster](#list).
   1. Host public access settings as `updateHostSpecs.assignPublicIp`.
   1. List of cluster configuration fields to be changed in the `updateMask` parameter.

   {% include [Note warning update mask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

If you can't [connect](connect.md) to the changed host, check that the cluster's [security group](../concepts/network.md#security-groups) is configured correctly for the subnet where you placed the host.

{% endnote %}
