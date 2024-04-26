---
title: "How to configure a {{ CH }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ CH }} source endpoint in {{ data-transfer-full-name }}."
---

# Transferring data from a {{ CH }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a {{ CH }} database and implement various scenarios of data transfer, processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ CH }}](#prepare) database for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform required operations with the database](#db-actions) and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ CH }} {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migrating the {{ CH }} cluster](../../../tutorials/managed-clickhouse.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare clickhouse_db](../../../../_includes/data-transfer/endpoints/sources/clickhouse-prepare.md) %}

## Configuring the {{ CH }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mch.viewer }}` role](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- CLI {#cli}

   * Endpoint type: `clickhouse-source`.

   {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `clickhouse_source`.

   {% include [Managed ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       clickhouse_source {
         security_groups = ["<list_of_security_group_IDs>"]
         subnet_id       = "<subnet_ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<cluster_ID>"
             database       = "<migrated_database_name>"
             user           = "<username_for_connection>"
             password {
               raw = "<user_password>"
             }
           }
         }
         <additional_endpoint_settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

   {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI {#cli}

   * Endpoint type: `clickhouse-source`.

   {% include [On premise ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `clickhouse_source`.

   {% include [On premise ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       clickhouse_source {
         security_groups = ["<list_of_security_group_IDs>"]
         subnet_id       = "<subnet_ID>"
         connection {
           connection_options {
             on_premise {
               http_port   = "<port_for_HTTP_connections>"
               native_port = "<port_for_connecting_to_native_interface>"
               shards {
                 name  = "<shard_name>"
                 hosts = [ "list_of_IP_addresses_or_FQDN_hosts_of_the_shard" ]
               }
               tls_mode {
                 enabled {
                   ca_certificate = "<PEM_certificate>"
                 }
               }
             }
             database = "<migrated_database_name>"
             user     = "<username_for_connection>"
             password {
               raw = "<user_password>"
             }
           }
         }
         <additional_endpoint_settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

   {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse.md) %}

{% endlist %}

### Table filter {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTableFilter.include_tables.title }}**: Data is only transferred from listed tables.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTableFilter.exclude_tables.title }}**: Data from the listed tables is not transferred.

   The lists include the name of the schema (description of DB contents, structure, and integrity constraints) and the table name. Both lists support expressions in the following format:

   * `<schema_name>.<table_name>`: Fully qualified table name.
   * `<schema_name>.*`: All tables in the specified schema.
   * `<table_name>`: Table in the default schema.

   Included and excluded table names must meet the ID naming rules in {{ CH }}. For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/syntax#syntax-identifiers). Escaping double quotes is not required.

   Leave the lists empty to transfer all the tables.

- {{ TF }} {#tf}

   * `include_tables`: List of included tables. If this is on, the data will only be transferred from the tables in this list.

      {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

   * `exclude_tables`: List of excluded tables. Data from the listed tables will not be transferred.

   The lists include the name of the schema (description of DB contents, structure, and integrity constraints) and the table name. Both lists support expressions in the following format:

   * `<schema_name>.<table_name>`: Fully qualified table name.
   * `<schema_name>.*`: All tables in the specified schema.
   * `<table_name>`: Table in the default schema.

{% endlist %}

### Known limitations {#known-limitations}

Transfers will fail if {{ CH }} source tables contain the following types of columns:

| Type | Error example |
|---------------------|-------------------------------------------------------------------|
| `Int128` | `unhandled type Int128` |
| `Int256` | `unhandled type Int256` |
| `UInt128` | `unhandled type UInt128` |
| `UInt256` | `unhandled type UInt256` |
| `Bool` | `unhandled type Bool` |
| `Date32` | `unhandled type Date32` |
| `JSON` | `unhandled type '<field_name> <type_name>'` |
| `Array(Date)` | `Can't transfer type 'Array(Date)', column '<column_name>'` |
| `Array(DateTime)` | `Can't transfer type 'Array(DateTime)', column '<column_name>'` |
| `Array(DateTime64)` | `Can't transfer type 'Array(DateTime64)', column '<column_name>'` |
| `Map(,)` | `unhandled type Map(<type_name>, <type_name>)` |

#### Supported table types {#known-limitations-table-types}

If a {{ CH }} cluster is multi-host, you can transfer tables and materialized views based on `ReplicatedMergeTree` or `Distributed` engines only. Moreover, these tables and views must be present in all cluster hosts.

If the list of included tables contains tables or views with other engines or they are missing in some cluster hosts, a transfer will fail with an error saying `the following tables have not Distributed or Replicated engines and are not yet supported`.

#### Database names {#known-limitations-db-names}

{{ data-transfer-full-name }} cannot transfer a {{ CH }} database if its name contains a hyphen.

## Configuring the data target {#supported-targets}

Configure the target endpoint:

* [{{ CH }}](../target/clickhouse.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [New tables are not added](#no-new-tables)
* [Data is not transferred](#no-transfer)

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [table-names](../../../../_includes/data-transfer/troubles/table-names.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
