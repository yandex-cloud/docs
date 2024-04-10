---
title: "How to configure a {{ MY }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ MY }} target endpoint in {{ data-transfer-full-name }}."
---
# Transferring data to a {{ MY }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to a {{ MY }} database and implement various scenarios of data transfer, processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ MY }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform required operations with the database](../../../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ MY }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migrating a {{ MY }} cluster](../../../tutorials/managed-mysql-to-mysql.md).
* [Migration with change of storage: {{ PG }} to {{ MY }}](../../../tutorials/mpg-to-mmy.md).
* [Migration with change of storage: {{ objstorage-name }} to {{ MY }}](../../../tutorials/objs-mmy-migration.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

* [Delivering data from {{ KF }} to {{ MY }}](../../../tutorials/mkf-to-mmy.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md).
* [{{ MY }}](../source/mysql.md).
* [{{ objstorage-full-name }}](../source/object-storage.md).
* [{{ KF }}](../source/kafka.md).
* [Airbyte](../../../transfer-matrix.md#airbyte).
* [{{ DS }}](../source/data-streams.md).
* [{{ ydb-name }}](../source/ydb.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/mysql-prepare.md) %}

## Configuring the {{ MY }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmy-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ mmy-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mmy.viewer }}` role](../../../../managed-mysql/security/index.md#mmy-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-target.md) %}

- CLI {#cli}

   * Endpoint type: `mysql-target`.

   {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-target.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `mysql_target`.

   {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-target.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       mysql_target {
         security_groups = ["<list_of_security_group_IDs>"]
         connection {
           mdb_cluster_id = "<cluster_ID>"
         }
         database = "<migrated_database_name>"
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

   {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-target.md) %}

{% endlist %}

### Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-target.md) %}

- CLI {#cli}

   * Endpoint type: `mysql-target`.

   {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-target.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `mysql_target`.

   {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-target.md) %}

   Here is an example of the configuration file structure:

   
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
         database = "<migrated_database_name>"
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

   {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-target.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% note warning %}

You can configure **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}** only via the management console.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`: Select this option if you are only going to do replication without copying data.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`: Completely delete tables included in the transfer (used by default).

         Use this option so that the latest version of the table schema is always transferred to the target database from the source whenever the transfer is activated.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`: Delete only the data from the tables included in the transfer but leave the schema.

         Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.timezone.title }}**: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. By default, the server local time zone is used.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.sql_mode.title }}**: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.skip_constraint_checks.title }}**: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and the `UNIQUE_CHECKS` values are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}**: Specify the name of the schema where service tables needed for the transfer operation will be created.

- CLI {#cli}

   * `sql_mode`: Specify the settings that override the [{{ MY }} standard behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

   * `--skip-constraint-checks`: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` settings are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * `--timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

- {{ TF }} {#tf}

   * `sql_mode`: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html). The following list is used by default: `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`.

   * `skip_constraint_checks`: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and the `UNIQUE_CHECKS` values are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * `timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

   * `sqlMode`: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

   * `skipConstraintChecks`: Used to speed up replication: the `FOREIGN_KEY_CHECKS `and `UNIQUE_CHECKS` settings are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * `timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Operations with the database during transfer {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mysql-work-with-db.md) %}

## Troubleshooting data transfer issues {#troubleshooting}

Known issues when using a {{ MY }} endpoint:

* [Single transaction log size exceeds 4 GB](#binlog-size).
* [New tables are not added](#no-new-tables).
* [Error when transferring from AWS RDS for {{ MY }}](#aws-binlog-time).
* [Error when transfering tables without primary keys](#primary-keys).
* [Binary log access error](#binlog-bytes).
* [Error when dropping a table under the Drop cleanup policy](#drop-table-error).
* [Time shift in the DATETIME data type when transferring to {{ CH }}](#timeshift).

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [binlog-size](../../../../_includes/data-transfer/troubles/mysql/binlog-size.md) %}

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [aws-binlog-time](../../../../_includes/data-transfer/troubles/mysql/aws-binlog-time.md) %}

{% include [primary-keys](../../../../_includes/data-transfer/troubles/primary-keys.md) %}

{% include [binlog-bytes](../../../../_includes/data-transfer/troubles/mysql/binlog-bytes.md) %}

{% include [drop-table-error](../../../../_includes/data-transfer/troubles/drop-table-error.md) %}

{% include [timezone-shift](../../../../_includes/data-transfer/troubles/mysql/timezone-shift.md) %}