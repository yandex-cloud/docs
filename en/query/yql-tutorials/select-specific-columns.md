# Selecting data from specific columns

You can fetch data from all columns as well as from their their subsets. You can also rename existing columns and create new ones.

For example:

* Select data from the `age`, `last_visit_time`, and `region` columns.
* Rename `region` to `area`.
* Change the `release_date` column type from `Int32` to `DateTime`.

```sql
SELECT
    VendorID,                           -- List column names (VendorID, trip_distance)
    trip_distance,                      -- separated by commas.
    fare_amount AS fare,                -- You can use AS to rename columns
    (total_amount/1000) AS total_amount_thousand_dollars, -- or give a name to any expression.
    CAST(VendorID as Uint32) AS vendorID -- Use CAST to change data type.
FROM
    `tutorial-analytics`
LIMIT 10
```

View the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select) operator
* [YQL data types]({{ ydb.docs }}/yql/reference/types/)
* [Type casting in YQL]({{ ydb.docs }}/yql/reference/types/cast)
* [Functions for dates]({{ ydb.docs }}/yql/reference/udf/list/datetime)
