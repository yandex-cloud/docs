`paths`: List of paths to the {{ ydb-name }} tables or directories to transfer.

  Table and directory names must meet the ID naming rules in {{ ydb-short-name }}. Escaping double quotes is not required. The `/` character is used as a path delimiter. For more information, see the [{{ ydb-short-name }}]({{ ydb.docs }}/concepts/connect#database) documentation.

  For {{ dt-type-repl }} or {{ dt-type-copy-repl }} transfers, specifying paths is required, including when you replicate all tables. For {{ dt-type-copy }} transfers, you may skip specifying paths. In this case, all tables will be transferred.

  Adding new paths when editing an endpoint used in {{ dt-type-copy-repl }} transfers in the {{ dt-status-repl }} status will not result in uploading the data history of these tables. To add a table with its historical data, use the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** field in the [transfer settings](../../../../../data-transfer/operations/transfer.md#update).
