### Unsupported date range {#date-range}

If the migrated data contains dates outside the supported ranges, {{ CH }} returns the following error:

```text
TYPE_ERROR [target]: failed to run (abstract1 source): failed to push items from 0 to 1 in batch:
Push failed: failed to push 1 rows to ClickHouse shard 0:
ClickHouse Push failed: Unable to exec changeItem: clickhouse:
dateTime <field_name> must be between 1900-01-01 00:00:00 and 2262-04-11 23:47:16
```

Supported date ranges in {{ CH }}:

* For the `DateTime64` type fields: 1900-01-01 to 2299-12-31. For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/data-types/datetime64).
* For the `DateTime` type fields: 1970-01-01 to 2106-02-07. For more information, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/data-types/datetime).

**Solution**: use one of the following options:

* Convert all dates in the source DB to a range supported by {{ CH }}.
* In the [source endpoint parameters](../../../data-transfer/operations/endpoint/index.md#update), exclude the table with incorrect dates from the transfer.
* In the [transfer parameters](../../../data-transfer/operations/transfer.md#update), specify the [{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.convert_to_string.title }}](../../../data-transfer/concepts/data-transformation.md#convert-to-string) transformer. This will change the field type during the transfer.
