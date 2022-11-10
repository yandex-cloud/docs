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
    bindings.`tutorial-analytics`
LIMIT 10
```

Take a look at the block on the right and click ![run](../../_assets/query/run.svg) **Run**.
Query execution results are available in the **Result** tab as a table or schema.

## See also {#see-also}

* [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [YQL data types]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/types/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/types/){% endif %}.
* [Type casting in YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/types/cast){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/types/cast){% endif %}.
* [Functions for dates]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/udf/list/datetime){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/udf/list/datetime){% endif %}.
