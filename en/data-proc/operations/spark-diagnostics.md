---
title: How to diagnose and troubleshoot Spark application performance issues in {{ dataproc-full-name }}
description: Follow this guide to diagnose and troubleshoot Spark application performance issues.
---

# Diagnosing and troubleshooting Spark application performance issues

If your Spark applications are slow:

* [Check their execution](#diagnostics) to identify the cause of performance issues.
* Try using one of the [methods for troubleshooting common issues](#troubleshooting).

## Initial performance diagnostics of Spark applications {#diagnostics}

If your Spark application underperforms, run the initial diagnostics:

* [Check the application queue](./spark-monitoring.md#queue) to make sure your application is not getting blocked by others.
* [View detailed application info](./spark-monitoring.md#info) and check the jobs' statuses and actual start and end times on the **Event Timeline** chart.
* [Check the resources allocated to the application](./spark-monitoring.md#resources):

    * Make sure the application has enough executors and all available executors are not idle.
    * Make sure the resources within each executor are used in a balanced way.

* [Check the SQL query plans](./spark-monitoring.md#sql) and the execution time for each operation.
* [Check the application logs](./spark-monitoring.md#logs) for any warnings about failures.

## Troubleshooting common performance issues {#troubleshooting}

### High garbage collection time {#gc-time}

If you [checked the resources allocated to the application](./spark-monitoring.md#resources) and found out that the **GC Time** in the total **Task Time** is high:

{% include [gc-time-fix](../../_includes/data-processing/gc-time-fix.md) %}

### Multiple executors are competing for CPU resources {#cpu-wars}

When allocating executors, the YARN scheduler using the default settings ignores available CPU resources on the node. This may slow down compute-intensive jobs.

To avoid this, enable the alternative resource-aware scheduling algorithm for executors by setting the following cluster-level [property](../concepts/settings-list.md):

```text
capacity-scheduler:yarn.scheduler.capacity.resource-calculator=org.apache.hadoop.yarn.util.resource.DominantResourceCalculator
```

For more information about the YARN scheduler, see [this Hadoop guide](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html).

### Recurring heartbeat errors when running jobs {#heartbeat-errors}

When running Spark jobs, executors regularly send _heartbeat_ messages to the driver with info on the executor status and operation progress. If the driver does not get any heartbeat messages from an executor during a certain interval, it considers this executor unhealthy and requests the YARN resource manager to forcibly terminate it. In this case, the driver logs will contain a message of the following type:

```text
23/02/23 20:22:09 WARN TaskSetManager: Lost task 28.0 in stage 13.0 (TID 242) 
        (rc1c-dataproc-*****.{{ dns-zone }} executor 5): ExecutorLostFailure 
        (executor 5 exited caused by one of the running tasks) 
        Reason: Executor heartbeat timed out after 138218 ms
```

Such errors may be due to cluster networking issues. In practice, however, heartbeat timeouts most often occur because an executor runs out of memory. Consequently, job logs may fail to register such errors as `java.lang.OutOfMemoryError` because logging itself fails due to the memory shortage.

If you regularly get heartbeat errors when running jobs and there are no other signs of network errors, increase the amount of RAM allocated per concurrent operation. To do this, change your cluster's [component properties](../concepts/settings-list.md):

* Reduce the number of CPU cores per executor in the `spark.executor.cores` parameter.
* Increase the amount of RAM allocated per executor in the `spark.executor.memory` parameter.

For more information about these parameters, see [this Spark guide](https://spark.apache.org/docs/latest/configuration.html#available-properties).
