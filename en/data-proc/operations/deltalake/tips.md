# Tips for setting up and using Delta Lake

## Optimizing data writes to S3-compatible storage {#s3-algorithm}

If the format of some data within a job differs from that of Delta Lake tables, to optimize data writes to S3-compatible storage, [configure S3A committers](../../tutorials/copy-files-from-object-storage.md#s3a-committers).

If all data within a job is stored in Delta Lake tables, there is no need to configure S3A committers. Delta Lake uses its own algorithm to control data writes to S3-compatible storage. Its functionality is equivalent to that of S3A committers.

## Boosting OPTIMIZE operator performance {#optimize}

The [OPTIMIZE operator](https://docs.delta.io/latest/optimizations-oss.html#compaction-bin-packing) in Delta Lake 2.0.2 speeds up requests to read table data by merging multiple small files into larger ones. This merge is performed within several concurrent jobs. The maximum number of such concurrent jobs is set by the `spark.databricks.delta.optimize.maxThreads` [property](../../concepts/settings-list.md) and amounts to `10` by default.

To speed up the optimization procedure when handling large tables, [increase](../../concepts/settings-list.md#change-properties) the property value. You can use much larger values, e.g., `100` or `1000`, if the cluster resources allow running so many concurrent operations.

## Syntax for converting partitioned tables {#partitioned-syntax}

The `CONVERT TO DELTA` operator converts standard Spark SQL tables to Delta Lake format. To convert a partitioned table, specify partitioning columns in the request:

```sql
CONVERT TO DELTA table_name PARTITIONED BY (part_col_1 INT, part_col_2 INT);
```

## Forcing table change history cleanup {#forced-vacuum}

By default, Delta Lake stores the history of table changes for 30 days. The retention period is set at the table level in the `delta.logRetentionDuration` parameter and can be edited using this command:

```sql
ALTER TABLE <table_schema_and_name> SET TBLPROPERTIES ('delta.logRetentionDuration' = "interval <interval>")
```

To learn more about managing the table parameters, see the [Delta Lake documentation](https://docs.delta.io/latest/delta-batch.html#table-properties).

To force the table change history cleanup:

1. Rearrange the table data to optimize the access:

   ```sql
   OPTIMIZE <table_name>;
   ```

1. Allow deleting the entire history of changes:

   ```sql
   SET spark.databricks.delta.retentionDurationCheck.enabled = false;
   ```

1. Clear the change history:

   ```sql
   VACUUM <table_name> RETAIN 0 HOURS;
   ```
