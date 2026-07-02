# Data sorting and filtering

When querying data, you can order the selection results and limit them using filters.

For example:

* Find 10 rides with the largest tips.
* Filter out rides with a fare above $1,000,000.

```sql
SELECT
    *
FROM
    `tutorial-analytics`
WHERE
    tip_amount > 0          -- Result filtering conditions.
    AND                     -- Combining conditions.
    total_amount < 1000000
ORDER BY tip_amount DESC    -- Sort results by `tip_amount` in descending order.
LIMIT 10                    -- Retrieve only 10 rows.
```

Check the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
The query result will appear in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or chart.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select) operator
* [WHERE]({{ ydb.docs }}/yql/reference/syntax/select#where) operator
* [ORDER BY]({{ ydb.docs }}/yql/reference/syntax/select#order-by) operator
