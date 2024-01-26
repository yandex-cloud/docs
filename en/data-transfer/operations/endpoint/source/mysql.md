---
title: "How to configure a {{ MY }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ MY }} source endpoint in {{ data-transfer-full-name }}."
---

# Configuring {{ MY }} source endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmy-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mmy-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mmy.viewer }}` role](../../../../managed-mysql/security/index.md#mmy-viewer) or the [`viewer` primitive role](../../../../iam/concepts/access-control/roles.md#viewer) assigned to the folder where this managed database cluster resides.

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

   {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-source.md) %}

{% endlist %}

## Custom installation {#on-premise}

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

   {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-source.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}**: Data is only transferred from listed tables. This option is specified using regular expressions.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred. This option is specified using regular expressions.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.object_transfer_settings.title }}**: Allows you to select the DB schema elements that will be transferred when activating or deactivating a transfer.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.timezone.title }}**: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. By default, the server local time zone is used.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.service_database.title }}**: Database for dummy tables (`__tm_keeper` and `__tm_gtid_keeper`). By default, this is the source database the data is transferred from.

- CLI {#cli}

   * `--include-table-regex`: List of included tables. If this is on, the data will only be transferred from the tables in this list. This option is specified using regular expressions.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * `--exclude-table-regex`: List of excluded tables. Data from the listed tables will not be transferred. This option is specified using regular expressions.

   * `--timezone`: DB time zone, specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * Schema transfer settings:
      * `--transfer-before-data`: When activating transfer.
      * `--transfer-after-data`: When deactivating transfer.

- {{ TF }} {#tf}

   * `include_table_regex`: List of included tables. If this is on, the data will only be transferred from the tables in this list. This option is specified using regular expressions.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * `exclude_table_regex`: List of excluded tables. Data from the listed tables will not be transferred. This option is specified using regular expressions.

   * `timezone`: DB time zone, specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * `object_transfer_settings`: Schema transfer settings:

      * `view`: Views.
      * `routine`: Procedures and functions.
      * `trigger`: Triggers.

      You can specify one of the following values for each entity:

      * `BEFORE_DATA`: Move when activating the transfer.
      * `AFTER_DATA`: Move when deactivating the transfer.
      * `NEVER`: Do not move.

- API {#api}

   * `includeTablesRegex`: List of included tables. If this is on, the data will only be transferred from the tables in this list. This option is specified using regular expressions.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * `excludeTables`: List of excluded tables. Data from the listed tables will not be transferred. This option is specified using regular expressions.

   * `timezone`: DB time zone, specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * `objectTransferSettings`: Settings for transferring a DB schema when activating and deactivating a transfer (`BEFORE_DATA` and `AFTER_DATA` values, respectively).

{% endlist %}

### Settings for transferring a DB schema when enabling and disabling a transfer {#schema-migrations-settings}

During a transfer, the database schema is transferred from the source to the target. The transfer is performed in two stages:

1. At the activation stage.

   This step is performed before copying or replicating data to create a schema on the target. At this stage, you can enable the migration of views and stored procedures, stored functions, and triggers.

1. At the deactivation stage.

   This step is performed at the end of the transfer operation when it is deactivated. If the transfer keeps running in replication mode, the final stage of the transfer will be performed only when replication stops. At this stage, you can enable the migration of views and stored procedures, stored functions, and triggers.

   At the final stage, it is assumed that when the transfer is deactivated, there is no writing load on the source. You can ensure this by switching to <q>read-only</q> mode. At this stage, the database schema on the target is brought to a state where it will be consistent with the schema on the source.

## Known limitations {#known-limitations}

If you are setting up a transfer from a {{ MY }} cluster, use the cluster master server. During its operation, the transfer creates service tables in the source database. Therefore, you cannot use a {{ MY }} replica as a source, because it is read-only.

If you are setting up a transfer from a {{ MY }} cluster to a {{ CH }} cluster, consider the way the data of [date and time types]({{ my.docs }}/refman/8.0/en/date-and-time-types.html) gets transferred:

* Data of the `TIME` type is transferred as strings with the source and target time zones ignored.
* When transferring data of the `TIMESTAMP` type, the time zone set in the {{ MY }} source settings or [advanced endpoint settings](#additional-settings) is used. For more information, see the [{{ MY }} documentation]({{ my.docs }}/refman/8.0/en/datetime.html).
* The source endpoint assigns the UTC+0 time zone to data of the `DATETIME` type.

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
