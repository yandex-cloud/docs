---
title: Using the {{ GP }} command center
description: With the command center, you can manage sessions and queries and view their info.
---

# Using the {{ GP }} command center

{{ GP }} Command Center offers the following features:

* [Viewing information about sessions and queries](#list).
* [Viewing the resource consumption history for completed queries](#consumption-history).
* [Aborting the current session](#terminate-session).
* [Terminating the current query](#terminate-query).

Check out these [use cases](#examples) for how and when you can use the Command Center.

For more information about the statistics you can get using the Command Center, see [{#T}](../concepts/command-center.md).

{% note info %}

The {{ GP }} command center only allows you to perform basic operational analysis of sessions and queries. If your task requires in-depth strategic research and advanced analysis tools, use [log export to {{ cloud-logging-full-name }}](./mgp-to-cloud-logging.md). {{ cloud-logging-full-name }} allows you to [visualize logs in {{ grafana-name }}](../../logging/tutorials/grafana-logs-plugin.md) and [process them using {{ yds-short-name }} and {{ yq-name }}](../../logging/tutorials/cloud-logging.md).

{% endnote %}

## Viewing information about sessions and queries {#list}

You can view a list of sessions and queries with details on them. For each session, you can view its history and queries made within it. For each query, you can view its execution plan and a JSON file with details.

To view information about sessions and queries:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to the ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** tab.
    1. Select what you want to view and navigate to relevant tab:

        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** for the current sessions and queries.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** for sessions or queries at a given time point in the past.

    1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** or **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** section. In the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** tab, these are under the chart.
    1. To filter a session or query list, click ![image](../../_assets/console-icons/funnel.svg) **{{ ui-key.yacloud.common.label_filters }}** and select the relevant parameters.
    1. To view details for:

        * Sessions: Click the session name.
        * Queries: Click the key of the query you are running.

        For session and query parameters, see [{{ GP }} Command Center parameters](../concepts/command-center-parameters.md).

{% endlist %}

## Viewing the resource consumption history for completed queries {#consumption-history}

The resource consumption history includes a variety of system metrics. These show how a {{ GP }} cluster was consuming resources to process queries at different time points. You can also view a list of completed queries. Using this information, you can manage your cluster hosts' CPU and memory in such a way so as to process queries more effectively.

To view the resource consumption history for completed queries:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**.
    1. Select the consumption metric you need:

        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-running-time-seconds }}**: Time it took the CPU resources to process the queries, in seconds.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vm-peak-kb }}**: Maximum memory the cluster used to process a query during its lifetime.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-read-bytes }}**: Memory used for data reads, in bytes.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-write-bytes }}**: Memory used for data writes to the DB, in bytes.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-spill-total-bytes }}**: Additional disk memory used for query execution.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}**: Total request processing time.

        Once you select the consumption metric, you will see a chart with details and a list of queries. The chart will show the metric value, the user who ran the query, and the query execution time.

    1. To filter the results, click ![image](../../_assets/console-icons/funnel.svg) **{{ ui-key.yacloud.common.label_filters }}** and select the relevant parameters.

{% endlist %}

## Aborting the current session {#terminate-session}

To free up resources for sessions, you can abort a session with the `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle }}` status:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to the ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**tab.
    1. In **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**, click ![image](../../_assets/console-icons/ellipsis.svg) in the relevant line and select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.

        If you see **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**, select it and stop the query.

    1. Confirm stopping the session.

{% endlist %}

## Terminating the current query {#terminate-query}

To free up resources for queries, you can terminate a query with the `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle }}` status within an idle session. To do this:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to the ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**tab.
    1. In **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**, click ![image](../../_assets/console-icons/ellipsis.svg) in the relevant line and select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**.
    1. Confirm terminating the query.

{% endlist %}

## Current state analysis examples {#current-analysis}

The {{ GP }} command center supports the following types of cluster current state analysis:

* Metric analysis, e.g., [heavy session search](#heavy-session) or [query execution structure analysis](#nested-query).
* Event analysis, e.g., [idle session search](#current-session) or [blocking session search](#blocker-session).

### Heavy session search {#heavy-session}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Sort sessions by one of the following columns: **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**, or **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}**. 
    1. Find the sessions that consume the selected resource the most.
    1. For each selected session:
       1. Click the session number. The session info page will open.
       1. Compare the computing load and I/O load metrics (**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}**) against the overall load charts for the cluster or its individual hosts.
    1. Find which session has contributed the most to resource consumption.
    1. For details about the session's states at different points in time and to track the metrics' evolution over time, go to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_tab-session-history }}** tab.

    {% note info %}

    The query initiator is the only person who can find resource consumption issues within a given session, as the only one who knows the expected runtime of particular queries.

    {% endnote %}

