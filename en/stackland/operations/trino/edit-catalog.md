# Updating {{ mtr-name }} catalog settings

If you have a [catalog](../../concepts/components/trino.md#catalogs) in your [{{ TR }} cluster](../../concepts/components/trino.md), you can update the catalog’s settings.

{% note info %}

When you update a catalog, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating`, and active queries get interrupted. For more information, see [Updating a cluster](../../concepts/components/trino.md#cluster-update).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `TrinoCatalog` resource file, e.g., using the `open trinocatalog.yaml` command.
  1. Edit the properties of the selected catalog type.

      General properties:

      * `spec.<type>.url`: Data source address
      * `spec.<type>.additionalProperties`: Advanced connector settings.

      For PostgreSQL and ClickHouse catalogs, the following properties are also available:

      * `spec.<type>.credentialsSecretRef`: Reference to the Secret with credentials.
      * `spec.<type>.certificateSecretRef`: Reference to the Secret with a TLS certificate.

      The `spec.cluster`, `spec.name`, and `spec.type` fields are immutable: `spec.cluster` and `spec.name` make up the resource name (`metadata.name`), and modifying `spec.type` is not supported.

      For Iceberg catalogs, the following properties are also available:

      * `spec.iceberg.rest.warehouse`: REST catalog name.
      * `spec.iceberg.rest.oauth2`: Authentication parameters (static token or client credentials).
      * `spec.iceberg.s3`: S3 storage settings.
      * `spec.iceberg.stacklandStorage.bucketRef`: Link to an {{ objstorage-name }} bucket.

  1. Apply the manifest: `kubectl apply -f trinocatalog.yaml -n <namespace>`.

  If you store credentials in a Secret, update the Secret independently. You do not need to rename the secret name or keys.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. Select the namespace the cluster was created in.
  1. In the left-hand menu, select **Trino** → **Clusters**.
  1. Select the cluster and open the **Catalogs** tab.
  1. Select the catalog.
  1. Click **Edit**.
  1. Edit the catalog configuration under **Catalog settings**. The **Name** and **Type** fields are read-only.

      The Secret fields, such as **Password**, **Access token**, **Client secret**, and **Secret access key**, are empty. If you save them as is, the existing Secret values will remain unchanged. Enter a new value to update the secret.

      In the **Additional settings** section, the key is read-only for existing rows; you can only change the value. Still, you can add new keys.

  1. Click **Save**.

{% endlist %}

Done. The catalog settings have been updated.
