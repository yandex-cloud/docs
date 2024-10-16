# Adding other aggregation criteria

You can aggregate data by both column values and expressions.

For example:

* Group taxi rides by long distance.
* Group taxi rides by short distance.
* Calculate the total number of grouped rides.

```sql
SELECT
    distance_type,
    COUNT(*)
FROM
    `tutorial-analytics`
GROUP BY                                -- CASE checks the list of conditions
    CASE                                -- and returns one of multiple possible
        WHEN trip_distance > 10         -- expressions or with any operator
        THEN "long"                     -- that supports this expression. For example, you can use
        ELSE "short"                    -- in a SELECT
    END AS distance_type                -- and with the IN, WHERE, and ORDER BY operators.
                                        -- You can run GROUP BY
                                        -- for an arbitrary expression.
                                        -- The result will be available in a SELECT
                                        -- via an alias specified using AS.
```

Take a look at the example on the right and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

## See also {#see-also}

* [SELECT](https://ydb.tech/docs/en/yql/reference/syntax/select).
* [GROUP BY](https://ydb.tech/docs/en/yql/reference/syntax/group_by).
* [CASE](https://ydb.tech/docs/en/yql/reference/syntax/expressions#case).
