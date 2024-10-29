
# Querying real-time data

You can process data from both {{ objstorage-full-name }} storage systems and {{ yds-full-name }} data stream buses.

The example below shows how to split input data into one-minute intervals and count the number of events and the total amount within each interval:

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

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select)
* [GROUP BY]({{ ydb.docs }}/yql/reference/syntax/group_by)
* [HOP](../concepts/stream-processing-windows.md)
* [Aggregate functions]({{ ydb.docs }}/yql/reference/builtins/aggregation)
