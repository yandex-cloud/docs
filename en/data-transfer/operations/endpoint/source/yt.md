---
title: How to set up a YTsaurus source endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to configure a YTsaurus source endpoint when creating or modifying it in {{ data-transfer-full-name }}.
---

# Transferring data from a {{ ytsaurus-name }} source endpoint


{{ data-transfer-full-name }} enables you to migrate data from {{ ytsaurus-name }} tables to managed databases and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. Perform the required operations with the database and [see how the transfer is going](../../monitoring.md).

## {{ ytsaurus-name }} data transfer scenarios {#scenarios}

You can implement scenarios for loading data from tables into {{ yandex-cloud }} managed databases for storage in the cloud, processing, and loading into data marts for visualization.

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the {{ myt-name }} source endpoint {#endpoint-settings}


When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to the [{{ myt-name }} cluster](#cluster):


{% list tabs group=instructions %}

- Management console {#console}

    
    {% include [UI settings](../../../../_includes/data-transfer/fields/yt/ui/main-settings.md) %}


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yt.console.form.yt.YTSource.paths.title }}**: Paths to data tables. To add a new path, click **+ {{ ui-key.yc-data-transfer.data-transfer.console.form.yt.console.form.yt.YTTarget.path.title }}** and enter the value.

{% endlist %}


## Configuring the target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

