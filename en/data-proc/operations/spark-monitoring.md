---
title: How to monitor the state of Spark applications in {{ dataproc-full-name }}
description: Follow this guide to monitor the state of Spark applications.
---

# Monitoring the state of Spark applications

To evaluate the performance of Spark applications in a {{ dataproc-name }} cluster, you can check the following:

* [Application list](#list)
* [Application logs](#logs)
* [Application queue](#queue)
* [Application details](#info)
* [Resources allocated to the application](#resources)
* [Persisted RDDs](#tables)
* [List of SQL queries and their execution plans](#sql)

{% note info %}

Make sure the cluster has the [component web interfaces](../concepts/interfaces.md) enabled. If it does not, [enable the ones you need](./connect-interfaces.md#ui-proxy-enable).

{% endnote %}

## Checking the application list {#list}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `YARN Resource Manager Web UI` interface.

It shows information about all running and completed applications.

## Checking application logs {#logs}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `YARN Resource Manager Web UI` interface.
1. Find the application you need and click its ID in the **ID** column.

    This will open a window with information about the application's performance and a table with a list of application run attempts.

1. Click the link next to the attempt in question in the **Logs** column.

## Checking the application queue {#queue}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `YARN Resource Manager Web UI` interface.
1. In the left-hand menu, go to **Scheduler**.

The **Application Queues** section shows the queue of applications and resources used by them.

## Checking application details {#info}

{% list tabs %}

* YARN Resource Manager Web UI

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name.
    1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `YARN Resource Manager Web UI` interface.
    1. Find the application in question and follow the link in the **Tracking UI** column. The link name depends on the application status:

        * **ApplicationMaster** for running applications
        * **History** for finished applications

* Spark History Server Web UI

    1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name.
    1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `Spark History Server Web UI` interface.

        This will open the list of finished applications. To switch to the list of running applications, click **Show incomplete applications** at the bottom of the table.

    1. Find the application in question and follow the link in the **App ID** column.

{% endlist %}

This will open the **Spark History Server Web UI** window with details of the selected application:

* **Event Timeline**: History of job runs with info about added and removed [executors](../concepts/spark-sql.md#tasks)
* **Active Jobs**: List of jobs being run or waiting to be run.
* **Completed Jobs**: List of finished jobs.

For each job, the table specifies:

* Start time (**Submitted**)
* **Duration**
* **Stages: Succeeded/Total**
* **Tasks: Succeeded/Total**

## Checking resources allocated to the application {#resources}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `Spark History Server Web UI` interface.
1. In the top menu, go to **Executors**.

The UI will display two tables:

* **Summary**: High-level information, such as the number and status of [executors](../concepts/spark-sql.md#tasks) and resources used.
* **Executors**: Information about each executor.

The tables specify the following:

* Amount of resources available per resource executor.
* Number of running and completed [tasks](../concepts/spark-sql.md#tasks).
* Task duration (**Task Time**), including the time spent for garbage collection (**GC Time**).

{% note tip %}

If garbage collection takes much time:

{% include [gc-time-fix](../../_includes/data-processing/gc-time-fix.md) %}

{% endnote %}

## Checking persisted RDDs {#tables}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `Spark History Server Web UI` interface.
1. In the top menu, go to **Storage**.

The UI displays the list of cacheable tables ([RDDs](https://spark.apache.org/docs/latest/rdd-programming-guide.html#resilient-distributed-datasets-rdds)). For each RDD, it shows information about the used memory and disk space, as well as caching progress.

To view detailed statistics, click the RDD name.

## Checking the list of SQL queries and their execution plans {#sql}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click the cluster name.
1. Under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**, select the `Spark History Server Web UI` interface.
1. In the top menu, go to **SQL**.

The table lists executed SQL queries, including their start time and duration.

To see the query execution plan, click the query text in the **Description** column. The query execution plan is displayed as a flowchart. To view it as text, click **Details** at the bottom of the figure.

The query execution plan contains statistics for each operator with the number of completed tasks and their duration. If the query is still running, the current statistics will be shown.
