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
GROUP BY                                -- CASE checks a list of conditions
    CASE                                -- and returns one of several possible
        WHEN trip_distance > 10         -- expressions or an expression with any operator
        THEN "long"                     -- that supports the expression in question. For example, you can use CASE
        ELSE "short"                    -- in SELECT expressions
    END AS distance_type                -- and with operators IN, WHERE, and ORDER BY.
                                        -- You can run GROUP BY
                                        -- for any expression.
                                        -- The result is available in SELECT
                                        -- via an alias specified using AS.
```

View the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select)
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by)
* [CASE]({{ ydb.docs }}/yql/reference/syntax/expressions#case)
