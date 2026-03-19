---
title: How to diagnose performance issues in Spark applications in {{ msp-full-name }}
description: Follow this guide to diagnose performance issues in Spark applications.
---

# Diagnostics and examples of troubleshooting performance issues in Spark applications

If your Spark applications are slow:

* [Check their execution](#diagnostics) to identify the cause of performance issues.
* Try using one of the [examples below to troubleshoot your performance issues](#examples-scenarios).

## Initial Spark application performance diagnostics {#diagnostics}

If your Spark application underperforms, run the initial diagnostics:

* [Check the state of the cluster and its hosts](monitoring.md) and make sure the metrics are within normal limits.
* [View detailed application info](spark-monitoring.md#info) and check the jobs' statuses, actual start and end times on the **Event Timeline** chart:
   * Identify jobs that take the most time.
   * Look into jobs that threw an error and find out why.
   * Analyze the overall application execution time.
   * Check the sequence of actions.

* [View detailed info on stages](spark-monitoring.md#stages):
   * Identify stages that take the most time.
   * Analyze shuffle operations to detect excessive data movement.
   * Pay attention to the **GC Time** metric: a high value may indicate memory issues.
   * Look at **DAG Visualization** to understand the sequence and dependencies between operations.

* [Check the resources allocated to the application](spark-monitoring.md#resources):
    * Make sure the application has enough executors and the available ones are not idle.
    * Make sure the resources within each executor are used in a balanced way.

* [Check the SQL query plans](spark-monitoring.md#sql) and the execution time for each operation.

## Examples of troubleshooting performance issues in Spark applications {#examples-scenarios}

### Slow data loading from S3 {#s3-long}

Issue: Long Spark application execution time.

#### Diagnostic steps

1. Identify the affected job.
   
   * Open the **Jobs** tab in **Spark History Server**.
   * Compare **Duration** across different jobs.
   * Find the job that takes the most time.

1. Analyze the affected job's stages.

   * Navigate to the affected job and open the **Stages** tab.
   * Sort the stages by **Duration**.
   * Analyze the stages that take the most time.
   * Check the **Input Size** metrics to figure the amount of read data.

   Result: You have found the stage responsible for reading data from S3.

1. Check the cluster monitoring metrics.

   Check metrics related to vCPU.

   Result: You have detected near-full vCPU utilization during the data read stage.

Data loading from S3 takes place over the internet and is limited by available vCPU resources. The more vCPUs you have, the faster Spark is able to process the incoming data stream.

#### Solution

To fix the issue, we recommend increasing the number of cluster host vCPUs.

### Poor parallelism on a cluster with a large number of vCPUs {#bad-parallelism}

Issue: Inefficient utilization of vCPU resources due to insufficient number of tasks, leading to core idling and increased execution time.

#### Diagnostic steps

1. Cluster resource utilization check.

   Check the cluster's configuration and available vCPU resources.

1. Analysis of **Spark History Server** stages.
   
   * Open the **Stages** tab in **Spark History Server**.
   * Sort stages by **Duration**.
   * Select the longest stage.
   * Pay attention to the **Total Tasks** column representing the total number of tasks per stage.
   * Correlate the number of tasks to the number of available vCPUs.

   Result: You have found the stage that lacks tasks. Some cores are executing one job each, while others are executing two. Some cores are idle.

#### Solution

To fix the issue, we recommend breaking the stages down into smaller sub-operations. Increase the number of partitions for shuffle operations by configuring the `spark.sql.shuffle.partitions` property to achieve a more even work distribution.
