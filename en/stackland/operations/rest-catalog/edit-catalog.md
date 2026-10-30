# Editing catalog settings

You can edit the description and deletion protection settings for an existing [{{ rest-catalog-name }}](../../concepts/components/rest-catalog.md). Once a catalog is created, its name (`metadata.name`) and labels (`spec.labels`) cannot be changed.

## Using the CLI {#cli}

1. Open the `StacklandRestCatalog` resource to edit it:

    ```bash
    kubectl edit stacklandrestcatalog <catalog_name> -n <namespace>
    ```

1. Edit the parameters as needed:

    * `spec.description`: Catalog description of up to 256 characters.
    * `spec.deletionProtection`: Deletion protection. Use `true` to enable protection or `false` to disable it.

1. Save your changes.

You can also edit and reapply the local manifest:

```bash
kubectl apply -f stacklandrestcatalog.yaml -n <namespace>
```

To change access to data, follow [Assigning permissions for a catalog](create-principal.md) and [Revoking permissions for a catalog](delete-principal.md).

## Using the management console {#console}

1. Open the project and select the catalog’s namespace.
1. In the left-hand menu, select **REST Catalog** → **Catalogs**.
1. Open the catalog and click **Edit**.
1. Change the **Description** or toggle **Deletion protection**. The **Name**, **Bucket**, and **Labels** fields are read-only.
1. Click **Save**.

To change a role or access scope of a user or group, [edit the permission assignment](create-principal.md#edit).
