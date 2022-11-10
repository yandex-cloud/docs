# Sorting and filtering data

When selecting data, you can specify filter expressions that will limit the result. You can also set the order of values returned.

For example:

* Find 10 rides with the largest tips.
* Exclude rides with a fare of over $1000000.

```sql
SELECT
    *
FROM
    bindings.`tutorial-analytics`
WHERE
    tip_amount > 0          -- List of conditions to generate a result.
    AND                     -- Operator AND for complex conditions.
    total_amount < 1000000
ORDER BY tip_amount DESC    -- Sort the result by the descending tip_amount values.
LIMIT 10                    -- Use only 10 entries.
```

Take a look at the block on the right and click ![run](../../_assets/query/run.svg) **Run**.
Query execution results are available in the **Result** tab as a table or schema.

## See also {#see-also}

* [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [WHERE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#where){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#where){% endif %}.
* [ORDER BY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select#order-by){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select#order-by){% endif %}.
