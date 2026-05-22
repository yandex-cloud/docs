---
title: How to monitor the state of Spark applications in {{ msp-full-name }}
description: Follow this guide to monitor the state of Spark applications.
---

# Monitoring the state of Spark applications

To assess the performance of Spark applications in a {{ msp-full-name }} cluster, you can check the following:

* [Application details](#info)
* [Detailed information about the stages](#stages)
* [Resources allocated to the application](#resources)
* [Persisted RDDs](#tables)
* [List of SQL queries and their plans](#sql)

## Checking application details {#info}

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**, select **Spark History Server** and click the link.

   This will open the list of completed applications. To switch to the list of running applications, click **Show incomplete applications** at the bottom of the table.

1. Find the application in question and click the link in the **App ID** column.

   This will open the **Jobs** tab in the **Spark History Server** window with detailed information about the selected application:

   * **Event Timeline**: Job run history as a diagram. It displays markers for [executor](../concepts/index.md#concepts) allocation and release and job statuses.
   * **Active Jobs**: List of running or pending jobs.
   * **Completed Jobs**: List of completed jobs.

   For each job, the table specifies:

   * **Submitted** time
   * **Duration**
   * **Stages: Succeeded/Total**
   * **Tasks (for all stages): Succeeded/Total**

## Checking stage details {#stages}

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**, select **Spark History Server** and click the link. This will open the **Spark History Server** window.
1. In the top menu, navigate to **Stages**.

   There you will find the **Completed Stages** table listing all the job stages. For each stage, it provides the following details:
   * **Submitted** time
   * **Duration**
   * **Tasks: Succeeded/Total**
   * **Shuffle Read/Write** size
   * **Input/Output** data size

   To get detailed information about a stage, click the text in the **Description** column. The **Details for Stage** page displays the following:
   * **DAG Visualization**: Execution graph visualization.
   * **Event Timeline**: Stage run history as a diagram with various indicators.
   * Summary operation metrics:
      * **Duration**: Run duration.
      * **GC Time**: Garbage collection time.
      * **Input Size/Records**: Size of input and written data.
   * **Aggregated Metrics by Executor**: Metrics by executor.
   * **Tasks**: Table with operation details.

## Checking resources allocated to the application {#resources}

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**, select **Spark History Server** and click the link. This will open the **Spark History Server** window.
1. In the top menu, navigate to **Executors**.

   The UI displays two tables:

   * **Summary**: High-level information, such as the number and status of [executors](../concepts/index.md#concepts) and resources in use.
   * **Executors**: Information about each executor.

   The tables specify the following:

   * Amount of resources available per executor.
   * Number of running and completed [tasks](../concepts/index.md#job).
   * Task duration (**Task Time**), including the time spent on garbage collection (**GC Time**).

   {% note tip %}

   If garbage collection takes much time:

   {% include [gc-time-fix](../../_includes/data-processing/gc-time-fix.md) %}

   {% endnote %}

## Checking persisted RDDs {#tables}

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**, select **Spark History Server** and click the link. This will open the **Spark History Server** window.
1. In the top menu, navigate to **Storage**.

   The UI displays the list of persisted resilient distributed datasets ([RDDs](https://spark.apache.org/docs/latest/rdd-programming-guide.html#resilient-distributed-datasets-rdds)). For each RDD, it shows memory consumption, disk usage, and caching progress.

   To view details, click the RDD name.

## Checking the list of SQL queries and their plans {#sql}

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_additional }}**, select **Spark History Server** and click the link. This will open the **Spark History Server** window.
1. In the top menu, navigate to **SQL/DataFrame**.

   The table lists executed SQL queries, including their start time and duration.

   To see the query plan, click the query text in the **Description** column. The query plan is displayed as a flowchart. To view it as text, click **Details** at the bottom of the figure.

   The query plan contains stats for each operator along with the number of completed tasks and their duration. If the query is still running, the current stats will be shown.