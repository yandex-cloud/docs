# Sorting and filtering data

When selecting data, you can specify filter expressions that will limit the result. You can also set the order of values returned.

For example:

* Find 10 rides with the largest tips.
* Exclude rides with a fare of over $1,000,000.

```sql
SELECT
    *
FROM
    `tutorial-analytics`
WHERE
    tip_amount > 0          -- List of conditions for generation of the result.
    AND                     -- The `AND` operator for complex conditions.
    total_amount < 1000000
ORDER BY tip_amount DESC    -- Sort the results by the `tip_amount` field values in descending order.
LIMIT 10                    -- Use only 10 entries.
```

View the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select)operator
* [WHERE]({{ ydb.docs }}/yql/reference/syntax/select#where) operator
* [ORDER BY]({{ ydb.docs }}/yql/reference/syntax/select#order-by) operator
