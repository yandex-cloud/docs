# Aggregating data

You can aggregate data results by fields.

For example:

* Calculate the number of taxi rides.
* Calculate the average tip amount.
* Group by taxi pick-up location (`PULocationID`).

```sql
SELECT
    PULocationID,
    COUNT(*) AS rides_count,    -- The COUNT aggregate function returns the number of rows,
                                -- returned by the query.
                                -- The asterisk (*) indicates that the COUNT function
                                -- counts the total number of rows in the table.
                                -- It counts each row separately.
                                -- The result includes rows that contain null values.
    AVG(tip_amount) AS avg_tip_amount
FROM
    bindings.`tutorial-analytics`
GROUP BY PULocationID           -- The column by which the data is aggregated.
```

Take a look at the block on the right and click ![run](../../_assets/query/run.svg) **Run**.
Query execution results are available in the **Result** tab as a table or schema.

## See also {#see-also}

* [SELECT](https://ydb.tech/en/docs/yql/reference/syntax/select).
* [GROUP BY](https://ydb.tech/en/docs/yql/reference/syntax/group_by).
* [Aggregate functions](https://ydb.tech/en/docs/yql/reference/builtins/aggregation).
