# Configuring {{ ydb-name }} source endpoint

{% if audience == "external" %}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:
* The {{ ydb-full-name }} database and [service account](../../../../iam/concepts/users/service-accounts.md) to access it.
* The transfer path list (for tables and directories).

## Settings {#settings}

{% list tabs %}

- Management console

   {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

   * **Included paths list**: Add paths to the {{ ydb-name }} tables and directories to transfer. If no path is specified, all the tables will be transferred.

{% endlist %}

{% endif %}
