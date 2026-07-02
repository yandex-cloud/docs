# Selecting specific columns

You can select all or only specific columns. You can also rename existing columns and create new ones.

For example:

* Select columns `age`, `last_visit_time`, and `region`.
* Rename `region` to `area`.
* Change `release_date` data type from `Int32` to `DateTime`.

```sql
SELECT
    VendorID,                           -- Column names
    trip_distance,                      -- separated by commas.
    fare_amount AS fare,                -- You can use AS to rename columns.
    (total_amount/1000) AS total_amount_thousand_dollars, -- You can use AS to name any expression.
    CAST(VendorID as Uint32) AS vendorID -- You can convert data types using CAST.
FROM
    `tutorial-analytics`
LIMIT 10
```

Check the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
The query result will appear in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or chart.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select) operator
* [YQL data types]({{ ydb.docs }}/yql/reference/types/)
* [Type casting in YQL]({{ ydb.docs }}/yql/reference/types/cast)
* [Functions for dates]({{ ydb.docs }}/yql/reference/udf/list/datetime)
