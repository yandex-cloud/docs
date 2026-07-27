# Deleting a folder.

If you have a [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md) in your [project](../projects/create-project.md), you can delete it.

{% note warning %}

If the **[deletion protection](../../concepts/components/rest-catalog.md#catalog)** is on (`spec.deletionProtection: true`), you cannot delete the catalog. First, deactivate the protection by setting `spec.deletionProtection: false` in the manifest and applying the changes (`kubectl apply`). Alternatively, deactivate it in the [catalog settings](edit-catalog.md) in the management console. Then you can delete the catalog.

{% endnote %}

{% note warning %}

Catalog users (`RestCatalogPrincipal`) are not automatically deleted together with the catalog. Before deleting the catalog, delete all its users. For more information, see [Deleting a catalog user](delete-principal.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the catalog in the list of project catalogs: `kubectl get RestCatalog -n <project name>`.
  1. Delete the catalog resource: `kubectl delete RestCatalog <catalog name> -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Iceberg REST Catalog**.
  1. In the **Catalogs** tab, select the catalog.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}
