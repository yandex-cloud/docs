# How to delete a cluster

{% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

{% list tabs %}

- Management console
  1. Open the folder page in the management console.
  1. Select **{{ mms-name }}**.
  1. Click ![image](../../_assets/options.svg) for the cluster and select **Delete cluster**.
  1. Confirm cluster deletion and click **Delete**.

- API

  To delete the cluster, use the `delete` API method: pass the ID of the desired cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

