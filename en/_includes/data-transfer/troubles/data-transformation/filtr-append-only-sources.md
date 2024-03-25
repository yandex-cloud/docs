### String filter for APPEND-ONLY sources is not working {#filtr-append-only-sources}

The [String filter for APPEND-ONLY sources](../../../../data-transfer/concepts/data-transformation.md#append-only-sources) transformer does not work when performing a transfer.

Possible causes include:

* If the column value type specified in the filter does not match the column type in the table, the transformer is not applied.

   **Resolution**: Specify column values that match the column type in the filtered table.

* If the filter includes a string column, the type of this column in the filtered table must be set to `UTF8` for those sources where a parser explicitly specifies column types (e.g., for {{ DS }}). The transformer does not support the `STRING` column type.

   **Resolution**: Specify the `UTF8` type for a string column in the filtered table.
