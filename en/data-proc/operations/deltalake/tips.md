---
title: Tips for configuring and using Delta Lake
description: This article gives you tips on how to configure and use Delta Lake.
---

# Tips for setting up and using Delta Lake

## Optimizing data writes to S3-compatible storage {#s3-algorithm}

If part of the job data uses formats other than Delta Lake tables, [configure S3A committers](../../tutorials/copy-files-from-object-storage.md#s3a-committers) to optimize data writes to S3-compatible storage.

If all job data resides in Delta Lake tables, you do not need to configure S3A committers. Delta Lake uses its own algorithm to manage data writes to S3-compatible storage. It is functionally equivalent to S3A committers.

## Boosting the OPTIMIZE operator efficiency {#optimize}

The [OPTIMIZE operator](https://docs.delta.io/latest/optimizations-oss.html#compaction-bin-packing) in Delta Lake 2.0.2 improves table data read query performance by merging multiple small files into larger ones. This merging runs as multiple concurrent jobs. You can set the maximum number of such concurrent jobs using the `spark.databricks.delta.optimize.maxThreads` [property](../../concepts/settings-list.md). By default, it is `10`.

To speed up the optimization when handling large tables, [increase](../../concepts/settings-list.md#change-properties) the `spark.databricks.delta.optimize.maxThreads` property value. You can use much higher values, e.g., `100` or `1000`, if the cluster resources allow running that many concurrent operations.

## Syntax for converting partitioned tables {#partitioned-syntax}

The `CONVERT TO DELTA` operator converts standard Spark SQL tables to Delta Lake format. To convert a partitioned table, specify the partitioning columns in the query:

```sql
CONVERT TO DELTA table_name PARTITIONED BY (part_col_1 INT, part_col_2 INT);
```

## Forced cleanup of table change history {#forced-vacuum}

By default, Delta Lake stores the history of table changes for 30 days. This period is set at the table level in the `delta.logRetentionDuration` parameter. You can edit it using this command:

```sql
ALTER TABLE <table_schema_and_name> SET TBLPROPERTIES ('delta.logRetentionDuration' = "interval <interval>")
```
For more on managing table properties, see [this Delta Lake article](https://docs.delta.io/latest/delta-batch.html#table-properties).


To forcibly clean up the table change history:

1. Rearrange the table data to optimize access performance:

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
