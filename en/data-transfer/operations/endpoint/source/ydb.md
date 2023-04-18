# Configuring source endpoints {{ ydb-name }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:
* {{ ydb-full-name }} DB connection settings. These are required parameters.
* The transfer path list (for tables and directories).

## Settings {#settings}

{% list tabs %}

- Management console

  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/database-name.md) %}


  * {% include [YDB UI](../../../../_includes/data-transfer/fields/ydb/ui/service-account.md) %}


  * **Included paths list**: Add paths to the {{ ydb-name }} tables and directories to transfer.

    Adding new paths when editing an endpoint used in {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will not result in uploading the data history of these tables. To add a table with its historical data, use the **List of objects to transfer** field in the [transfer settings](../../transfer.md#update).

    For {{ dt-type-copy }} transfers, you may skip specifying paths. In this case, all tables will be transferred.

    For {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfers, specifying paths is required, including when you replicate all tables.

{% endlist %}
