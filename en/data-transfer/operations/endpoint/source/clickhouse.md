---
title: How to set up a {{ CH }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to create and configure an {{ CH }} source endpoint in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ CH }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a {{ CH }} database and implement various transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Prepare the {{ CH }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. [Perform the required database tasks](#db-actions) while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## {{ CH }} data transfer scenarios {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migrating a {{ CH }} cluster](../../../tutorials/managed-clickhouse.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare clickhouse_db](../../../../_includes/data-transfer/endpoints/sources/clickhouse-prepare.md) %}

## Configuring the {{ CH }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mch-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Optional settings](#additional-settings).

### {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mch.viewer }}`](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}


Connection to the database with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse-source.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-source`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse-source.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_source`.

    {% include [Managed ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse-source.md) %}

    Configuration file structure example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        clickhouse_source {
          clickhouse_cluster_name="<shard_group>"
          security_groups = ["<list_of_security_group_IDs>"]
          subnet_id       = "<subnet_ID>"
          connection {
            connection_options {
              mdb_cluster_id = "<cluster_ID>"
              database       = "<name_of_database_to_migrate>"
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse-source.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connection to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-source`.

    {% include [On premise ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse-source.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_source`.

    {% include [On premise ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse-source.md) %}

    Configuration file structure example:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        clickhouse_source {
          clickhouse_cluster_name="<cluster_name>"
          security_groups = ["<list_of_security_group_IDs>"]
          subnet_id       = "<subnet_ID>"
          connection {
            connection_options {
              on_premise {
                http_port   = "<HTTP_connection_port>"
                native_port = "<port_for_native_interface_connection>"
                shards {
                  name  = "<shard_name>"
                  hosts = [ "list of IP addresses and FQDNs of shard hosts" ]
                }
                tls_mode {
                  enabled {
                    ca_certificate = "<certificate_in_PEM_format>"
                  }
                }
              }
              database = "<name_of_database_to_migrate>"
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse-source.md) %}

{% endlist %}

### Table filter {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * {% include [include_tables](../../../../_includes/data-transfer/fields/clickhouse/ui/include-tables.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [exclude_tables](../../../../_includes/data-transfer/fields/clickhouse/ui/exclude-tables.md) %}

    The names of the tables you include or exclude must follow {{ CH }} identifier naming rules. For more information, see [this {{ CH }} guide]({{ ch.docs }}{{ lang }}/sql-reference/syntax#syntax-identifiers). Double quote escaping is not required.

    To transfer all tables, leave the lists empty.

- CLI {#cli}

    * {% include [include-table](../../../../_includes/data-transfer/fields/clickhouse/cli/include-table.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [exclude-table](../../../../_includes/data-transfer/fields/clickhouse/cli/exclude-table.md) %}

    If no lists are specified, the system will transfer data from all tables.

- {{ TF }} {#tf}

    * {% include [include_tables](../../../../_includes/data-transfer/fields/clickhouse/terraform/include-tables.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [exclude_tables](../../../../_includes/data-transfer/fields/clickhouse/terraform/exclude-tables.md) %}

    If no lists are specified, the system will transfer data from all tables.

- API {#api}

    * {% include [includeTables](../../../../_includes/data-transfer/fields/clickhouse/api/include-tables.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [excludeTables](../../../../_includes/data-transfer/fields/clickhouse/api/exclude-tables.md) %}

    If no lists are specified, the system will transfer data from all tables.

{% endlist %}

## Configuring the target {#supported-targets}

Configure the target endpoint:

* [{{ ytsaurus-name }}](../source/yt.md)
* [{{ CH }}](../target/clickhouse.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Mapping supported data types between DBMS and endpoint {#type-mapping}

#|
|| **{{ CH }} type** | **Endpoint type** ||
|| Int64 | int64 ||
|| Int32 | int32 ||
|| Int16 | int16 ||
|| Int8 | int8 ||
|| UInt64 | uint64 ||
|| UInt32 | uint32 ||
|| UInt16 | uint16 ||
|| UInt8 | uint8 ||
|| — | float ||
|| Float64 | double ||
|| FixedString
String | string ||
|| Enum16
Enum8
IPv4
IPv6 | utf8 ||
|| — | boolean ||
|| Date | date ||
|| DateTime | datetime ||
|| DateTime64 | timestamp ||
|| REST... | any ||
|#

## Data transfer troubleshooting {#troubleshooting}

* [New tables are not added](#no-new-tables).
* [Data is not transferred](#no-transfer).
* [Date range is not supported](#date-range).

For the full list of recommendations, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/clickhouse/no-new-tables.md) %}

{% include [date-range](../../../../_includes/data-transfer/troubles/clickhouse/date-range.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
