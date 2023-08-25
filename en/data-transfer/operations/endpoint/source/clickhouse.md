---
title: "How to configure a {{ CH }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ CH }} source endpoint in {{ data-transfer-full-name }}."
---

# Configuring {{ CH }} source endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mch-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mch-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Management console

   {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI

   * Endpoint type: `clickhouse-source`.

   {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- {{ TF }}

   * Endpoint type: `clickhouse_source`.

   {% include [Managed ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

   Example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       clickhouse_source {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<{{ mch-name }} cluster ID>"
             database       = "<name of database to transfer>"
             user           = "<username to connect>"
             password {
               raw = "<user password>"
             }
           }
         }
         <advanced endpoint settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse.md) %}

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI

   * Endpoint type: `clickhouse-source`.

   {% include [On premise ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- {{ TF }}

   * Endpoint type: `clickhouse_source`.

   {% include [On premise ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

   Example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       clickhouse_source {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             on_premise {
               http_port   = "<HTTP connection port>"
               native_port = "<native interface connection port>"
               shards {
                 name  = "<shard name>"
                 hosts = [ "shard host IP or FQDN list" ]
               }
               tls_mode {
                 enabled {
                   ca_certificate = "<certificate in PEM format>"
                 }
               }
             }
             database = "<name of database being transferred>"
             user     = "<username for connection>"
             password {
               raw = "<user password>"
             }
           }
         }
         <advanced endpoint settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTableFilter.include_tables.title }}**: Data is only transferred from listed tables.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

   The lists include the name of the schema (description of DB contents, structure, and integrity constraints) and the table name. Both lists support expressions in the following format:

   * `<schema name>.<table name>`: Fully qualified table name.
   * `<schema name>.*`: All tables in the specified schema.
   * `<table name>`: Table in the default schema.

   Leave the lists empty to transfer all the tables.

- {{ TF }}

   * `include_tables`: List of included tables. If this is on, the data will only be transferred from the tables in this list.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * `exclude_tables`: List of excluded tables. Data from tables on this list will not be transmitted.

   The lists include the name of the schema (description of DB contents, structure, and integrity constraints) and the table name. Both lists support expressions in the following format:

   * `<schema name>.<table name>`: Fully qualified table name.
   * `<schema name>.*`: All tables in the specified schema.
   * `<table name>`: Table in the default schema.

{% endlist %}

## Known limitations {#known-limitations}

Transfers will fail if {{ CH }} source tables contain the following types of columns:

| Type | Error example |
|---------------------|-------------------------------------------------------------------|
| `Int128` | `unhandled type Int128` |
| `Int256` | `unhandled type Int256` |
| `UInt128` | `unhandled type UInt128` |
| `UInt256` | `unhandled type UInt256` |
| `Bool` | `unhandled type Bool` |
| `Date32` | `unhandled type Date32` |
| `JSON` | `unhandled type '<field name> <type name>'` |
| `Array(Date)` | `Can't transfer type 'Array(Date)', column '<column name>'` |
| `Array(DateTime)` | `Can't transfer type 'Array(DateTime)', column '<column name>'` |
| `Array(DateTime64)` | `Can't transfer type 'Array(DateTime64)', column '<column name>'` |
| `Map(,)` | `unhandled type Map(<type name>, <type name>)` |

### Supported table types {#known-limitations-table-types}
If a {{ CH }} cluster is multi-host, you can transfer tables and materialized views based on `ReplicatedMergeTree` or `Distributed` engines only. Moreover, these tables and views must be present in all cluster hosts.

If the list of included tables contains tables or views with other engines or they're missing in some cluster hosts, a transfer will fail with an error saying `the following tables have not Distributed or Replicated engines and are not yet supported`.

### Database names {#known-limitations-db-names}

{{ data-transfer-full-name }} cannot transfer a {{ CH }} database if its name contains a hyphen.

