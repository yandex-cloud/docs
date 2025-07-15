---
title: How to set up a {{ PG }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to configure a {{ PG }} source endpoint when creating or modifying it in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ PG }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a {{ PG }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ PG }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform the required operations with the database](#db-actions) and [see how the transfer is going](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ PG }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Migrating a {{ PG }}](../../../tutorials/managed-postgresql.md) cluster.
    * [Migrating from AWS RDS for {{ PG }}](../../../tutorials/rds-to-mpg.md).
    * [Migration with change of storage from {{ PG }} to {{ ydb-short-name }}](../../../tutorials/mpg-to-ydb.md).
    * [Migration with change of storage from {{ PG }} to {{ MY }}](../../../tutorials/mpg-to-mmy.md).
    * [Migration with change of storage from {{ PG }} to {{ OS }}](../../../tutorials/postgresql-to-opensearch.md).

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}

    * [Capturing changes from {{ PG }} and delivering to {{ DS }}](../../../tutorials/mpg-to-yds.md).
    * [Capturing changes from {{ PG }} and delivering to {{ KF }}](../../../tutorials/cdc-mpg.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ PG }} to the {{ CH }} data mart](../../../tutorials/rdbms-to-clickhouse.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

    * [Loading {{ PG }} data to the {{ objstorage-name }} scalable storage](../../../tutorials/mpg-to-objstorage.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/pg-prepare.md) %}

## Configuring the {{ PG }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mpg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

Before you get started, check the [Service specifics for {{ PG }} sources and targets](../../../concepts/work-with-endpoints.md#postgresql).

### {{ mpg-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mpg.viewer }}`](../../../../managed-postgresql/security/index.md#mpg-viewer) role or the [`viewer`](../../../../iam/roles-reference.md#viewer) primitive role assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed PostgreSQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI {#cli}

    * Endpoint type: `postgres-source`.

    {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `postgres_source`.

    {% include [Managed PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-postgresql.md) %}

    Here is an example of the configuration file structure:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        postgres_source {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            mdb_cluster_id = "<cluster_ID>"
          }
          database = "<name_of_database_to_migrate>"
          user     = "<username_for_connection>"
          password {
            raw = "<user_password>"
          }
          <additional_endpoint_settings>
        }
      }
    }
    ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

### Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise PostgreSQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI {#cli}

    * Endpoint type: `postgres-source`.

    {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `postgres_source`.

    {% include [On premise PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-postgresql.md) %}

    Here is an example of the configuration file structure:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        postgres_source {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            on_premise {
              hosts = ["<list_of_hosts>"]
              port  = <port_for_connection>
            }
          }
          database = "<name_of_database_to_migrate>"
          user     = "<username_for_connection>"
          password {
            raw = "<user_password>"
          }
          <additional_endpoint_settings>
        }
      }
    }
    ```


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.table_filter.title }}**: 
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}**: Only data from the tables listed here will be transferred.

            {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

      The lists include the name of the [schema]({{pg-docs}}/ddl-schemas.html) that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

        * `<schema_name>.<table_name>`: Full table name.
        * `<schema_name>.*`: All tables in the specified schema.

      Table names must match this regular expression:

      ```text
      ^"?[-_a-zA-Z0-9.]+"?\\."?[$-_a-zA-Z0-9.*]+"?$
      ```

      Double quotes within a table name are not supported. Outer quotes are only used as delimiters and will be deleted when processing paths.

      {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.object_transfer_settings.title }}**: If required, select the DB schema elements to transfer when activating or deactivating a transfer.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.slot_byte_lag_limit.title }}**: Maximum size of write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. The default value is 50 GB. This setting does not prevent disk overflow in the source database. You can only use it for {{ PG }} version below 13, and we recommend [monitoring the WAL slot value](../../prepare.md#source-pg) in the source database.
          
            {% note warning %}

            The **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.slot_byte_lag_limit.title }}** setting does not guarantee replication slot deletion when its threshold value is reached, particularly if there are issues with the transfer or connectivity between the transfer and the source cluster. For additional tips, see [Preparing the source database](#wal-setup-recommendation).  

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.service_schema.title }}**: Specify the name of the schema to store service tables (`__consumer_keeper` and `__data_transfer_mole_finder`).

        The schema name must match this regular expression:

        ```text
        ^[-_a-zA-Z0-9]*$
        ```

        Double quotes are not supported in schema names.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.collapse_inherit_table.title }}**: Select to merge the contents of tables. For more information, see [Specifics of working with endpoints](../../../concepts/work-with-endpoints.md#postgresql).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.snapshot_table_sharding_settings.title }}**: If required, specify detailed settings for parallel copying of tables (if parallel copying parameters are set in the transfer).

- CLI {#cli}

    * `--include-table`: List of included tables. Only the data from the tables listed here will be transferred.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `--exclude-table`: List of excluded tables. Data from the listed tables will not be transferred.

      The lists include the name of the schema that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

        * `<schema_name>.<table_name>`: Full table name.
        * `<schema_name>.*`: All tables in the specified schema.

        {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * `--slot-lag-limit`: Maximum size of write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. The default value is 50 GB.

    * `--service-schema`: Name of the DB schema for service tables.

    * Schema transfer settings:

        * `--transfer-before-data`: At the initial stage of the transfer.
        * `--transfer-after-data`: At the final stage of the transfer.

- {{ TF }} {#tf}

    * `include_tables`: List of included tables. Only the data from the tables listed here will be transferred.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `exclude_tables`: List of excluded tables. Data from the listed tables will not be transferred.

      The lists include the name of the schema that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

      * `<schema_name>.<table_name>`: Full table name.
      * `<schema_name>.*`: All tables in the specified schema.

      {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * `slot_gigabyte_lag_limit`: Maximum size of write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. The default value is 50 GB.

    * `service_schema`: Name of the DB schema for service tables.

    * `object_transfer_settings`: Schema transfer settings:

        * `sequence`: Sequences.
        * `sequence_owned_by`: Custom sequences.
        * `table`: Tables.
        * `primary_key`: Primary keys.
        * `fk_constraint`: Foreign keys.
        * `default_values`: Default values.
        * `constraint`: Constraints.
        * `index`: Indexes.
        * `view`: Views.
        * `function`: Functions.
        * `trigger`: Triggers.
        * `type`: Types.
        * `rule`: Rules.
        * `collation`: Sorting rules.
        * `policy`: Policies.
        * `cast`: Type casts.

        You can specify one of the following values for each entity:

        * `BEFORE_DATA`: Transferring when activating the transfer.
        * `AFTER_DATA`: Transferring when deactivating the transfer.
        * `NEVER`: No tansfer.

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `includeTables`: List of included tables. Only the data from the tables listed here will be transferred.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `excludeTables`: List of excluded tables. Data from the listed tables will not be transferred.

      The lists include the name of the schema that describes the DB contents, structure, and integrity constraints, as well as the table name. Both lists support expressions in the following format:

        * `<schema_name>.<table_name>`: Full table name.
        * `<schema_name>.*`: All tables in the specified schema.

        {% include [transfer custom types PGSQL](../../../../_includes/data-transfer/custom-types-pgsql.md) %}

    * `slotByteLagLimit`: Maximum size of write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. The default value is 50 GB.

    * `serviceSchema`: Name of the DB schema for service tables.

    * `objectTransferSettings`: Settings for transferring the schema at the initial and final stages of the transfer (`BEFORE_DATA` and `AFTER_DATA`, respectively).

{% endlist %}

#### Settings for transferring a DB schema when enabling and disabling a transfer {#schema-migrations-settings}

{% note info %}

The default settings of the source endpoint allow you to successfully perform a transfer for most databases. Change the settings of the initial and final stages of the transfer only if it is necessary.

{% endnote %}

During a transfer, the database schema is transferred from the source to the target. The transfer is performed in two stages:

1. At the activation stage.

    This step is performed when the transfer is activated before copying or replicating data to create a schema on the target. You can choose which parts of the schema will be migrated. By default, these are: `TABLE`, `VIEW`, `PRIMARY KEY`, `SEQUENCE`, `SEQUENCE OWNED BY`, `RULE`, `TYPE`, `FUNCTION`, and `DEFAULT`.

1. At the deactivation stage.

    This step is performed at the end of the transfer operation when it is deactivated. If the transfer keeps running in replication mode, the final stage of the transfer will be performed only when replication stops. You can choose which parts of the schema will be migrated.

    At the final stage, it is assumed that when the transfer is deactivated, there is no writing load on the source. You can ensure this by switching to <q>read-only</q> mode. At this stage, the database schema on the target is brought to a state where it will be consistent with the schema on the source.

    It is recommended to include resource-intensive operations, e.g., index migration, in the final stage of migration. Migrating indexes at the beginning of the transfer can slow it down.

To transfer the schema at both the initial and final stages, one uses the [`pg_dump`](https://www.postgresql.org/docs/current/app-pgdump.html) utility.

{% note info %}

When editing the settings of an endpoint of the transfer in the {{ dt-status-repl }} status, the table schemas on the target are preserved. In this case, only the table schemas that are missing on the target at the transfer restart will be transferred to the target.

{% endnote %}

Replication cannot guarantee that sequence values are preserved, so we recommend updating the `sequence` on the target.

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md)
* [{{ MY }}](../target/mysql.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ objstorage-full-name }}](../target/object-storage.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)
* [{{ ES }}](../target/elasticsearch.md)
* [{{ OS }}](../target/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Operations with the database during transfer {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) %}

## Troubleshooting data transfer issues {#troubleshooting}

Known issues when using a {{ PG }} endpoint:

* [Stopping a transfer's master transaction session](#master-trans-stop).
* [Exceeding the connection time-to-live quota](#conn-duration-quota).
* [VIEW transfer error](#view).
* [Error when adding a table entry by constraint](#constraint).
* [Error when migrating all schema tables](#schema).
* [Unable to create objects involving extension functions](#extension-functions).
* [Low transfer speed](#low-speed).
* [Unable to transfer child tables](#successor-tables).
* [Insufficient replication slots in a source database](#replication-slots).
* [No data transfer after changing a source endpoint](#no-data-transfer).
* [Transfer error when changing a master host](#master-change).
* [Error when transferring nested transactions](#inner-tables).
* [Error transferring tables with deferred constraints](#deferrable-constr).
* [Cannot create a replication slot at the activation step](#lock-replication).
* [Excessive WAL size increase](#excessive-wal).
* [Error when replicating from an external source](#external-replication).
* [Error when transferring tables without primary keys](#primary-keys).
* [Duplicate key violates a unique constraint](#duplicate-key)
* [Error when dropping a table under the Drop cleanup policy](#drop-table-error).
* [Error when transferring tables with generated columns](#generated-columns)

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [master-trans-stop](../../../../_includes/data-transfer/troubles/postgresql/master-trans-stop.md) %}

{% include [conn-duration-quota](../../../../_includes/data-transfer/troubles/postgresql/conn-duration-quota.md) %}

{% include [view](../../../../_includes/data-transfer/troubles/postgresql/view.md) %}

{% include [constraint](../../../../_includes/data-transfer/troubles/postgresql/constraint.md) %}

{% include [schema](../../../../_includes/data-transfer/troubles/postgresql/schema.md) %}

{% include [extension functions](../../../../_includes/data-transfer/troubles/postgresql/extension-functions.md) %}

{% include [low-speed](../../../../_includes/data-transfer/troubles/postgresql/low-speed.md) %}

{% include [successor-tables](../../../../_includes/data-transfer/troubles/postgresql/successor-tables.md) %}

{% include [replication-slots](../../../../_includes/data-transfer/troubles/postgresql/replication-slots.md) %}

{% include [no-data-transfer](../../../../_includes/data-transfer/troubles/postgresql/no-data-transfer.md) %}

{% include [master-change](../../../../_includes/data-transfer/troubles/postgresql/master-change.md) %}

{% include [inner-tables](../../../../_includes/data-transfer/troubles/postgresql/inner-tables.md) %}

{% include [deferrable-tables](../../../../_includes/data-transfer/troubles/postgresql/deferrable-constraints.md) %}

{% include [lock-replication](../../../../_includes/data-transfer/troubles/postgresql/lock-replication.md) %}

{% include [excessive-wal](../../../../_includes/data-transfer/troubles/postgresql/excessive-wal.md) %}

{% include [external-replication](../../../../_includes/data-transfer/troubles/postgresql/external-replication.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [duplicate-key](../../../../_includes/data-transfer/troubles/duplicate-key.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [generated-columns](../../../../_includes/data-transfer/troubles/generated-columns.md) %}
