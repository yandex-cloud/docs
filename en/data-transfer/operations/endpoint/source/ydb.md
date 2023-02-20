# Configuring {{ ydb-name }} source endpoint

{% if audience == "external" %}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:
* The {{ ydb-full-name }} database and [service account](../../../../iam/concepts/users/service-accounts.md) to access it.
* The transfer path list (for tables and directories).

## Settings {#settings}

{% list tabs %}

- Management console

   {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

   * **Included paths list**: Add paths to the {{ ydb-name }} tables and directories to transfer.

      Adding new paths when editing an endpoint used in {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will not result in uploading the data history of these tables. To add a table with its historical data, use the **List of objects to transfer** field in the [transfer settings](../../transfer.md#update).

      If no path is specified, all tables will be transferred.

{% endlist %}

{% endif %}
