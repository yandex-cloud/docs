# Unknown referenced column

`ERR.DS_API.FORMULA.TRANSLATION.UNKNOWN_FIELD`

This error occurs in calculated fields and in fields with a specified aggregation type under the following circumstances:

* The connection in a dataset is replaced.
* A dataset in a chart is replaced.
* A field is deleted from a dataset (provided that the deleted field is used in calculated fields or aggregations).

This occurs because formulas use field IDs (GUIDs) instead of field names. When replacing a connection or a dataset, a field with the same name will have a different ID.

To correct this error, recreate the calculated fields.

