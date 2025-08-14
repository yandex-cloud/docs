# Migrating {{ PG }} clusters

To migrate your database to {{ mpg-full-name }}, you need to directly transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.

{% note warning %}

Users are not transferred automatically to a {{ mpg-name }} cluster. You need to [create](../../managed-postgresql/operations/cluster-users.md#adduser) them again in the new cluster.

{% endnote %}

Performing migration with {{ data-transfer-name }} allows you to:

* Go without creating an intermediate VM or granting online access to your {{ mpg-name }} target cluster.
* Minimize the DB downtime when migrating data.
* Migrate from older {{ PG }} versions to newer versions.

For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

To use these migration methods, allow connecting to the source cluster from the internet.

## Transferring data {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](datatransfer/managed-postgresql.md) %}


## Quick data transfer to a new cluster {#quick-transfer}

After creating a {{ mpg-name }} cluster, you can immediately transfer data from another {{ mpg-name }} cluster or custom database installation into it.

This migration method provides:

  * Automatic creation of a transfer and endpoints.
  * One-time transfer of the data snapshot from the source to the target.

### Required paid resources {#paid-resources}

The support cost includes:

* {{ mpg-name }} cluster fee: Using DB hosts and disk space (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for using public IP addresses (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Transfer fee: using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).

### Transfer the data {#transfer-data-quickly}

1. Open the **{{ ui-key.yacloud.mdb.cluster.overview.label_title }}** page of the new {{ mpg-name }} cluster.
1. At the top of the screen, click **{{ ui-key.yacloud.mdb.cluster.title_migration-alert-action }}**.
1. Configure the source:

    {% list tabs %}

    - Custom installation

      * **Connecting**:

          * **Select existing connection**: Select this option to use an existing connection.

            * **Connection ID**: Select the connection in [{{ connection-manager-full-name }}](../../metadata-hub/quickstart/connection-manager.md).
            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Enter the DB name.
          
          * **Create new connection**: Select this option to create a new connection.

            * **Hosts**: Specify the IP address or FQDN of the master host. If hosts have different ports open for connection, you can specify multiple host values in `host:port` format. In this case, the value of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** field will be disregarded.

            * **Username**: Enter a username for connecting to the DB.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: Enter the password to access the database.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Enter the DB name.

            * **TLS**: Enable this setting to use TLS connection.

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.ca_certificate.title }}**: Add the certificate file contents.
      
    - {{ mpg-name }} cluster

      * **Connecting**:

        * **Select existing connection**: Select this option to use an existing connection.

          * **Cluster ID**: Select the cluster to connect to.

          * **Connection ID**: Select the connection in [{{ connection-manager-full-name }}](../../metadata-hub/quickstart/connection-manager.md).

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the DB name in the cluster you selected.

        * **Create new connection**: Select this option to create a new connection.

          * **Cluster ID**: Select the cluster to connect to.

          * **Username**: Enter a username for connecting to the cluster DB.

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: Enter the user password to access the cluster DB.

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the DB name in the selected cluster.

    {% endlist %}

   {% include [connection-manager-access](../../_includes/data-transfer/notes/connection-manager-access.md) %}

1. Configure the target:

    * **Connection ID**: Select the connection in {{ connection-manager-name }}.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the target cluster’s DB name.

1. Optionally, configure advanced settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.cleanup_policy.title }}**: Select the method to clean up data in the target database:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete the tables included in the transfer (default).

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but keep the schema.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}**: Only data from the tables listed here will be transferred.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

      The lists include the name of the [schema]({{ pg-docs }}/ddl-schemas.html) that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

      * `<schema_name>.<table_name>`: Full table name.
      * `<schema_name>.*`: All tables in the specified schema.

      Table names must match this regular expression:

      ```text
      ^"?[-_a-zA-Z0-9.]+"?\\."?[$-_a-zA-Z0-9.*]+"?$
      ```

      Double quotes within a table name are not supported. Outer quotes are only used as delimiters and will be deleted when processing paths.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.object_transfer_settings.title }}**: Select the DB schema elements to migrate when activating or deactivating a transfer.

1. Click **{{ ui-key.yacloud.common.create }}** to create a transfer and endpoints.

1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

1. Some resources are not free of charge. To avoid unnecessary charges, delete the resources you no longer need:

    * [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md) if you transferred data from it.
    * [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
    * [Delete](../../data-transfer/operations/endpoint/index.md#delete) the source and target endpoints.
  

## Transferring tables with data types from {{ PG }} extensions

{{ data-transfer-name }} allows you to copy tables, the columns of which contain data types defined in {{ PG }} and tables with derived types, i.e., arrays of these types and composite types with fields of these types. Currently, there is a limitation: the data type must implement __binary I/O functions__. This means that, for the type of data in the [pg_type](https://www.postgresql.org/docs/current/catalog-pg-type.html) system view, the `typsend` and `typreceive` column values must not be zero.

For example, for the [PostGIS](https://postgis.net/) extension, columns of the [`GEOMETRY`](https://postgis.net/docs/geometry.html), [`GEOMETRY_DUMP`](https://postgis.net/docs/geometry_dump.html), and [`GEOGRAPHY`](https://postgis.net/docs/geography.html) types can be transferred, while those of the [`BOX2D`](https://postgis.net/docs/box2d_type.html) and [`BOX3D`](https://postgis.net/docs/box3d_type.html) types cannot.

## See also {#see-also}

For other migration methods, see [this {{ mpg-full-name }} tutorial](../../managed-postgresql/tutorials/data-migration.md).
