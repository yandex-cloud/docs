# Aggregating data

You can aggregate results by fields.

For example:

* Calculate the number of taxi rides.
* Calculate the average tip size.
* Group by taxi pick-up location (`PULocationID`).

```sql
SELECT
    PULocationID,
    COUNT(*) AS rides_count,    -- The COUNT aggregate function returns the number of rows
                                -- produced by the query.
                                -- The asterisk (*) means that the COUNT function
                                -- will count every row in the table.
                                -- The function counts each separate row,
                                -- including rows containing null values.
    AVG(tip_amount) AS avg_tip_amount
FROM
    `tutorial-analytics`
GROUP BY PULocationID           -- The field that data is grouped by.
```

Check the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
The query result will appear in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or chart.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select).
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by).
* [Data aggregation function]({{ ydb.docs }}/yql/reference/builtins/aggregation).
