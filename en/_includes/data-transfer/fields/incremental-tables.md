**{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.incremental_tables.title }}**: Specify the tables whose data is copied incrementally, i.e., from where the copy process stopped previously; set values for the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_namespace.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_name.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_column.title }}**, and **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_start_value.title }}** (optional) fields. For more information, see [Regular incremental copy](../../../data-transfer/concepts/regular-incremental-copy.md).

{% note info %}

This is more efficient than copying entire tables but less efficient than using transfers of the _{{ dt-type-copy-repl }}_ type. This setting is available for such sources as {{ PG }}, {{ CH }}, and Airbyte.

{% endnote %}