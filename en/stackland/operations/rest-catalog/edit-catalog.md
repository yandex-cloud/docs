# Updating catalog settings

You can edit the settings of an existing [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md). You cannot edit a catalog's (`metadata.name`) name.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `RestCatalog` resource for editing: `kubectl edit restcatalog <catalog name> -n <project name>`.
  1. Edit the specification parameters and save the file.

  You can also edit and reapply the local manifest: `kubectl apply -f restcatalog.yaml -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Iceberg REST Catalog**.
  1. In the **Catalogs** tab, select the catalog using one of the following methods:

      * Click the catalog name and click **Edit** in the card header.
      * Click **Edit** in the catalog's row.

  1. Edit the fields as needed. The **Name** field is read-only.
  1. Click **Save**.

{% endlist %}
