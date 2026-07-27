# Deleting a catalog user

If you have an [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md) user in your [project](../projects/create-project.md), you can delete it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the user in the list of project users: `kubectl get RestCatalogPrincipal -n <project name>`.
  1. Delete the user's resource: `kubectl delete RestCatalogPrincipal <user name> -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Iceberg REST Catalog**.
  1. In the **Catalogs** tab, select the catalog.
  1. Go to the **Users** tab.
  1. Select the user.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}
