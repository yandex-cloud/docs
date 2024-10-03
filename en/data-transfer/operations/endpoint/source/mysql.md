---
title: "How to set up a {{ MY }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to configure a {{ MY }} source endpoint when creating or modifying it in {{ data-transfer-full-name }}."
---
# Transferring data from a {{ MY }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a {{ MY }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ MY }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform the required operations with the database](#db-actions) and [see how the transfer is going](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ MY }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Migrating {{ MY }} clusters](../../../tutorials/managed-mysql-to-mysql.md).
    * [Migration with change of storage from {{ MY }} to {{ ydb-short-name }}](../../../tutorials/managed-mysql-to-ydb.md).
    * [Migration with change of storage from {{ MY }} to {{ PG }}](../../../tutorials/mmy-to-mpg.md).
    * [Migration with change of storage from {{ MY }} to {{ GP }}](../../../tutorials/mmy-to-mgp.md).

1. {% include [cdc](../../../../_includes/data-transfer/scenario-captions/cdc.md) %}

    * [{{ MY }} change data capture and delivery to {{ DS }}](../../../tutorials/mmy-to-yds.md).
    * [{{ MY }} change data capture and delivery to {{ KF }}](../../../tutorials/cdc-mmy.md).

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

    * [Loading data from {{ MY }} to the {{ CH }} data mart](../../../tutorials/mysql-to-clickhouse.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

    * [Loading {{ MY }} data to the {{ objstorage-name }} scalable storage](../../../tutorials/mmy-objs-migration.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/mysql-prepare.md) %}

## Configuring the {{ MY }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mmy-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ mmy-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mmy.viewer }}` role](../../../../managed-mysql/security/index.md#mmy-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-source.md) %}

- CLI {#cli}

    * Endpoint type: `mysql-source`.

    {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-source.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mysql_source`.

    {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-source.md) %}

    Here is an example of the configuration file structure:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        mysql_source {
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

    {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-source.md) %}

{% endlist %}

### Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-source.md) %}

- CLI {#cli}

    * Endpoint type: `mysql-source`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-source.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mysql_source`.

    {% include [On premise MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-source.md) %}

    Here is an example of the configuration file structure:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        mysql_source {
          security_groups = ["<list_of_security_group_IDs>"]
          connection {
            on_premise {
              hosts = ["<list_of_hosts>"]
              port  = <pot_for_connection>
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

    {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-source.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.table_filter.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**: Only data from the tables listed here will be transferred. This option is specified using regular expressions.

            {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred. This option is specified using regular expressions.

        Regular expressions for included and excluded tables must meet the ID naming rules in {{ MY }}. For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/identifiers.html). Escaping double quotes is not required.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.object_transfer_settings.title }}**: Allows you to select the DB schema elements that will be transferred when activating or deactivating a transfer.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.timezone.title }}**: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. By default, the server local time zone is used.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.service_database.title }}**: Database for dummy tables (`__tm_keeper` and `__tm_gtid_keeper`). By default, this is the source database the data is transferred from.

- CLI {#cli}

    * `--include-table-regex`: List of included tables. Only the data from the tables listed here will be transferred. This option is specified using regular expressions.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `--exclude-table-regex`: List of excluded tables. Data from the listed tables will not be transferred. This option is specified using regular expressions.

    * `--timezone`: DB time zone specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) ID. Defaults to UTC+0.

    * Schema transfer settings:
        * `--transfer-before-data`: When activating a transfer.
        * `--transfer-after-data`: When deactivating a transfer.

- {{ TF }} {#tf}

    * `include_table_regex`: List of included tables. Only the data from the tables listed here will be transferred. This option is specified using regular expressions.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `exclude_table_regex`: List of excluded tables. Data from the listed tables will not be transferred. This option is specified using regular expressions.

    * `timezone`: DB time zone specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) ID. Defaults to UTC+0.

    * `object_transfer_settings`: Schema transfer settings:

        * `view`: Views.
        * `routine`: Procedures and functions.
        * `trigger`: Triggers.

        You can specify one of the following values for each entity:

        * `BEFORE_DATA`: Transferring when activating the transfer.
        * `AFTER_DATA`: Transferring when deactivating the transfer.
        * `NEVER`: No tansfer.

- API {#api}

    * `includeTablesRegex`: List of included tables. Only the data from the tables listed here will be transferred. This option is specified using regular expressions.

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * `excludeTablesRegex`: List of excluded tables. Data from the listed tables will not be transferred. This option is specified using regular expressions.

    * `timezone`: DB time zone specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) ID. Defaults to UTC+0.

    * `objectTransferSettings`: Settings for transferring a DB schema when activating and deactivating a transfer (the `BEFORE_DATA` and `AFTER_DATA` values, respectively).

{% endlist %}

#### Settings for transferring a DB schema when enabling and disabling a transfer {#schema-migrations-settings}

During a transfer, the database schema is transferred from the source to the target. The transfer is performed in two stages:

1. At the activation stage.

    This step is performed before copying or replicating data to create a schema on the target. At this stage, you can enable the migration of views and stored procedures, stored functions, and triggers.

1. At the deactivation stage.

    This step is performed at the end of the transfer operation when it is deactivated. If the transfer keeps running in replication mode, the final stage of the transfer will be performed only when replication stops. At this stage, you can enable the migration of views and stored procedures, stored functions, and triggers.

    At the final stage, it is assumed that when the transfer is deactivated, there is no writing load on the source. You can ensure this by switching to read-only mode. At this stage, the database schema on the target is brought to a state where it will be consistent with the schema on the source.

### Known limitations {#known-limitations}

If setting up a transfer from a {{ MY }} cluster to a {{ CH }} cluster, consider these aspects of transferring [date and time data types]({{ my.docs }}/refman/8.0/en/date-and-time-types.html):

* `TIME` type data is transferred as strings with the source and target time zones ignored.
* When transferring `TIMESTAMP` type data, the time zone set in the {{ MY }} source settings or [advanced endpoint settings](#additional-settings) is used. For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/datetime.html).
* The source endpoint assigns the UTC+0 time zone to data of the `DATETIME` type.

Transfers from {{ MY }} to a database of a different type do not support fields of the `DECIMAL` type to prevent loss of data accuracy. There is no such limitation for {{ MY }}-to-{{ MY }} transfers.

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

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Operations with the database during transfer {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## Troubleshooting data transfer issues {#troubleshooting}

Known issues when using a {{ MY }} endpoint:

* [Single transaction log size exceeds 4 GB](#binlog-size).
* [New tables are not added](#no-new-tables).
* [Error when transferring from AWS RDS for {{ MY }}](#aws-binlog-time).
* [Error when transferring tables without primary keys](#primary-keys).
* [Binary log access error](#binlog-bytes).
* [Error when dropping a table under the Drop cleanup policy](#drop-table-error).
* [Time shift in the DATETIME data type when transferring to {{ CH }}](#timeshift).

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [binlog-size](../../../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}

{% include [greenplum-trademark](../../../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
