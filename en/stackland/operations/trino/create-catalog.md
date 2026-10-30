# Creating a {{ mtr-name }} catalog

A [{{ TR }} catalog](../../concepts/components/trino.md#catalogs) defines a connection to a data source. Each catalog is described using a `TrinoCatalog` resource and associated with a specific cluster via the `spec.cluster` field.

Supported catalog types:

* {{ PG }}: Connection properties are specified in `spec.postgres`.
* {{ CH }}: Connection properties are specified in `spec.clickhouse`.
* {{ IBRG }}: Connection to [{{ rest-catalog-name }}](../../concepts/components/rest-catalog.md) in {{ stackland-name }} is set in `spec.stacklandRestCatalog`.

In the manifest, specify a single section with connector settings. You do not need to add the `spec.type` property.

{% note info %}

When you create a catalog, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating`, and active queries get interrupted. For more information, see [Updating a cluster](../../concepts/components/trino.md#cluster-update).

{% endnote %}

## Using the CLI {#cli}

1. Get the data source ready:

    * For {{ PG }} and {{ CH }}, create a secret with credentials.
    * For {{ IBRG }}, make sure the {{ rest-catalog-name }} and [{{ objstorage-name }}](../../concepts/components/storage.md) components are enabled. [Create the {{ rest-catalog-name }} catalog](../rest-catalog/create-catalog.md) in the same namespace as the {{ TR }} cluster and wait for its status to change to `ready`. [Grant permissions](../rest-catalog/create-principal.md) to the user or service account that will run queries.

1. Create the `TrinoCatalog` resource file, e.g., using the `touch trinocatalog.yaml` command.
1. Open the file and paste the configuration for the appropriate catalog type:

    {% list tabs %}

    - {{ PG }}

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-catalog-postgresql.md) %}

        Settings:

        * `spec.cluster`: Name of the {{ TR }} cluster you want to associate the catalog with.
        * `spec.name`: Catalog name in {{ TR }} (used in SQL queries, such as `SELECT * FROM <catalog_name>.schema.table`).
        * `spec.postgres.url`: {{ PG }} server address in `host:port/database` format.
        * `spec.postgres.credentialsSecretRef`: Reference to the Secret with credentials, and the names of `usernameKey` and `passwordKey`.

    -{{ CH }}

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-catalog-clickhouse.md) %}

        Settings:

        * `spec.cluster`: {{ TR }} cluster name.
        * `spec.name`: Catalog name in {{ TR }}.
        * `spec.clickhouse.url`: {{ CH }} server address in `host:port/database` format.
        * `spec.clickhouse.credentialsSecretRef`: Reference to the Secret with credentials.

    - Iceberg

        Specify the name of the `StacklandRestCatalog` resource. The connection settings for both the catalog and storage will be populated automatically.

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-catalog-iceberg.md) %}

        Settings:

        * `spec.cluster`: {{ TR }} cluster name.
        * `spec.name`: Catalog name in {{ TR }} SQL queries.
        * `spec.stacklandRestCatalog.catalogRef`: `StacklandRestCatalog` resource name in the same namespace.
        * `spec.stacklandRestCatalog.useExternalEndpoint`: Using an external catalog address. The default value is `false`, i.e., the internal address is used. You may specify `true` if [public access is enabled](../../concepts/components/rest-catalog.md#endpoints) for the catalog and the `status.externalEndpoint` field is populated.
        * `spec.stacklandRestCatalog.additionalProperties`: [Additional Iceberg settings](../../concepts/components/trino.md#iceberg-settings), i.e., data format and compression, file size, filter requirements for queries, statistics, storage options, and Iceberg view support. This is an optional setting.

        The following example uses the catalog's external endpoint. For new tables, the default settings are the `PARQUET` format, `ZSTD` compression, and target maximum file size of `512MB`. Queries to partitioned tables within the `reports` and `events` SQL schemas require a filter by partition keys. The storage connection timeout is set to `10s`, and the read/write timeout is `30s`. Setting `iceberg.rest-catalog.view-endpoints-enabled: true` enables support for Iceberg views. When creating views, specify `SECURITY INVOKER`; for more information, see [Iceberg views](../../concepts/components/trino.md#iceberg-views).

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-catalog-iceberg-additional-properties.md) %}

    {% endlist %}

    {% note tip %}

    Make sure the resource name (`metadata.name`) follows the `<spec.name>-<spec.cluster>` format as shown above. Otherwise, the operator will reject catalog creation.

    {% endnote %}

1. Apply the manifest: `kubectl apply -f trinocatalog.yaml -n <namespace>`.

## Using the management console {#console}

To connect {{ IBRG }}, first, [create an {{ rest-catalog-name }} catalog](../rest-catalog/create-catalog.md#console) in the same namespace, wait until it is ready, and [assign permission](../rest-catalog/create-principal.md#console) to a user or group.

1. If you have not opened a project yet, select one.
1. Select the namespace the cluster was created in.
1. In the left-hand menu, select **Trino** → **Clusters**.
1. Select the cluster.
1. Open the **Catalogs** tab and click **Create catalog**.
1. Fill out the fields as follows:

    **Basic settings**

    * **Name**: Catalog name in {{ TR }}. It is defined in `spec.name`. The management console automatically uses the `<catalog_name>-<cluster_name>` format for the Kubernetes resource name (`metadata.name`).
    * **Type**: Connector type, i.e., `postgresql`, `clickhouse`, or `iceberg`.

    After selecting the type, the **Catalog settings** section appears.

    **Catalog settings: PostgreSQL**

    * **URL**: Server address in `host:port/database` format.
    * **Username**: {{ PG }} user.
    * **Password**: User password.

    **Catalog settings: ClickHouse**

    * **URL**: Server address in `host:port/database` format.
    * **Username**: {{ CH }} user.
    * **Password**: User password.

    **Сatalog settings: Iceberg**

    * **REST Catalog**: {{ rest-catalog-name }} catalog within the current namespace.
    * **Access method**: **Internal** or **External**. The **External** method is available if the selected catalog has a configured external address.

    **Additional settings** (optional)

    Specify supported connector settings as `key:value` pairs. You can add each key only once. For {{ IBRG }}, you can configure [settings for data storage, queries, storage access, and Iceberg views](../../concepts/components/trino.md#iceberg-settings).

1. Click **Create**.

The new catalog is ready and shown in the **Catalogs** list. After the operator applies the new configuration and the cluster switches to `Running`, the catalog will be available in SQL queries.
