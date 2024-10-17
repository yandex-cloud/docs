# Selecting data from specific columns

You can fetch data from all columns as well as from their their subsets. You can also rename existing columns and create new ones.

For example:

* Select data from the `age`, `last_visit_time`, and `region` columns.
* Rename `region` to `area`.
* Update the `release_date` column type from `Int32` to `DateTime`

```sql
SELECT
    VendorID,                           -- Column names (VendorID, trip_distance)
    trip_distance,                      -- are separated by commas.
    fare_amount AS fare,                -- Using AS, you can rename columns
    (total_amount/1000) AS total_amount_thousand_dollars, -- or name an arbitrary expression,
    CAST(VendorID as Uint32) AS vendorID -- using CAST, you can update the data type.
FROM
    `tutorial-analytics`
LIMIT 10
```

Take a look at the example on the right and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

## See also {#see-also}

* [SELECT](https://ydb.tech/docs/en/yql/reference/syntax/select).
* [YQL data types](https://ydb.tech/docs/en/yql/reference/types/).
* [Type casting in YQL](https://ydb.tech/docs/en/yql/reference/types/cast).
* [Functions for dates](https://ydb.tech/docs/en/yql/reference/udf/list/datetime).
