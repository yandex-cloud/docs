# Creating a {{ mtr-name }} catalog

A [{{ TR }} catalog](../../concepts/components/trino.md#catalogs) defines a connection to an external data source. Each catalog is described using a `TrinoCatalog` resource and associated with a specific cluster via the `spec.cluster` field.

Supported catalog types:

* `postgresql`: {{ PG }} connection.
* `clickhouse`: {{ CH }} connection.
* `iceberg`: {{ IBRG }} connection via the REST catalog.

{% note info %}

When you create a catalog, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating`, and active queries get interrupted. For more information, see [Updating a cluster](../../concepts/components/trino.md#cluster-update).

{% endnote %}

## Using the CLI {#cli}

1. Prepare a Secret containing credentials for connecting to the data source.
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

    - Iceberg (REST catalog, S3)

        Below is an example of an Iceberg catalog using a REST catalog, client credentials authentication, and storage in an S3-compatible bucket.

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-catalog-iceberg.md) %}

        Settings:

        * `spec.iceberg.url`: REST catalog URL.
        * `spec.iceberg.storageType`: Storage type. The possible values are `s3` and `stackland-storage`.
        * `spec.iceberg.rest.warehouse`: REST catalog name.
        * `spec.iceberg.rest.oauth2.clientCredentials`: Client credentials authentication parameters: the authorization server URL (`tokenEndpoint`) and the Secret containing the client ID and client secret.
        * `spec.iceberg.s3.endpoint`, `region`: S3 storage settings.
        * `spec.iceberg.s3.credentialsSecretRef`: Secret with `access-key-id` and `secret-access-key`.

        For a static token, instead of `clientCredentials`, specify `spec.iceberg.rest.oauth2.accessTokenSecretRef` with a reference to the Secret containing the token.

    - Iceberg (REST catalog, {{ objstorage-name }})

        Below is an example of an Iceberg catalog with a {{ stackland-name }} managed object storage. It is only available for clusters with enabled [{{ objstorage-name }}](../../concepts/components/storage.md).

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-catalog-iceberg-stackland-storage.md) %}

        Settings:

        * `spec.iceberg.rest.oauth2.clientCredentials`: Client credentials authentication parameters for the platform {{ rest-catalog-name }}: the authorization server URL (`tokenEndpoint`) and the secret containing `clientId` and `clientSecret` of the `RestCatalogPrincipal` user.
        * `spec.iceberg.storageType: stackland-storage`.
        * `spec.iceberg.stacklandStorage.bucketRef`: Reference to the `Bucket` resource in the current namespace.

        The operator automatically creates `AccessKey` and `AccessBinding` and populates the S3 connection parameters.

        {% note info %}

        This example targets the platform [{{ rest-catalog-name }} connection](../../concepts/components/rest-catalog.md). Insert the following values from the `RestCatalog` resource and the user secret:

        * `spec.iceberg.url`: `status.endpoint` value.
        * `spec.iceberg.rest.oauth2.clientCredentials.tokenEndpoint`: `status.oauth2TokenEndpoint` value.
        * `spec.iceberg.rest.warehouse`: `RestCatalog` resource name.
        * `credentialsSecretRef`: Secret containing `clientId` and `clientSecret` of the `RestCatalogPrincipal` user. For details, see [Creating a catalog user](../rest-catalog/create-principal.md).

        {% endnote %}

    {% endlist %}

    {% note tip %}

    Make sure the resource name (`metadata.name`) follows the `<spec.name>-<spec.cluster>` format as shown above. Otherwise, the operator will reject catalog creation.

    {% endnote %}

1. Apply the manifest: `kubectl apply -f trinocatalog.yaml -n <namespace>`.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. Select the namespace the cluster was created in.
1. In the left-hand menu, select **Trino** → **Clusters**.
1. Select the cluster.
1. Open the **Catalogs** tab and click **Create catalog**.
1. Fill out the fields as follows:

    **Basic settings**

    * **Name**: Catalog name in {{ TR }}. It is defined in `spec.name`. The management console automatically uses the `<catalog_name>-<cluster_name>` format for the Kubernetes resource name (`metadata.name`).
    * **Type**: Connector type. Valid values: `postgresql`, `clickhouse`, `iceberg`.

    After selecting the type, the **Catalog settings** section appears.

    **Catalog settings: PostgreSQL**

    * **URL**: Server address in `host:port/database` format.
    * **Username**: {{ PG }} user.
    * **Password**: User password.

    **Catalog settings: ClickHouse**

    * **URL**: Server address in `host:port/database` format.
    * **Username**: {{ CH }} user.
    * **Password**: User password.

    **Catalog settings: Iceberg (REST catalog)**

    **Connection**:

    * **URL**: REST catalog URL.
    * **Warehouse**: REST catalog name. This is an optional setting.

    **Authentication** (optional subsection):

    * **Authentication method**: `No authentication`, `Static token`, or `Client credentials`.
    * For a static token: **Access token**.
    * For client credentials: **Authorization server URL**, **Client ID**, and **Client secret**. For a platform {{ rest-catalog-name }}, set **Client ID** and **Client secret** to `clientId` and `clientSecret` of the [`RestCatalogPrincipal`](../rest-catalog/create-principal.md) user, respectively. In the **Additional** submenu, you can specify **Scope**, **Token update**, and **Token exchange**.

    **Data storage**:

    * **Storage type**: `s3` or `stackland-storage`. `stackland-storage` is only available for clusters with enabled **{{ objstorage-name }}**.
    * For `s3`: **Endpoint**, **Region**, **Access key ID**, **Secret access key**, and **Path-style access**.
    * For `stackland-storage`: **Bucket**: Selecting a bucket from the list of `Bucket` resources in the current namespace.

    **Additional settings** (optional)

    This section contains custom connector settings in `key-value` format. You can add each key only once.

1. Click **Create**.

The new catalog is ready and shown in the **Catalogs** list. After the operator applies the new configuration and the cluster switches to `Running`, the catalog will be available in SQL queries.