{% endlist %}

### Query execution structure analysis {#nested-query}

You can identify queries that are inefficient due to their SQL statement logic or the sequence of operations.

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** tab.
    1. Enable displaying only active sessions by turning off all status buttons except **{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-active }}**.
    1. Filter the sessions by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
    1. Find a long-lived session with high **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}** values. Click its number to open its info page.
    1. Analyze the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-skew }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**, and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-retransmits }}** values.

       * If you see high values for **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**, and a non-zero value for **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-retransmits }}**:
         1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** tab.
         1. Apply the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-client-ssid }}** filter by specifying the transaction ID of the selected session.
         1. Sort queries by the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** column in descending order.
         1. Open execution plans for multiple queries.
         1. If you see `Gather` or `Gather Merge` after `Sort`, `Aggregate`, or `Distinct`, move `GROUP BY`/`DISTINCT`/`ORDER BY` to subqueries.
         1. If you get broad selections with a full set of columns, limit the results with the help of `LIMIT` or pagination, plus select only the columns you need and apply filters at the early stages of your query.

       * If you see a non-zero value for **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**:
         1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** tab.
         1. Apply the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-client-ssid }}** filter by specifying the transaction ID of the selected session.
         1. Sort queries by the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** column in descending order.
         1. Open execution plans for multiple queries.
         1. If you see subqueries with outer row dependency (`EXISTS` or `IN` with correlation) and the execution plan contains the `SubPlan` or `InitPlan` nodes, decorrelate such subqueries.
         1. If you see sorting or materialization followed by `WindowAgg` over large selections, apply pre-aggregation or filtering, and exclude unnecessary columns before applying the window functions.
         1. If you see `Sort` or `Distinct` at different nesting levels, reduce the number of such operations and their nesting depth.

       * If you see high **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** or **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}** values with non-zero **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-skew }}** values:
         1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** tab.
         1. Apply the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-client-ssid }}** filter by specifying the transaction ID of the selected session.
         1. Sort queries by the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** column in descending order.
         1. Open the execution plans for several queries and check how the joins are executed:
            * If joins are based on columns different from the actual table distribution key, rewrite your query.
            * If you are joining large sets but filters are either missing or applied after `JOIN`, use filtering in subqueries before `JOIN`.

{% endlist %}

### Idle session search {#current-session}

Let's assume the user is done working with the database but has left the session open. In which case the session will be idling while still consuming the cluster resources, thereby degrading its performance. To identify and terminate such a session, do the following:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Filter the sessions by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
    1. Find the longest-lasting session with the `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle }}` status. Click its number to open its info page.
    1. Look up the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-info }}** field under **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-started }}** to see when the last query was submitted.
    1. If the session is not executing any requests, and the client application's logic does not require the connection to be retained, you can terminate such a session. Do it by clicking **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}** in the top-right corner and confirm terminating the session.

{% endlist %}

### Blocking session search {#blocker-session}

In some cases, the session acquires table rows or metadata for a long time. This can create a queue of blocked sessions awaiting the resource acquisition. To find which session is the blocking one:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** tab.
    1. To display the blocking tree, click ![image](../../_assets/console-icons/branches-down.svg).
    1. Explore the blocking tree and identify the main blocking sessions. 
    1. For each blocking session, check the following:
        * Status; usually `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-active }}` or `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle-transaction }}`.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-state-changed }}** values.
        * Amount of consumed resources.
        * Number of blocked sessions.
        * Query text.
    1. If a blocking session remains `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-active }}` for a long time, all the while consuming the computing resources, a heavy query may be the cause. In which case you may want to optimize your queries and business logic.
    1. If a session is blocking many other sessions while being `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle-transaction }}` for a long time, you can terminate it after additional checks:
        1. Make sure **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** is not increasing and the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-waiting-reason }}** field is empty.
        1. In the top-right corner, click **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.
        1. Confirm stopping the session.

    {% note tip %}

    To prevent long-term blocking:
    * Optimize your queries and reduce the amount of data processed at any given time.
    * Separate interactive queries and heavy operations on the timeline.
    * Set query execution and blocking timeouts.

    {% endnote %}

{% endlist %}

## Examples of state history and consumption history analysis {#historical-analysis}

The {{ GP }} command center supports the following types of session and query history analysis:

