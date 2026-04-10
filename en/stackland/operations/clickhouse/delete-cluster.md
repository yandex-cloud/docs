# Deleting a cluster {{ mch-name }}

If you have an [{{ CH }} cluster](../../concepts/components/clickhouse.md) in your [project](../projects/create-project.md), you can delete it.

{% note info %}

If the [deletion protection](../../concepts/components/clickhouse.md#deletion-protection) is on (`spec.deletionProtection: true`), the operator will reject the deletion of the resource. First, deactivate the protection in [cluster settings](edit-cluster.md) by going `spec.deletionProtection: false`, apply the manifest, and then proceed with the deletion.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the cluster name in the list of project clusters: `kubectl get ClickhouseCluster -n <project_name>`.
  1. Delete the cluster resource: `kubectl delete ClickhouseCluster <cluster_name> -n <project_name>`.


- Management console {#console}

  1. Open your project.
  1. In the left-hand menu, select **{{ CH }} Clusters**.
  1. Select a cluster.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}

This is it. You have successfully deleted the cluster.
