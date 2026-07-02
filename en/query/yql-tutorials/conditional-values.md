# Adding other aggregation conditions

You can aggregate data by both column values and expressions.

For example:

* Group taxi rides by long distance.
* Group taxi rides by short distance.
* Calculate the sum of grouped rides.

```sql
SELECT
    distance_type,
    COUNT(*)
FROM
    `tutorial-analytics`
GROUP BY                                -- CASE checks the list of conditions
    CASE                                -- and returns one of possible
        WHEN trip_distance > 10         -- expressions with any operator
        THEN "long"                     -- that supports this expression. For example, you can use CASE
        ELSE "short"                    -- in SELECT statements,
    END AS distance_type                -- inside an IN operator, and in WHERE, and ORDER BY clauses.
                                        -- You can use GROUP BY
                                        -- for any expression.
                                        -- The result will be available in the SELECT statement
                                        -- under the alias specified with the AS operator.
```

Check the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
The query result will appear in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or chart.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select)
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by)
* [CASE]({{ ydb.docs }}/yql/reference/syntax/expressions#case)
