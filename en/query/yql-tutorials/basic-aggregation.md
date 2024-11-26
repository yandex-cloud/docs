# Aggregating data

You can aggregate data results by fields.

For example:

* Calculate the number of taxi rides.
* Calculate the average tip amount.
* Group by taxi pick-up location (`PULocationID`).

```sql
SELECT
    PULocationID,
    COUNT(*) AS rides_count,    -- The COUNT aggregation function returns the number of rows
                                -- returned by the query.
                                -- Asterisk (*) indicates that COUNT
                                -- will count the total number of rows in the table.
                                -- The function counts each row separately.
                                -- This includes rows that contain null values.
    AVG(tip_amount) AS avg_tip_amount
FROM
    `tutorial-analytics`
GROUP BY PULocationID           -- Column to aggregate the data by.
```

View the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select).
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by).
* [Data aggregation function]({{ ydb.docs }}/yql/reference/builtins/aggregation).
