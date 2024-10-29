# Aggregating data

You can aggregate data results by fields.

For example:

* Calculate the number of taxi rides.
* Calculate the average tip amount.
* Group by taxi pick-up location (`PULocationID`).

```sql
SELECT
    PULocationID,
    COUNT(*) AS rides_count,    -- The COUNT aggregate function returns the number of rows
                                -- resulting from the query execution.
                                -- The asterisk (*) indicates that the COUNT function
                                -- counts the total number of rows in the table.
                                -- It counts each row separately.
                                -- The result includes rows that contain null values.
    AVG(tip_amount) AS avg_tip_amount
FROM
    `tutorial-analytics`
GROUP BY PULocationID           -- The column by which the data is aggregated.
```

Take a look at the example on the right and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

## See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select).
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by).
* [Aggregate functions]({{ ydb.docs }}/yql/reference/builtins/aggregation).
