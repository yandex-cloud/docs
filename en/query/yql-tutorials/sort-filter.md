# Sorting and filtering data

When selecting data, you can specify filter expressions that will limit the result. You can also set the order of values returned.

For example:

* Find 10 rides with the largest tips.
* Exclude rides with a fare of over  $1,000,000.

```sql
SELECT
    *
FROM
    `tutorial-analytics`
WHERE
    tip_amount > 0          -- List of conditions to get the result.
    AND                     -- Operator AND for complex conditions.
    total_amount < 1000000
ORDER BY tip_amount DESC    -- Sort the result by the descending tip_amount values.
LIMIT 10                    -- Use only 10 entries.
```

Take a look at the block on the right and click ![run](../../_assets/console-icons/play-fill.svg) **Run**.
Query execution results are available in the **Result** tab as a table or schema.

## See also {#see-also}

* [SELECT](https://ydb.tech/en/docs/yql/reference/syntax/select).
* [WHERE](https://ydb.tech/en/docs/yql/reference/syntax/select#where).
* [ORDER BY](https://ydb.tech/en/docs/yql/reference/syntax/select#order-by).
