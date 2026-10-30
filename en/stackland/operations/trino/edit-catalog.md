# Updating {{ mtr-name }} catalog settings

If you have a [catalog](../../concepts/components/trino.md#catalogs) in your [{{ TR }} cluster](../../concepts/components/trino.md), you can update the catalog’s settings.

{% note info %}

When you update a catalog, {{ mtr-name }} recreates the cluster. While the system applies the new configuration, the cluster status switches to `Updating` and all active queries are terminated. For more information, see [Updating a cluster](../../concepts/components/trino.md#cluster-update).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `TrinoCatalog` resource file, e.g., using the `open trinocatalog.yaml` command.
  1. Edit the properties of the selected catalog type.

      For {{ PG }} and {{ CH }} catalogs, you can configure the following properties in the `spec.postgres` and `spec.clickhouse` sections, respectively:

      * `url`: Data source address.
      * `credentialsSecretRef`: Reference to the Secret with credentials.
      * `certificateSecretRef`: Reference to the Secret with a TLS certificate.
      * `additionalProperties`: Additional connector settings.

      An {{ IBRG }} catalog supports the following properties:

      * `spec.stacklandRestCatalog.catalogRef`: `StacklandRestCatalog` resource name in the same namespace. When selecting a different catalog, make sure it is ready for use and {{ TR }} users have the [access permissions](../rest-catalog/create-principal.md) for it.
      * `spec.stacklandRestCatalog.useExternalEndpoint`: Using an external catalog address. To set it to `true`, you need to configure [public access](../../concepts/components/rest-catalog.md#endpoints) and fill the `status.externalEndpoint` field for the catalog.
      * `spec.stacklandRestCatalog.additionalProperties`: [Additional Iceberg settings](../../concepts/components/trino.md#iceberg-settings), i.e., data format and compression, file size, filter requirements for queries, statistics, storage options, and Iceberg view support. Use [this example of creating a catalog](create-catalog.md#cli) to add the properties and edit them as needed. When creating views, specify `SECURITY INVOKER`; for more information, see [Iceberg views](../../concepts/components/trino.md#iceberg-views).

      There must be a single section with connector settings in the manifest. `spec.type` is not used. The `spec.cluster` and `spec.name` values must match the `metadata.name` resource name in `<spec.name>-<spec.cluster>` format.

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

      For {{ PG }} and {{ CH }}, the **Password** field is empty. If you save it empty, the existing secret value will remain unchanged. Enter a new value to update the Secret.

      For {{ IBRG }}, you can select a different **REST Catalog** in the same namespace and change the **Access method** to **Internal** or **External**. The **External** method is available if the catalog you select has an external address. Make sure users have the [access permissions](../rest-catalog/create-principal.md#console) for the new catalog.

      In the **Additional settings** section, the key is read-only for existing rows; you can only change the value. Still, you can add new keys.

  1. Click **Save**.

{% endlist %}

Done. The catalog settings have been updated.
