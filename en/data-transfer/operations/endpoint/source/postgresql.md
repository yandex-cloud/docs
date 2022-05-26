# Source endpoint parameters {{ PG }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* Settings of [{{ mpg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise), including one based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mpg-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mpg-name }}](../../../../managed-postgresql/).

{% list tabs %}

- Management console

   {% include [Managed PostgreSQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI

   * Endpoint type: `postgres-source`.

   {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}

- Terraform

   * Endpoint type: `postgres_source`.

   {% include [Managed PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-postgresql.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       postgres_source {
         connection {
           mdb_cluster_id = "<{{ mpg-name }} cluster ID>"
         }
         database = "<name of database to transfer>"
         user     = "<username for connection>"
         password {
           raw = "<user password>"
         }
         <advanced endpoint settings>
       }
     }
   }
   ```

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with an explicitly specified network address and port.

{% list tabs %}

- Management console

   {% include [On premise PostgreSQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI

   * Endpoint type: `postgres-source`.

   {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- Terraform

   * Endpoint type: `postgres_source`.

   {% include [On premise PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-postgresql.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       postgres_source {
         connection {
           on_premise {
             hosts = ["<host list>"]
             port  = <connection port>
           }
         }
         database = "<name of database to transfer>"
         user     = "<username for connection>"
         password {
           raw = "<user password>"
         }
         <advanced endpoint settings>
       }
     }
   }
   ```

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **List of included tables**. Data is only transferred from listed tables.
   * **Blacklist of tables**. Data from blacklisted tables isn't transferred.

      Both lists support expressions in the following format:
      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the specified schema.
      * `<table name>`: Table in the default schema.

   * **Replication slot name**: Enter the ID of the PostgreSQL replication slot used to connect to the DB cluster.

   * **Maximum WAL size per replication slot**: Maximum size of the write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. By default, not limited.

   * **DB schema for service tables**: Enter a name for the storage schema.

   * **Merge inherited tables**: Select to merge the contents of tables.

   * Settings for transferring the schema at the initial and final stages of the transfer.

- CLI

   * `--include-table`: List of included tables. Data is only transferred from listed tables.
   * `--exclude-table`: List of excluded tables. Data from blacklisted tables isn't transferred.

      Both lists support expressions in the following format:

      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the specified schema.
      * `<table name>`: Table in the default schema.

   * `--slot-lag-limit`: Maximum size of the write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. By default, not limited.

   * `--service-schema`: Name of the DB schema for service tables.

   * Schema transfer settings:

      * `--transfer-before-data`: At the initial stage of the transfer.
      * `--transfer-after-data`: At the final stage of the transfer.

- Terraform

   * `include_tables`: List of included tables. Data is only transferred from listed tables.
   * `exclude_tables`: List of excluded tables. Data from tables on this list will not be transferred.

      Both lists support expressions in the following format:

      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the schema.

   * `slot_gigabyte_lag_limit`: Maximum size of Write-Ahead Log kept in replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. By default, not limited.

   * `service_schema`: DB schema name for service tables.

   * `object_transfer_settings`: Schema transfer settings:

      * `sequence`: Sequences.
      * `sequence_owned_by`: User sequences.
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
      * `collation`: Collation rules.
      * `policy`: Policies.
      * `cast`: Type casts.

      You can specify one of the following values for each entity:

      * `BEFORE_DATA`: Move at transfer activation.
      * `AFTER_DATA`: Move at transfer deactivation.
      * `NEVER`: Do not move.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   * `includeTables`: List of included tables. Data is only transferred from listed tables.

   * `excludeTables`: Blacklist of tables. Data from blacklisted tables isn't transferred.

      Both lists support expressions in the following format:

      * `<schema name>.<table name>`: Fully qualified table name.
      * `<schema name>.*`: All tables in the specified schema.
      * `<table name>`: Table in the default schema.

   * `slotByteLagLimit`: Maximum size of the write-ahead log kept in the replication slot. If exceeded, the replication process is stopped and the replication slot is deleted. By default, not limited.

   * `serviceSchema`: Name of the DB schema for service tables.

   * `objectTransferSettings`: Settings for transferring the schema at the initial and final stages of the transfer (`BEFORE_DATA` and `AFTER_DATA` values, respectively).

{% endlist %}

### Settings for transferring a DB schema when enabling and disabling a transfer {#schema-migrations-settings}

{% note info %}

The default settings of the source endpoint let you successfully perform a transfer for most databases. Change the settings of the initial and final stages of the transfer only if it is necessary.

{% endnote %}

During a transfer, the database schema is transferred from the source to the target. The transfer is performed in two stages:

1. At the activation stage.

   This step is performed when the transfer is activated before copying or replicating data to create a schema on the target. You can choose which parts of the schema will be migrated. By default, this is `TABLE`, `VIEW`, `PRIMARY KEY`, `SEQUENCE`, `SEQUENCE OWNED BY`, `RULE`, `TYPE`, `FUNCTION`, and `DEFAULT`.

1. At the deactivation stage.

   This step is performed at the end of the transfer operation when it is deactivated. If the transfer keeps running in replication mode, the final stage of the transfer will be performed only when replication stops. You can choose which parts of the schema will be migrated.

   At the final stage, it is assumed that when the transfer is deactivated, there is no writing load on the source. You can ensure this by switching to <q>read-only</q> mode. At this stage, the database schema on the target is brought to a state where it will be consistent with the schema on the source.

   It's recommended to include resource-intensive operations like index migration in the final stage of migration. Migrating indexes at the beginning of the transfer can slow it down.

The transfer of the schema at both the initial and final stages is performed using the `pg_dump` [utility](https://www.postgresql.org/docs/current/app-pgdump.html).

{% note info %}

When the transfer is restarted at the replication stage, the table schemas on the target are preserved. In this case, only the schemas of the tables that are missing on the target at the time of restart are transferred to the target.

{% endnote %}

Replication can't guarantee that sequence values are preserved, so we recommend updating the `sequences` on the target.
