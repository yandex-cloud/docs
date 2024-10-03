---
title: How to set up a {{ CH }} source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to configure a {{ CH }} source endpointwhen creating or modifying it in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ CH }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from a {{ CH }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ CH }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform the required operations with the database](#db-actions) and [see how the transfer is going](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ CH }} {#scenarios}

{% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

* [Migrating a {{ CH }} cluster](../../../tutorials/managed-clickhouse.md).
* [Redistributing data across shards](../../../tutorials/mch-mch-resharding.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare clickhouse_db](../../../../_includes/data-transfer/endpoints/sources/clickhouse-prepare.md) %}

## Configuring the {{ CH }} source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

### {{ mch-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mch.viewer }}` role](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse-source.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-source`.

    {% include [Managed ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-clickhouse-source.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_source`.

    {% include [Managed ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse-source.md) %}

    Here is an example of the configuration file structure:


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


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/managed-clickhouse-source.md) %}

{% endlist %}

### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- CLI {#cli}

    * Endpoint type: `clickhouse-source`.

    {% include [On premise ClickHouse CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-clickhouse-source.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `clickhouse_source`.

    {% include [On premise ClickHouse {{ TF }}](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse-source.md) %}

    Here is an example of the configuration file structure:


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
                  hosts = [ “list of IP addresses and FQDNs of shard hosts" ]
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


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise ClickHouse API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-clickhouse-source.md) %}

{% endlist %}

### Table filter {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * {% include [include_tables](../../../../_includes/data-transfer/fields/clickhouse/ui/include-tables.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [exclude_tables](../../../../_includes/data-transfer/fields/clickhouse/ui/exclude-tables.md) %}

    Included and excluded table names must meet the ID naming rules in {{ CH }}. For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/syntax#syntax-identifiers). Escaping double quotes is not required.

    Leave the lists empty to transfer all the tables.

- CLI {#cli}

    * {% include [include-table](../../../../_includes/data-transfer/fields/clickhouse/cli/include-table.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [exclude-table](../../../../_includes/data-transfer/fields/clickhouse/cli/exclude-table.md) %}

    If no lists are specified, data from all tables will be transferred.

- {{ TF }} {#tf}

    * {% include [include_tables](../../../../_includes/data-transfer/fields/clickhouse/terraform/include-tables.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [exclude_tables](../../../../_includes/data-transfer/fields/clickhouse/terraform/exclude-tables.md) %}

    If no lists are specified, data from all tables will be transferred.

- API {#api}

    * {% include [includeTables](../../../../_includes/data-transfer/fields/clickhouse/api/include-tables.md) %}

        {% include [Description for Included tables](../../../../_includes/data-transfer/fields/description-included-tables.md) %}

    * {% include [excludeTables](../../../../_includes/data-transfer/fields/clickhouse/api/exclude-tables.md) %}

    If no lists are specified, data from all tables will be transferred.

{% endlist %}

## Configuring the data target {#supported-targets}

Configure the target endpoint:

* [{{ CH }}](../target/clickhouse.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

* [New tables cannot be added](#no-new-tables).
* [Data cannot be transferred](#no-transfer)

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [no-new-tables](../../../../_includes/data-transfer/troubles/no-new-tables.md) %}

{% include [table-names](../../../../_includes/data-transfer/troubles/table-names.md) %}

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
