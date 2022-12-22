---
title: "How to configure {{ MY }} source endpoints in {{ data-transfer-full-name }}"
description: "Following this guide you will learn how to configure {{ MY }} source endpoints in {{ data-transfer-full-name }}."
---

# Configuring a {{ MY }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmy-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mmy-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmy-full-name }}](../../../../managed-mysql/).

{% list tabs %}

- Management console

   {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-source.md) %}

- CLI

   * Endpoint type: `mysql-source`.

   {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-source.md) %}

- {{ TF }}

   * Endpoint type: `mysql_source`.

   {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-source.md) %}

   Example configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mysql_source {
         security_groups = [ "list of security group IDs" ]
         connection {
           mdb_cluster_id = "<{{ mmy-name }} cluster ID>"
         }
         database = "<name of database being transferred>"
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

   {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-source.md) %}

{% endlist %}

## Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs %}

- Management console

   {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-source.md) %}

- CLI

   * Endpoint type: `mysql-source`.

   {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-source.md) %}

- {{ TF }}

   * Endpoint type: `mysql_source`.

   {% include [On premise MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-source.md) %}

   Example configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mysql_source {
         security_groups = [ "list of security group IDs" ]
         connection {
           on_premise {
             hosts = ["<host list>"]
             port  = <connection port>
           }
         }
         database = "<name of database being transferred>"
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

   {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-source.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **List of included tables**. Data is only transferred from listed tables. It is set using regular expressions.

   * **Blacklist of tables**. Data from blacklisted tables isn't transferred. It is set using regular expressions.

   * **DB time zone**, specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * Settings for transferring a DB schema when enabling and disabling a transfer.

- CLI

   * `--include-table-regex`: List of included tables. Data is only transferred from listed tables. It is set using regular expressions.

   * `--exclude-table-regex`: Blacklist of tables. Data from blacklisted tables isn't transferred. It is set using regular expressions.

   * `--timezone`: DB time zone, specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * Schema transfer settings:
      * `--transfer-before-data`: When activating transfer.
      * `--transfer-after-data`: When deactivating transfer.

- {{ TF }}

   * `include_table_regex`: List of included tables. Data is only transferred from listed tables. It is set using regular expressions.

   * `exclude_table_regex`: List of excluded tables. Data from tables on this list will not be transmitted. It is set using regular expressions.

   * `timezone`: DB time zone, specified as an [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * `object_transfer_settings`: Schema transfer settings:

      * `view`: Views.
      * `routine`: Procedures and functions.
      * `trigger`: Triggers.

      You can specify one of the following values for each entity:

      * `BEFORE_DATA`: Move at transfer activation.
      * `AFTER_DATA`: Move at transfer deactivation.
      * `NEVER`: Do not move.

- API

   * `includeTablesRegex`: List of included tables. Data is only transferred from listed tables. It is set using regular expressions.

   * `excludeTablesRegex`: Blacklist of tables. Data from blacklisted tables isn't transferred. It is set using regular expressions.

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

If you are setting up a transfer from a {{ MY }} cluster, use the cluster master server. During its operation, the transfer creates service tables in the source database. Therefore, you can't use a {{ MY }} replica as a source, because it is read-only.