---
title: "How to configure a {{ metrika-endpoint }} source endpoint"
description: "Follow this guide to configure a {{ metrika-endpoint }} source endpoint."
noIndex: true
---

# Transferring data from a {{ metrika }} source endpoint


{{ data-transfer-name }} enables you to transfer data from a [{{ metrika }}]({{ metrika-link }}) tag to a {{ yandex-cloud }} managed database.

1. [Explore possible data transfer scenarios](#scenarios).
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the database and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from {{ metrika }} {#scenarios}

With {{ data-transfer-name }}, you can transfer data from a [{{ metrika }}]({{ metrika-link }}) tag to a {{ CH }} cluster. Such a transfer ensures the data transferred from {{ metrika }} are complete and allows:

* Processing data with {{ CH }} tools.
* Streaming data from {{ CH }} to other locations.
* Visualizing data using [{{ datalens-full-name }}]({{ link-datalens-main }}) or other services.

See [this tutorial](../../../tutorials/metrika-to-clickhouse.md) on how to transfer {{ metrika }} tag data to a {{ CH }} cluster.

For a detailed description of other possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the {{ metrika-endpoint }} source endpoint {#endpoint-settings}

{% include [note-metrica-pro](../../../../_includes/data-transfer/note-metrica-pro.md) %}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to [{{ metrika }}]({{ metrika-link }}).

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.counter_ids.title }}**: Specify the [numbers of the tags](https://yandex.ru/support/metrica/general/tag-id.html) the data will be coming from.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.token.title }}**: Specify the token required to access the tags. To obtain it, follow [this link](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.title }}**: Select whether information about hits should be transferred.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.columns.title }}**: Select the hit fields to export. In addition to the fields you select, there are certain mandatory fields that are always exported.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.title }}**: Select whether information about sessions (visits) should be transferred.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.columns.title }}**: Select the session fields to export. In addition to the fields you select, there are certain mandatory fields that are always exported.

{% endlist %}

For more information about the settings, see the [service documentation]({{ link-yandex }}/support/metrica/index.html).

## Configuring the data target {#supported-targets}

Configure the supported data target:

* [{{ CH }}](../target/clickhouse.md).

For a complete list of supported {{ data-transfer-full-name }} sources and targets, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}