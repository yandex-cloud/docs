# Deleting clusters

You can delete an {{ KF }} cluster if you no longer need it. All data in the cluster will be deleted.

{% list tabs %}

- Management console
  1. In the management console, select the folder you want to delete a cluster from.
  1. Select **{{ mkf-name }}**.
  1. Click ![image](../../_assets/options.svg) for the cluster and select **Delete cluster**.
  1. Read the warning displayed. Confirm cluster deletion and click **Delete**.

{% if api != "noshow" %}

- API

  To delete a cluster, use the [delete](../api-ref/Cluster/delete.md) API method: pass the cluster ID in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endif %}

{% endlist %}
