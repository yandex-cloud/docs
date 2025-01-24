```sql
SELECT gp_segment_id, count(*)
    FROM sample_table
    GROUP BY gp_segment_id;
```

The result will depend on the number of segments in the cluster. Distribution of strings by segments may vary as well.

Here is a possible result for a cluster with two segments:

```sql
gp_segment_id|count|
-------------+-----+
            0| 5013|
            1| 4987|
```
