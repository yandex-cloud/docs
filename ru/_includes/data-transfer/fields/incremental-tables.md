**{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.incremental_tables.title }}** — укажите таблицы, копирование данных которых осуществляется не полностью, а с места, где копирование завершилось в прошлый раз: укажите значения полей **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_namespace.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.table_name.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_column.title }}** и (опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.IncrementalTable.key_start_value.title }}**. Подробнее см. в разделе [Периодическое инкрементальное копирование](../../../data-transfer/concepts/regular-incremental-copy.md).

{% note info %}

Это эффективнее, чем копировать таблицы целиком, но менее эффективно, чем использовать тип трансфера _{{ dt-type-copy-repl }}_. Настройка доступна для источников {{ PG }}, {{ CH }} и Airbyte.

{% endnote %}