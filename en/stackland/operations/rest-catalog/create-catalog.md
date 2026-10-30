# Creating a catalog

Create an [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md) within your [project namespace](../projects/manage-namespaces.md). The {{ rest-catalog-name }} and [{{ objstorage-name }} components](../../concepts/components/storage.md) must be enabled in the cluster.

A bucket for the catalog data and its access key are provisioned automatically. You do not need to create them beforehand.

## Using the CLI {#cli}

1. Create a file named `stacklandrestcatalog.yaml` with the `StacklandRestCatalog` resource configuration:

    {% include notitle [YAML-file restcatalog](../../_includes/yamls/operations/rest-catalog/restcatalog.md) %}

    Specify the catalog name in `metadata.name`. You can also add an optional description in `spec.description`, set labels in `spec.labels`, or enable deletion protection with `spec.deletionProtection: true`. Labels are set only when a catalog is created.

1. Apply the manifest:

    ```bash
    kubectl apply -f stacklandrestcatalog.yaml -n <namespace>
    ```

1. Check the catalog status:

    ```bash
    kubectl get stacklandrestcatalog analytics -n <namespace>
    ```

    Wait for the `ready` status in the `Phase` column.

## Using the management console {#console}

1. Open the project and select the namespace you want to create the catalog in.
1. In the left-hand menu, select **REST Catalog** → **Catalogs**.
1. Click **Create catalog**.
1. Under **Main parameters**, fill in the following fields:

    * **Name**: Catalog name that is unique within the namespace. Use up to 63 characters: lowercase Latin letters, digits, and hyphens. The name must start with a letter and end with a letter or digit.
    * **Description**: Description up to 256 characters long. This is an optional field.
    * **Labels**: **Key**-**Value** pairs. To add a pair, click **Add label**. The keys must be unique. Labels cannot be modified after the catalog is created.
    * **Deletion protection**: Enable this option to prevent accidental deletion of the catalog and its data.

1. Click **Create** and wait for the catalog to appear as ready in the list.

After creating it, [assign permissions](create-principal.md) to users, groups, or service accounts. To query data via {{ TR }}, [connect the catalog to a cluster](../trino/create-catalog.md) within the same namespace.
