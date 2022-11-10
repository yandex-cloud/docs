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
    bindings.`tutorial-analytics`
GROUP BY                                -- CASE checks a list of conditions
    CASE                                -- and returns one of several possible
        WHEN trip_distance > 10         -- expression or with any other operator,
        THEN "long"                     -- supporting this expression. For example, you can use
        ELSE "short"                    -- in a SELECT
    END AS distance_type                -- and with the IN, WHERE, and ORDER BY operators.
                                        -- You can run GROUP BY
                                        -- for an arbitrary expression.
                                        -- The result will be available in a SELECT
                                        -- via an alias specified using AS.
```

Take a look at the block on the right and click ![run](../../_assets/query/run.svg) **Run**.
Query execution results are available in the **Result** tab as a table or schema.

## See also {#see-also}

* [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [GROUP BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/group_by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/group_by){% endif %}.
* [CASE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/expressions#case){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/expressions#case){% endif %}.