* Metric analysis, e.g., [search for heavy queries](#past-statements) and [search for high network load queries](#net-load).
* Event analysis, e.g., [search for canceled queries and execution errors](#cancelations).

### Searching for CPU-intensive queries {#past-statements}

Let's assume that during a certain period a higher than usual CPU consumption is reported. To determine which queries caused the spikes, do the following:

{% list tabs group=instructions %}

- Management console {#console}

    1. Find out when the spike occurred:

        1. Open the [folder dashboard]({{ link-console-main }}).
        1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
        1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
        1. Set the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-cpu-usage }}** filter.
        1. Use the chart to find out when CPU consumption became abnormally high.

            Hover over the highest point on the chart curve. You will see a pop-up displaying the cluster state details for the selected time point. The window will include the time point when the spike occurred.

    1. Identify the CPU-intensive queries:

        1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}** tab.
        1. Set the time range based on the state history data.
        1. Group the queries by user, database, and query ID. This will group similar queries together.
        1. Filter the query groups by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**.
        1. Open the group with the highest **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** value.
        1. Examine the SQL text of your queries and their execution plans to figure out the cause of high CPU consumption.

       {% note tip %}

        The query initiator is the only one who can find CPU consumption issues within a given session; however, look for the following signs indicating that you need optimization:
        * Complex calculations and expressions executed line by line.
        * Sorting and aggregation without data filtering.
        * Multiple scans of large tables without using indexes or data distribution.
        * Re-calculations of subqueries or functions inside expressions.

       {% endnote %}

{% endlist %}

### Searching for high network load queries {#net-load}

{% list tabs group=instructions %}

- Management console {#console}

    1. Find the approximate time period when network issues and errors were observed, for example:

       * Cluster connection failure or slow response complaints.
       * Network anomalies and errors based on cluster logs and monitoring data. 

    1. Establish the cause of the errors:

        1. Open the [folder dashboard]({{ link-console-main }}).
        1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
        1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
        1. Set the time range during which errors were observed.
        1. In the drop-down list above the chart, select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-connections }}** and then **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-net-usage }}**. Compare the charts.
        1. If there are unusually high **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-net-usage }}** values, most likely, the errors are caused by abnormal network activity. 
        1. If there are unusually high **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-connections }}** values, most likely, the errors are caused by a spike in connections. 

    1. If the errors are caused by abnormal network activity:

        1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}** tab.
        1. Set the time range based on the state history data.
        1. Select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by-user }}**.
        1. Filter the query groups by the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}** columns.
        1. Find the user with the highest values in these columns. Filter the query groups by this user.
        1. Select **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by-query-id }}** and disable grouping by user.
        1. Find the queries that generated the most traffic. Save the text of these queries and their start time.
        1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** tab.
        1. Use the query text-based search to find the queries of interest.
        1. Identify the source of traffic using the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-application }}** column.
        1. Based on your analysis, tweak the applications generating abnormal network activity:
            * Limit the amount of upload data.
            * Use materialized views or temporary tables.
            * Optimize table distribution (DISTRIBUTED BY) and update table statistics prior to large inserts.
            * Review the ETL pipeline architecture.

    1. If the errors are caused by a spike in connections:

        1. Go to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** tab below the chart.
        1. Filter the sessions by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
        1. On the chart, select a time point with the highest **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-connections }}** values. Use the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-at-time }}** section and the **<** **>** arrows to set the exact time point.
        1. Use the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-user }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-application }}** filters to compare the number of new sessions per second for each source.
        1. If one source creates many more sessions than the others:
            * Check whether the application is reusing its connections.
            * Set the interval between retries and total number of attempts for reconnections.
        1. Optionally, edit the [connection manager](../concepts/pooling.md) settings based on your analysis.

{% endlist %}

### Searching for canceled queries and execution errors {#cancelations}

If the user complains about long wait times and connection losses but no other users report the same issues, this may indicate execution errors or canceled queries.

To find which queries were canceled or caused execution errors, proceed as follows:

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
    1. Click the cluster name and navigate to ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
    1. Navigate to the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** tab.
    1. Select a time point when issues were reported by the monitoring data. Use the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-at-time }}** section and the **<** **>** arrows to set the exact time point.
    1. Filter the queries by the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-status }}** column.
    1. Find queries with the `{{ ui-key.yacloud.greenplum.perf-diag.label_query-status-canceled }}` or `{{ ui-key.yacloud.greenplum.perf-diag.label_query-status-error }}` status.
    1. Establish the query sources based on the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-user }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-application }}** columns. Optionally, use the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-user }}** and **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-application }}** filters.
    1. If one source generates significantly more canceled and failed queries than the others:
  
       * Check and, optionally, optimize business logic and the structure of your SQL queries.

         Pay special attention to frequent full selections, lack of data filtering, redundant table joins, or nested subqueries.

       * Set the interval between reconnections and the total number of attempts.

    1. Optionally, use the [connection manager](../concepts/pooling.md) to limit the number of concurrent active connections and balance the load between clients.
    
       The optimal parameters depend on the number of segments and cluster resources.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
