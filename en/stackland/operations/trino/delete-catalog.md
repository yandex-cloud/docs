# Deleting a {{ mtr-name }} catalog

If you have a [catalog](../../concepts/components/trino.md#catalogs) in your [{{ TR }} cluster](../../concepts/components/trino.md), you can delete it. After you delete the catalog, the data source will no longer be available in cluster SQL queries.

{% note info %}

When you delete a catalog, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating`, and active queries get interrupted. For more information, see [Updating a cluster](../../concepts/components/trino.md#cluster-update).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the catalog in the list of catalogs: `kubectl get TrinoCatalog -n <namespace>`.
  1. Delete the catalog resource: `kubectl delete TrinoCatalog <catalog_name> -n <namespace>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. Select the namespace the cluster was created in.
  1. In the left-hand menu, select **Trino** → **Clusters**.
  1. Select the cluster and open the **Catalogs** tab.
  1. Select a folder.
  1. Click **Delete**.
  1. In the confirmation window, enter the catalog name and click **Delete**.

{% endlist %}

While the resource is being deleted, you will see `Deleting` in the lit of catalogs. As soon as it is completely deleted, the row will disappear from the table.

The operator deletes Secrets associated with credentials together with the catalog if they were created through the management console and are not used by other resources.
