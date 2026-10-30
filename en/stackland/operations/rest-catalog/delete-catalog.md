# Deleting a folder

You can delete a [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md) from the project namespace.

{% note warning %}

Along with the catalog, this will delete its Iceberg namespaces, tables, and views, as well as the data bucket. If the catalog is connected to {{ TR }}, queries to its data will cease to be executed.

{% endnote %}

If [deletion protection](../../concepts/components/rest-catalog.md#catalog) (`spec.deletionProtection: true`) is on, first [change the catalog settings](edit-catalog.md): set `spec.deletionProtection: false` and apply the changes.

## Using the CLI {#cli}

1. Find the catalog in the list:

    ```bash
    kubectl get stacklandrestcatalog -n <namespace>
    ```

1. Delete the catalog resource:

    ```bash
    kubectl delete stacklandrestcatalog <catalog_name> -n <namespace>
    ```

## Using the management console {#console}

1. Open the project and select the catalog’s namespace.
1. In the left-hand menu, select **REST Catalog** → **Catalogs**.
1. Open the catalog and click **Delete**.
1. Enter the catalog name in the confirmation window and confirm the deletion.

Deletion may take some time. While the catalog and its data are being deleted, the catalog remains in the list in the `deleting` state. Wait for it to disappear from the list.
