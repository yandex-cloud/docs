# Creating a catalog

If you have a [project](../projects/create-project.md), you can create a [{{ rest-catalog-name }} catalog](../../concepts/components/rest-catalog.md) in it.

Before you create a catalog, make sure the bucket referenced by the `spec.stacklandStorage.bucketRef` parameter already exists. To create a bucket, follow [this guide](../storage/create-bucket.md).

{% list tabs group=instructions %}

- CLI {#cli}

  1. If the project does not exist yet, create it: `kubectl create namespace <project name>`.
  1. Create the `RestCatalog` resource file, e.g., using the `touch restcatalog.yaml` command.
  1. Open the file and paste the configuration below into it:

      {% include notitle [YAML-file restcatalog](../../_includes/yamls/operations/rest-catalog/restcatalog.md) %}

  1. Apply the manifest: `kubectl apply -f restcatalog.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Iceberg REST Catalog**.
  1. In the **Catalogs** tab, click **Create catalog**.
  1. Fill out the fields as follows:

      * **Name**: Catalog name. Once created, the name never changes.
      * **Bucket name**: Select an existing bucket from the list or create a new one.
      * **Allowed storage paths**: Specify at least one path in `s3://<bucket name>/...` format. Add more than one path if needed.
      * **Default base path**: Select one of the allowed paths or leave the field empty.
      * **Default namespace**: Specify path segments if needed.
      * **Additional parameters**: Specify key-value pairs if needed.

  1. Under **User groups**, add the names of the catalog's user groups.
  1. Under **Catalog roles**, add roles if needed. For each role, specify the name, user groups, scope (**Catalog**, **Namespace**, **Table**, or **Visualization**), and privileges.
  1. Click **Create**.

{% endlist %}
