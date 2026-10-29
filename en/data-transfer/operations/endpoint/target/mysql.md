---
title: How to set up a {{ MY }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ MY }} target endpoint in {{ data-transfer-full-name }}.
---

# Transferring data to a {{ MY }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ MY }} database and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ MY }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. [Perform the required database tasks](#db-actions) while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## {{ MY }} data transfer scenarios {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
  
   * [Migrating a {{ MY }} cluster](../../../tutorials/managed-mysql-to-mysql.md).
   * [Migration with change of storage from {{ PG }} to {{ MY }}](../../../tutorials/mpg-to-mmy.md).
   * [Migration with change of storage from {{ objstorage-name }} to {{ MY }}](../../../tutorials/objs-mmy-migration.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
  
   * [Delivering data from {{ KF }} to {{ MY }}](../../../tutorials/mkf-to-mmy.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ MY }}](../source/mysql.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [{{ ydb-name }}](../source/ydb.md)

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/mysql-prepare.md) %}

## Configuring the {{ MY }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mmy-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Optional settings](#additional-settings).

### {{ mmy-name }} cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mmy.viewer }}`](../../../../managed-mysql/security/index.md#mmy-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}


Connection to the database with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql.md) %}

- CLI {#cli}

    * Endpoint type: `mysql-target`.

    {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mysql_target`.

    {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-target.md) %}

    Configuration file structure example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        mysql_target {
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-target.md) %}

{% endlist %}

### Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql.md) %}

- CLI {#cli}

    * Endpoint type: `mysql-target`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-target.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mysql_target`.

    {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-target.md) %}

    Configuration file structure example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        mysql_target {
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-target.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% note warning %}

You can configure **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}** only via the management console.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}**: Select the pre-transfer cleanup policy for the target database:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only replicating data, without copying it.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Delete all tables included in the transfer. This is the default option.

          Use it to always transfer the latest table schemas on every transfer activation.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete data from the transferred tables, leaving the schema intact.

          Use this option if the target schema differs from the one that would be transferred from the source.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.timezone.title }}**: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. By default, the server local time zone is used.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.sql_mode.title }}**: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.skip_constraint_checks.title }}**: Used to speed up replication by setting `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` to `0` (no checks).

            {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}**: Specify the name of the schema where service tables needed for the transfer operation will be created.

    * {% include [alter-schema-change](../../../../_includes/data-transfer/fields/alter-schema-change.md) %}

- CLI {#cli}

    * `--sql-mode`: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

    * `--skip-constraint-checks`: Used to speed up replication by setting `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` to `0` (no checks).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `--timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

- {{ TF }} {#tf}

    * `sql_mode`: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html). The default list is `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`.

    * `skip_constraint_checks`: Used to speed up replication by setting `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` to `0` (no checks).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

    * {% include [alter-schema-change-tf](../../../../_includes/data-transfer/fields/alter-schema-change-tf.md) %}

- API {#api}

    * `sqlMode`: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

    * `skipConstraintChecks`: Used to speed up replication by setting `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` to `0` (no checks).

        {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

    * `timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

{% endlist %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Operations with the database during transfer {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## Mapping supported data types between DBMS and endpoint {#type-mapping}

#|
|| **{{ MY }} type** | **Endpoint type** ||
|| BIGINT | int64 ||
|| INT | int32 ||
|| SMALLINT | int16 ||
|| TINYINT | int8 ||
|| BIGINT | uint64 ||
|| INT | uint32 ||
|| SMALLINT | uint16 ||
|| TINYINT | uint8 ||
|| FLOAT | float ||
|| FLOAT | double ||
|| TEXT | string ||
|| TEXT | utf8 ||
|| BIT | boolean ||
|| DATE | date ||
|| TIMESTAMP | datetime ||
|| TIMESTAMP | timestamp ||
|| JSON | any ||
|#

## Data transfer troubleshooting {#troubleshooting}

Known issues when using a {{ MY }} endpoint:

* [Single transaction log size exceeds 4 GB](#binlog-size).
* [New tables are not added](#no-new-tables).
* [Error when transferring from AWS RDS for {{ MY }}](#aws-binlog-time).
* [Error when transferring tables without primary keys](#primary-keys).
* [Binary log access error](#binlog-bytes).
* [Unable to get a binary log position](#binlog-position)
* [Error when dropping a table under the Drop cleanup policy](#drop-table-error).
* [Time shift in the DATETIME data type when transferring to {{ CH }}](#timeshift).

For the full list of troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [binlog-size](../../../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [binlog-position](../../../../_includes/data-transfer/troubles/mysql/binlog-position.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
