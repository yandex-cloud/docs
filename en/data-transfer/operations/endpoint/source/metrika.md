---
title: "How to configure a {{ metrika-endpoint }} source endpoint"
description: "Follow this guide to configure a {{ metrika-endpoint }} source endpoint."
noIndex: true
---

# Configuring {{ metrika-endpoint }} source endpoints

{% include [note-metrica-pro](../../../../_includes/data-transfer/note-metrica-pro.md) %}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to [{{ metrika }}]({{ metrika-link }}).

## Settings {#settings}

{% list tabs %}

- Management console

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.counter_ids.title }}**: Specify the [numbers of the tags](https://yandex.ru/support/metrica/general/tag-id.html) the data will be coming from.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.token.title }}**: Specify the token required to access the tags. To obtain it, follow [this link](https://oauth.yandex.ru/authorize?response_type=token&client_id=36b7fc9aa96c4fa09158bcacbbdc796a).
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.title }}**: Select whether information about hits should be transferred.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.hits.columns.title }}**: Select the hit fields to export. In addition to the fields you select, there are certain mandatory fields that are always exported.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.title }}**: Select whether information about sessions (visits) should be transferred.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.metrika.console.form.metrika.MetrikaSource.visits.columns.title }}**: Select the session fields to export. In addition to the fields you select, there are certain mandatory fields that are always exported.

{% endlist %}

For more information about the settings, see the [service documentation]({{ link-yandex }}/support/metrica/index.html).

See [this tutorial](../../../tutorials/metrika-to-clickhouse.md) on how to transfer {{ metrika }} tag data to a {{ CH }} cluster.

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}