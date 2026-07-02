
# Querying real-time data

You can process data from both {{ objstorage-full-name }} storage systems and {{ yds-full-name }} data streaming buses.

The example below shows how to split input data into one-minute intervals, count the number of events within each interval, and calculate the totals per interval:

```sql
SELECT
    HOP_END() AS time,
    COUNT(*) AS ride_count,
    SUM(total_amount) AS total_amount
FROM
(
    SELECT
        *
    FROM
        bindings.`tutorial-streaming`
    LIMIT 10
)
GROUP BY
    HOP(Just(CAST(tpep_pickup_datetime AS Timestamp)), "PT1M", "PT1M", "PT1M");
```

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select) operator
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by) operator
* [HOP](../concepts/stream-processing-windows.md) operator
* [Data aggregation function]({{ ydb.docs }}/yql/reference/builtins/aggregation)
