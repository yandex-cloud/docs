# Deleting a cluster {{ mtr-name }}

If you have an [{{ TR }} cluster](../../concepts/components/trino.md) in your [project](../projects/create-project.md), you can delete it.

{% note warning %}

If the **[deletion protection](../../concepts/components/trino.md#deletion-protection)** is on (`spec.deletionProtection: true`), you cannot delete the cluster. First, deactivate the protection by setting `spec.deletionProtection: false` in the manifest and applying the changes (`kubectl apply`). Alternatively, deactivate it in the [cluster settings](edit-cluster.md) in the management console. Then you can delete the cluster.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the cluster name in the list of clusters: `kubectl get TrinoCluster -n <namespace>`.
  1. Delete the cluster resource: `kubectl delete TrinoCluster <cluster_name> -n <namespace>`.


- Management console {#console}

  1. Open your project.
  1. Select the namespace the cluster was created in.
  1. In the left-hand menu, select **Trino** → **Clusters**.
  1. Select a cluster.
  1. Click **Delete**.
  1. In the confirmation window, enter the cluster name and click **Delete**.

{% endlist %}

During the deletion, you will see `Deleting` in the cluster list. As soon as it is completely deleted, the row will disappear from the table.

Attached catalogs (`TrinoCatalog`) will be deleted together with the cluster.
