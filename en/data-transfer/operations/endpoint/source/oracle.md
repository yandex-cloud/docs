# Transferring data from an Oracle source endpoint

{{ data-transfer-full-name }} enables you to migrate data from an Oracle database and implement various scenarios of data transfer, processing and transformation. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the Oracle database](#prepare) for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from Oracle {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/oracle-prepare.md) %}

## Configuring the Oracle source endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure connection settings to Oracle.

The settings are given for a custom installation, where all fields are filled in manually.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise Oracle UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-oracle.md) %}

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md).
* [{{ CH }}](../target/clickhouse.md).
* [{{ GP }}](../target/greenplum.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).
