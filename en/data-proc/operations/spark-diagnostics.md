---
title: "How to perform diagnostics and troubleshooting of Spark application performance issues in {{ dataproc-full-name }}"
description: "Follow this guide to perform diagnostics and troubleshooting of Spark application performance issues."
---

# Diagnostics and troubleshooting of Spark application performance issues

If your Spark applications are slow:

* [Check their operation](#diagnostics) to identify the root cause of performance issues.
* Try using one of the [methods for troubleshooting common issues](#troubleshooting).

## Primary diagnostics of Spark application performance {#diagnostics}

If the performance of a Spark application is low, run primary diagnostics:

* [Check the application queue](./spark-monitoring.md#queue) to make sure the application's performance is not blocked by other applications.
* [View the application details](./spark-monitoring.md#info) and check the status of jobs and the time when they actually started and completed on the **Event Timeline** chart.
* [Check the resources allocated to the application](./spark-monitoring.md#resources):

   * Make sure the application has enough executors and the available executors are not idle.
   * Make sure the use of resources within a single executor is balanced.

* [Check the SQL query execution plans](./spark-monitoring.md#sql) and the duration of individual tasks.
* [Check the application logs](./spark-monitoring.md#logs) for warnings about failures.

## Troubleshooting common performance issues {#troubleshooting}

### High garbage collection time {#gc-time}

If you [checked the resources allocated to the application](./spark-monitoring.md#resources) and found out that the **GC Time** in the total **Task Time** is high:

{% include [gc-time-fix](../../_includes/data-proc/gc-time-fix.md) %}

### Multiple executors are competing for CPU resources {#cpu-wars}

When allocating executors, the YARN scheduler using the default settings does not consider the CPU resources available in a node. This may slow down jobs running resource-intensive computations.

To avoid this, enable an alternative algorithm for tracking resource availability during executor allocation by setting the following cluster-level [property](../concepts/settings-list.md):

```
capacity-scheduler:yarn.scheduler.capacity.resource-calculator=org.apache.hadoop.yarn.util.resource.DominantResourceCalculator
```

For more information about the YARN scheduler, see the [Hadoop documentation](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html).

### Regular heartbeat errors when running jobs {#heartbeat-errors}

When running Spark jobs, executors regularly send specific _heartbeat_ messages to the driver with their status and task progress. If the driver does not get any heartbeat messages from an executor during a certain interval, it considers this executor unhealthy and requests the YARN resource manager to forcibly terminate it. In this case, the driver logs will contain a message of the following type:

```text
23/02/23 20:22:09 WARN TaskSetManager: Lost task 28.0 in stage 13.0 (TID 242)
        (rc1c-dataproc-*****.mdb.yandexcloud.net executor 5): ExecutorLostFailure
        (executor 5 exited caused by one of the running tasks)
        Reason: Executor heartbeat timed out after 138218 ms
```

Such errors may be caused by cluster networking issues. However, in real terms, heartbeat timeouts most often occur because an executor runs out of memory. Moreover, job logs may fail to register such errors as `java.lang.OutOfMemoryError` due to a logging failure also caused by the memory shortage.

If you regularly get heartbeat errors when running jobs and there are no signs of network errors, increase the amount of RAM allocated per parallel task. To do this, change your cluster's [component properties](../concepts/settings-list.md):

* Reduce the number of CPU cores per executor in the `spark.executor.cores` parameter.
* Increase the amount of RAM reserved per executor in the `spark.executor.memory` parameter.

For more information about these parameters, see the [Spark documentation](https://spark.apache.org/docs/latest/configuration.html#available-properties).
