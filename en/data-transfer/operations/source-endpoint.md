# Managing a source endpoint

[Endpoints](../concepts/index.md#endpoint) for the source describe the settings of the database that information will be transferred from using {{ data-transfer-name }}. You can [create](#create), [update](#update), or [delete](#delete) this kind of endpoint.

## Creating a source endpoint {#create}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ data-transfer-name }}**.

    1. On the **Endpoints** tab, click **Create endpoint**.

    1. In the **Direction** field, select `Source`.

    1. Enter a name for the endpoint. Use lowercase Latin letters and numbers.

    1. (Optional) enter a description of the endpoint.

    1. In the **Database type** field, select the type of source to transfer data from.

    1. Set the endpoint parameters:
        * [Apache Kafka®](#settings-kafka).
        * [{#T}](#settings-clickhouse).
        * [{#T}](#settings-mongodb).
        * [{#T}](#settings-mysql).
        * [{#T}](#settings-oracle);
        * [{#T}](#settings-postgresql).
        * [{#T}](#settings-yds).

    1. Click **Create**.

{% endlist %}

## Updating a target endpoint {#update}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ data-transfer-name }}**.

    1. On the **Endpoints** tab, select the endpoint and click ![pencil](../../_assets/pencil.svg) **Edit** in the top panel.

    1. Edit the endpoint parameters:
        * [Apache Kafka®](#settings-kafka).
        * [{#T}](#settings-clickhouse).
        * [{#T}](#settings-mongodb).
        * [{#T}](#settings-mysql).
        * [{#T}](#settings-oracle);
        * [{#T}](#settings-postgresql).
        * [{#T}](#settings-yds).

    1. Click **Apply**.

{% endlist %}

## Deleting a source endpoint {#delete}

{% include [How to delete endpoint](../../_includes/data-transfer/delete-endpoint.md) %}

## Source endpoint parameters {#settings}

### {{ CH }} {#settings-clickhouse}

* **Connection settings**: Selecting the type of DB connection:

    {% include [ClickHouse required settings](../../_includes/data-transfer/necessary-settings/clickhouse.md) %}

* Additional settings:
    * **Included tables**: Data is only transferred from listed tables. It is set using regular expressions.
    * **Excluded tables**: Data from the listed tables is not transferred. It is set using regular expressions.

    Both lists support expressions in the following format:
    * `<schema name>.<table name>`: Fully qualified table name.
    * `<schema name>.*`: All tables in the specified schema.
    * `<table name>`: Table in the default schema.

### {{ KF }} {#settings-kafka}

* **Connection**: Selecting the type of connection to the topic:

    {% include [Apache Kafka required settings](../../_includes/data-transfer/necessary-settings/kafka.md) %}

* Additional settings:

    {% include [KF-YDS additional settings](../../_includes/data-transfer/kf-yds-additional-settings.md) %}

### {{ MG }} {#settings-mongodb}

* **Connection settings**: Selecting the type of DB connection:

    {% include [MongoDB required settings](../../_includes/data-transfer/necessary-settings/mongodb.md) %}

* Additional settings:
    * **List of included collections**: Data is only transferred from listed collections. All collections are transferred by default.
    * **List of excluded collections**: Data is transferred from all collections except the specified ones.

    If a source is experiencing high workload (over 10000 write transactions per second), we recommend that you select these settings to have no more than ten different databases at each endpoint. This will help avoid database connection errors while the transfer is ongoing.

    {% note info %}

    If you use several endpoints, you need to create a separate transfer for each one.

    {% endnote %}
    * {% include [Field Subnet ID](../../_includes/data-transfer/fields/subnet-id.md) %}

### {{ MY }} {#settings-mysql}

* **Connection settings**: Selecting the type of DB connection:

    {% include [MySQL required settings](../../_includes/data-transfer/necessary-settings/mysql.md) %}

* Additional settings:

  * **List of included tables**: Data is only transferred from listed tables. It is set using regular expressions.

  * **List of excluded tables**: Data from these listed tables is not transferred. It is set using regular expressions.

  * {% include [Field Timezone](../../_includes/data-transfer/fields/timezone.md) %}

  * Settings for transferring the DB schema when activating and deactivating a transfer.

    During a transfer, the database schema is transferred from the source to the target. The transfer is performed in two stages:

    1. At the activation stage.

        This step is performed before copying or replicating data to create a schema on the target. At this stage, you can enable the migration of views and stored procedures and functions.

        {% include [triggers-stop](../../_includes/data-transfer/triggers-limit.md) %}

    1. At the deactivation stage.

        This step is performed at the end of the transfer operation when it is deactivated. If the transfer keeps running in replication mode, the final stage of the transfer will be performed only when replication stops. At this stage, you can enable the migration of views and stored procedures, stored functions, and triggers.

        At the final stage, it is assumed that when the transfer is deactivated, there is no writing load on the source. You can ensure this by switching to the <q>read-only</q> mode. At this stage, the database schema on the target is aligned with the schema on the source.

### Oracle {#settings-oracle}

{% include [Oracle required settings](../../_includes/data-transfer/necessary-settings/oracle.md) %}

### {{ PG }} {#settings-postgresql}

* **Connection settings**: Selecting the type of DB connection:

   {% include [PostgreSQL required settings](../../_includes/data-transfer/necessary-settings/postgresql.md) %}

* Additional settings:

  * **List of included tables**: Data is only transferred from listed tables. It is set using regular expressions.

  * **List of excluded tables**: Data from these listed tables is not transferred. It is set using regular expressions.

      Both lists support expressions in the following format:
      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the specified schema.
      * `<table name>`: Table in the default schema.

  * **Replication slot name**: Enter the ID of the {{ PG }} replication slot used to connect to the DB cluster.

  * **Maximum WAL size per replication slot**: Maximum size of the write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. By default, not limited.

  * **DB schema for service tables**: Enter a name for the storage schema.

  * **Merge inherited tables**: Select to merge the contents of tables.

  * Settings for transferring the schema at the initial and final stages of the transfer.

    {% note info %}

    The default settings of the source endpoint let you successfully perform a transfer for most databases. Change the settings of the initial and final stages of the transfer only if it is necessary.

    {% endnote %}

    During a transfer, the database schema is transferred from the source to the target. The transfer is performed in two stages:

    1. At the activation stage.

        This step is performed when the transfer is activated before copying or replicating data to create a schema on the target. You can choose which parts of the schema will be migrated. By default, this is `TABLE`, `VIEW`, `PRIMARY KEY`, `SEQUENCE`, `SEQUENCE OWNED BY`, `RULE`, `TYPE`, `FUNCTION`, and `DEFAULT`.

        {% include [triggers-stop](../../_includes/data-transfer/triggers-limit.md) %}

    1. At the deactivation stage.

        This step is performed at the end of the transfer operation when it is deactivated. If the transfer keeps running in replication mode, the final stage of the transfer will be performed only when replication stops. You can choose which parts of the schema will be migrated.

        At the final stage, it is assumed that when the transfer is deactivated, there is no writing load on the source. You can ensure this by switching to <q>read-only</q> mode. At this stage, the database schema on the target is aligned with the schema on the source.

        It's recommended to include resource-intensive operations like index migration in the final stage of migration. Migrating indexes at the beginning of the transfer can slow it down.

    The transfer of the schema at both the initial and final stages is performed using [`pg_dump`](https://www.postgresql.org/docs/current/app-pgdump.html).

    {% note info %}

    When the transfer is restarted at the replication stage, the table schemas on the target are preserved. In this case, only the schemas of the tables that are missing on the target at the time of restart are transferred to the target.

    {% endnote %}

    Replication can't guarantee that sequence values are preserved, so we recommend updating the `sequences` on the target.

{% if product == "yandex-cloud" %}

### {{ yds-full-name }} {#settings-yds}

To connect, set the required parameters:

* **Database**: Select a {{ ydb-full-name }} DB registered in [{{ yds-full-name }}](../../data-streams/) as a source.

* **Stream**: Specify the name of the data stream associated with the database.

* **SA Account**: Select or [create](../../iam/operations/sa/create.md) [a service account](../../iam/concepts/users/service-accounts.md) that {{ data-transfer-name }} will connect to the data source as.

* Additional settings:

    {% include [KF-YDS additional settings](../../_includes/data-transfer/kf-yds-additional-settings.md) %}

{% endif %}
