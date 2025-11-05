---
title: Transferring data from a {{ ytsaurus-name }} source endpoint
description: Follow this guide to set up a data transfer from a {{ ytsaurus-name }} source endpoint.
---

# Transferring data from a {{ ytsaurus-name }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from {{ ytsaurus-name }} tables to managed databases and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform the required operations with the database and [see how the transfer is going](../../monitoring.md).

## Scenarios for transferring data from {{ ytsaurus-name }} {#scenarios}

You can implement scenarios for loading data from tables into {{ yandex-cloud }} managed databases for storage in the cloud, processing, and loading into data marts for visualization.

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the {{ myt-name }} source endpoint {#endpoint-settings}


When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to the [{{ myt-name }} cluster](#cluster):


{% list tabs group=instructions %}

- Management console {#console}

    
    {% include [UI settings](../../../../_includes/data-transfer/fields/yt/ui/main-settings.md) %}


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yt.console.form.yt.YTSource.paths.title }}**: Paths to data tables. To add a new path, click **+ {{ ui-key.yc-data-transfer.data-transfer.console.form.yt.console.form.yt.YTTarget.path.title }}** and enter the value.

{% endlist %}


## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

