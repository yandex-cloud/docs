# Managing a target endpoint

[Endpoints](../concepts/index.md#endpoint) for the target describe the settings of the database that information will be transferred to using {{ data-transfer-name }}. You can [create](#create), [update](#update), or [delete](#delete) this kind of endpoint.

## Creating a target endpoint {#create}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ data-transfer-name}}**.

    1. On the **Endpoints** tab, click **Create endpoint**.

    1. In the **Direction** field, select `Target`.

    1. Enter a name for the endpoint. Use lowercase Latin letters and numbers.

    1. (Optional) Enter a description of the endpoint.

    1. In the **Database type** field, select the type of target that you want to transfer data to.

    1. Set the endpoint parameters:
        * [{#T}](#settings-clickhouse).
        * [{#T}](#settings-mongodb).
        * [{#T}](#settings-mysql).
        * [{#T}](#settings-storage).
        * [{#T}](#settings-postgresql).
        * [{#T}](#settings-yandex-database).

    1. Click **Create**.

{% endlist %}

## Changing an endpoint for a target {#update}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ data-transfer-name }}**.

    1. On the **Endpoints** tab, select the endpoint and click ![pencil](../../_assets/pencil.svg) **Edit** in the top panel.

    1. Edit the endpoint parameters:
        * [{#T}](#settings-clickhouse).
        * [{#T}](#settings-mongodb).
        * [{#T}](#settings-mysql).
        * [{#T}](#settings-storage).
        * [{#T}](#settings-postgresql).
        * [{#T}](#settings-yandex-database).

    1. Click **Apply**.

{% endlist %}

## Deleting an endpoint for the target {#delete}

{% include [delete-endpoint](../../_includes/data-transfer/delete-endpoint.md) %}

## Endpoint parameters for the target {#settings}

### {{ CH }} {#settings-clickhouse}

* **Connection type**: Selecting the type of DB connection:

    {% include [ClickHouse required settings](../../_includes/data-transfer/necessary-settings/clickhouse.md) %}

* Additional settings:

    * **ClickHouse cluster name**: Specify the name of the cluster that the data will be transferred to.

    * **Override table names**: Fill in if you need to rename source tables when transferring to the target database.

    * **Shard column**: The name of the column in tables that data will be [sharded](../../managed-clickhouse/concepts/sharding.md) by.

    * **Shard by transfer ID**: Data will be distributed across shards based on the transfer ID value.

        {% note warning %}

        If both the **Shard column** and **Shard by transfer ID** options are enabled, then the database is only sharded by the transfer ID.

        {% endnote %}

    * **Mapping shards**: If you shard by column values, map the values across the target cluster shards.

    * **Upload data in JSON format**: For optional values, default values will be used (if any). Enable this setting if the transfer connects to the target via the HTTP port rather than the native one.

    * **Write interval**: Specify the delay with which the data should arrive at the target cluster. Increase the value in this field if {{ CH }} fails to merge data parts.

    * {% include [Field Cleanup policy](../../_includes/data-transfer/fields/cleanup-policy-disabled-drop.md) %}

### {{ MG }} {#settings-mongodb}

* **Connection settings**: Selecting the type of DB connection:

    {% include [Required MongoDB settings](../../_includes/data-transfer/necessary-settings/mongodb.md) %}

* Additional settings:

    {% if audience != "internal" %}

    * {% include [Field Subnet ID](../../_includes/data-transfer/fields/subnet-id.md) %}
{% endif %}

    * **CA Certificate**: To encrypt transferred data, upload the [PEM certificate](../../managed-mongodb/operations/connect/index.md#get-ssl-cert) file or add its contents as text.

    * {% include [Field Cleanup policy](../../_includes/data-transfer/fields/cleanup-policy-disabled-drop-truncate.md) %}

        {% note warning %}

        By default, {{ data-transfer-name }} transfers collections without sharding. If you are transferring data to a sharded target cluster and want your collections to be sharded:

        1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#target-mg) to shard collections.

        1. Select `DISABLED` or `TRUNCATE` as your cleanup policy.

            Selecting the `DROP` policy will result in the service deleting all the data from the target database, including sharded collections, and replacing them with new unsharded ones when a transfer is activated.

        {% endnote %}

### {{ MY }} {#settings-mysql}

* **Connection settings**: Selecting the type of DB connection:

    {% include [Required MySQL settings](../../_includes/data-transfer/necessary-settings/mysql.md) %}

* Additional settings:

    * **sql_mod mode**: Specify the settings that override the [{{ MY }} standard behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

    * **Disable constraint checks**: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` settings are set to `0` (no checks are performed).

        {% note warning %}

        Disabling constraint checks will speed up replication but may affect data integrity when using cascading operations.

        {% endnote %}

    * {% include [Field Timezone](../../_includes/data-transfer/fields/timezone.md) %}

    * {% include [Field Cleanup policy](../../_includes/data-transfer/fields/cleanup-policy-disabled-drop-truncate.md) %}

### {{ objstorage-name }} {#settings-storage}

{% if audience != "internal" %}

* **Bucket**: The name of the [bucket](../../storage/concepts/bucket.md) that data from the source will be loaded to.

* **SA Account**: A [service account](../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role{% if product == "yandex-cloud" %} that you will access [{{ yds-full-name }}](../../data-streams/) as{% endif %}.

{% else %}

* **Bucket**: The name of the bucket to upload source data to.

* **SA Account**: The service account with the `storage.uploader` role{% if product == "yandex-cloud" %} that will be used to access [{{ yds-full-name }}](../../data-streams){% endif %}.

{% endif %}

* **Output format**: The format that data will be written to the bucket in: `JSON` or `CSV`.

* **Data layout pattern**: The path to the folder in the bucket where data will be saved.

* **File size**: Split data into files of the specified size.

* **Sending interval**: The interval for sending data to the bucket, in seconds.

* **Compression format**: Compression of output data: `GZIP` or `UNCOMPRESSED` (disabled).

### {{ PG }} {#settings-postgresql}

* **Connection settings**: Selecting the type of DB connection:

{% include [PostgreSQL required settings](../../_includes/data-transfer/necessary-settings/postgresql.md) %}

* Additional settings:

    {% if audience != "internal" %}

    * **Network interface for the endpoint**: Select or [create](../../vpc/operations/subnet-create.md) a subnet in the desired [availability zone](../../overview/concepts/geo-scope.md).

        If the source and target are geographically close, connecting over the selected subnet speeds up the transfer.

    {% endif %}

    * {% include [Field Cleanup policy](../../_includes/data-transfer/fields/cleanup-policy-disabled-drop-truncate.md) %}

    * Save transaction boundaries: Enable so that the service writes data to the target database only after fully reading the transaction data from the source database.

        {% note warning %}

        This feature is at the {% if audience != "internal" %}[Preview](../../overview/concepts/launch-stages.md){% else %}Preview{% endif %} stage.

        {% endnote %}

### {{ ydb-name }} {#settings-yandex-database}

To connect, set the required parameters:

{% include [necessary-settings](../../_includes/data-transfer/necessary-settings/ydb.md) %}

Additional settings:

* **Number of shards for traffic separation**: Specify the required `N` number of shards.

    If the setting is specified, the <q>_shard_col</q> column is added to tables. The values in it are calculated as the remainder of `H/N`, where `H` is the result of the hash function at the current time and `N` is the number of shards specified by the setting.

* **Table rotation**:

    * **Unit of measurement**: Hour, day, or month.

    * **Table size**: In the selected units of measurement.

        When the time interval equal to the selected unit of measurement ends, the oldest database table will be deleted and a new one will be created.

    * **Number of tables**: The required number of tables in the target database.

    * **Split by column**: Split (_partition_) a table by the column's values. The column must be of the <q>time</q> type.

        {% if audience != "internal" %}

        For more information about partitioning tables, see the [{{ ydb-full-name }}]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/datamodel/table#partitioning){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/datamodel/table#partitioning){% endif %} documentation.

        {% endif %}

    If this setting is used, the specified number of tables for data for different time intervals is created in the target database. The name of each table is selected automatically by the date and time of the start of the interval. Depending on the values in the specified column of the source table, the original rows are distributed across the corresponding tables in the target database.

* **Override table names**: Fill in if you need to rename tables in the source database when transferring to the target database.

* **Subfolder to host tables**: Specify a {% if audience != "internal" %}[subfolder]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/datamodel/dir){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/datamodel/dir){% endif %}{% else %}subfolder{% endif %} to host your tables.

    Final table placement path: `<Path in YDB>/<Subfolder>/<Table>`.

* {% include [Field Cleanup policy](../../_includes/data-transfer/fields/cleanup-policy-disabled-drop.md) %}

